--print("Bomber.Core")
--local _,duration= GetSpellCooldown(61304); -- Global Cooldown


ABILITY_TABLE = { };
EVENT_MODS    = { };
COMBATLOG_MODS= { };
LAST_TARGET   = 0;

-- Константы горячих клавиш
mkLeftShift     = 1;
mkLeftControl   = 2;
mkLeftAlt       = 3;
mkRightShift    = 4;
mkRightControl  = 5;
mkRightAlt      = 6;

-- Ауры, которые позволяют произносить заклинания на ходу
moving_spell_table = {
    97128,  -- Опаляющее перо (Алисразор)
    108839, -- Плавучая льдина
    165803, -- Награнд (талбук)
};

--SetPOIIconOverlapDistance(12.00);
EVENT_MODS.MODIFIER_STATE_CHANGED = nil;

-- Возвращает, есть ли один из перечисленных бафов на персонаже
-- Возвращает:
--  Имя эффекта
--  Количество стаков
--  Оставшееся время действия
--  value1, value2, value3 - Величина эффекта
-- Параметры:
--  unit - Цель ("palyer", "target", "focus", "mouseover")
--  {...} - перечень бафов
--  filter - фильтр
function HasBuff(unit, spellId, filter)
    local spell_table = { };
    if type(spellId) == "table" then
        spell_table = spellId;
    elseif type(spellId) == "number" then
        spell_table = { spellId };
    end

    for _,spell_id in ipairs(spell_table) do
        local spellName, spellRank = GetSpellInfo(spell_id);
        if spellName then
            -- name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3
            local name,_,_,count,_,_,expires,_,_,_,_,_,_,value1,value2,value3 = UnitBuff(unit, spellName, spellRank, filter);
            if name then
                local rem = min(max((expires or 0) - (GetTime() - (AddonFrame.ping or 0)), 0), 0xffff);
                return name, count, rem, value1, value2, value3;
            end
        end
    end
    return nil, 0, 0, nil, 0, 0;
end

-- Возвращает, есть ли один из перечисленных дебафов на персонаже
-- Возвращает:
--  Имя эффекта
--  Количество стаков
--  Оставшееся время действия
--  value1, value2, value3 - Величина эффекта
-- Параметры:
--  unit - Цель ("palyer", "target", "focus", "mouseover")
--  {...} - перечень дебафов
--  filter - фильтр
function HasDebuff(unit, spellId, filter)
    local spell_table = { };
    if type(spellId) == "table" then
        spell_table = spellId;
    elseif type(spellId) == "number" then
        spell_table = { spellId };
    end

    for _,spell_id in ipairs(spell_table) do
        local spellName, spellRank = GetSpellInfo(spell_id);
        if spellName then
            -- name, rank, icon, count, dispelType, duration, expires, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3
            local name,_,_,count,_,_,expires,_,_,_,_,_,_,value1,value2,value3 = UnitDebuff(unit, spellName, spellRank, filter);
            if name then
                local rem = min(max((expires or 0) - (GetTime() - (AddonFrame.ping or 0)), 0), 0xffff);
                return name, count, rem, value1, value2, value3;
            end
        end
    end
    return nil, 0, 0, nil, 0, 0;
end

-- Вызвращает время до восстановления заклинания
-- Параметр: ид заклинания
function SpellCD(m_spell)
    local start, duration, enable = GetSpellCooldown(m_spell);
    local cooldown = duration + start - GetTime();
    return (cooldown > 0 and cooldown - (AddonFrame.ping or 0) or 0), enable;
end

-- Проверка, двигается ли игрок, за исключением бафов, которые дают возможность кастровать на ходу
-- на пример: Опаляющее перо (Алисразор), Благосклонность предков (Шанам)
function IsMoving()
    for _, spell in ipairs(moving_spell_table) do
        local name,rank = GetSpellInfo(spell);
        if name and UnitAura("player", name, rank, nil) then
            return;
        end
    end
    return GetUnitSpeed("player") ~= 0 or IsFalling();
end

-- возвращает текущее значение здоровья в процентах
function HealthByPercent(m_target)
    return UnitExists(m_target) and 100 * (UnitHealth(m_target) or 1) / (UnitHealthMax(m_target) or 1) or 0;
end

-- возвращает текущее значение ресурса (мана, энергия, фокус, ярость ...) в процентах
function PowerByPercent(m_target, m_powertype)
    return UnitExists(m_target) and 100 * (UnitPower(m_target, m_powertype) or 1) / (UnitPowerMax(m_target, m_powertype) or 1) or 0;
end

-- Проверка, была ли зажата клавиша модификатор mk*
function IsModKeyDown(m_key)
    if not GetCurrentKeyBoardFocus() then
        return  (m_key == mkLeftShift    and IsLeftShiftKeyDown()   ) or
                (m_key == mkLeftControl  and IsLeftControlKeyDown() ) or
                (m_key == mkLeftAlt      and IsLeftAltKeyDown()     ) or
                (m_key == mkRightShift   and IsRightShiftKeyDown()  ) or
                (m_key == mkRightAlt     and IsRightAltKeyDown()    ) or
                (m_key == mkRightControl and IsRightControlKeyDown());
    end
end

-- Возвращает дистанцию между двумя игроками
function GetDistance(unit1, unit2)
    local lvl, a1, b1, a2, b2 = GetCurrentMapDungeonLevel();
    if not (a1 and b1 and a2 and b2) then
        lvl, a1, y1, a2, y2 = GetCurrentMapZone();
    end
    if a1 and b1 and a2 and b2 then
        local x1, y1 = GetPlayerMapPosition(unit1);
        local x2, y2 = GetPlayerMapPosition(unit2);
        local dX = ((x1 - x2) * abs(a2 - a1)) ^ 2;
        local dY = ((y1 - y2) * abs(b2 - b1)) ^ 2;
        return sqrt(dX + dY);
    end
end

-- Возвращает ID юнита
function UnitId(unit)
    return tonumber((UnitGUID(unit) or ""):match("-(%d+)-%x+$"), 10);
end

-- Проверяет, надо ли сбивать заклинание текущему юниту.
function CheckInterrupt(unit, sec)
    -- чтение заклинания прерываем только перед окончанием каста.
    local name,_,_,_,startTime,endTime,isTrade,_,notInterruptible = UnitCastingInfo(unit);
    if name and not (notInterruptible or isTrade) then
        if (((endTime / 1000) - GetTime()) - AddonFrame.ping) <= (sec or 1) then
            return true;
        end
    end
    -- канальное заклинание прерываем сразу.
    local name,_,_,_,_,_,isTrade,notInterruptible = UnitChannelInfo(unit);
    if name and not (notInterruptible or isTrade) then
        return true;
    end
end

-- Проверяет наличие исступления.
function CheckEnrage(unit, ...)
    if UnitCanAttack("player", unit) then
        -- Исступление отображается как пустая строка
        local dispels = { "", ... };
        for i = 1, 40 do
            local name,_,_,_,dispelType = UnitBuff(unit, i);
            if not name then
                return;
            end
            for _, dispell in ipairs(dispels) do
                if dispelType == dispell then
                    return true;
                end
            end
        end
    end
end

function SetInRangeSpell(rangeSpell)
    AddonFrame.RangeSpell = nil;
    if (rangeSpell or 0) > 0 then
        local name = GetSpellInfo(rangeSpell);
        if not name then
            assert("Unknown spell by Id "..tostring(rangeSpell))
        end
        if not SpellHasRange(name) then
            assert("Spell "..tostring(rangeSpell).." "..name.."not have range");
        end
        AddonFrame.RangeSpell = name;
    end
end

PLAYER = {
    HP   = 0,
    Agro = 0,
    IsMoving  = false,
    IsMounted = false,

    Init = function(self)
        self.HP = 100 * (UnitHealth("player") or 1) / (UnitHealthMax("player") or 1) or 0;
        self.IsMoving = IsMoving("player");
        self.IsMounted= IsMounted() and not HasBuff("player", 165803);
        self.Agro     = UnitThreatSituation("player") or 0;

        if PLAYER.HP < 30 and UnitAffectingCombat("player") and not PLAYER.IsMounted then
            local _, durationH, enableH = GetItemCooldown(5512);   -- Камень здоровья
            local _, durationP, enableP = GetItemCooldown(109223); -- Лечебное снадобье
            if durationH == 0 and enableH and GetItemCount(5512) > 0 then
                UseItemById(5512);
            elseif durationP == 0 and enableP and GetItemCount(109223) > 0 then
                UseItemById(109223);
            end
        end
    end,
};


---------------------------------------
--              CORE                 --
---------------------------------------
function CheckKnownAbility(ability)
    ability.SpellName = GetSpellInfo(ability.SpellId);
    ability.IsKnown = false;

    if not ability.SpellName then
        print("|cff15bd05Ability: "..ability.Name..", invalid spell id ", ability.SpellId.."|r")
        return;
    end

    -- Основная проверка
    if IsPlayerSpell(ability.SpellId)
        or IsSpellKnown(ability.SpellId) or IsSpellKnown(ability.SpellId, true)
        or IsTalentSpell(ability.SpellName) then
        ability.IsKnown = true;
        return;
    end

    local spec = GetSpecialization();
    if spec then
        -- Проверка на доступность заклинания по уровню и специализиции
        local spellList = { GetSpecializationSpells(spec) };
        local lvl = UnitLevel("player");
        for i = 1, #spellList, 2 do
            if spellList[i] == ability.SpellId and lvl > (spellList[i+1] or 0) then
                ability.IsKnown = true;
                return;
            end
        end
    end

    -- Есть заклинания, которые имеют одинаковое название и разные Id
    local spellId = select(2, GetSpellBookItemInfo(ability.SpellName));
    if spellId and ability.SpellId ~= spellId then
        print(string.format("|cff15bd05Заклинание: %s Id %d -> %d|r", ability.SpellName, ability.SpellId, spellId));
        ability.SpellId = spellId;
        ability.IsKnown = true;
    end
end

-- Проверяем доступность заклинаний
function CheckAllSpells()
    if type(ABILITY_TABLE) == "table" then
        for _,ability in ipairs(ABILITY_TABLE) do
            if ability.SpellId > 0 then
                CheckKnownAbility(ability);
            end
        end
    end
end

function CheckAndCastAbility(ability, targetInfo)

    BomberFrame.SetKey();
    
    if ability.IsCheckInCombat and not UnitAffectingCombat("player") then
        return;
    end

    if ability.RecastDelay > 0
        and targetInfo.Guid == UnitGUID(targetInfo.Target)
        and ((targetInfo.LastCastingTime or 0) + ability.RecastDelay) >= GetTime() then
        return;
    end

    local spellName = GetSpellInfo(ability.SpellId);
    if not spellName and ability.SpellId > 0 then
        return;
    end

    if ability.SpellId < 1 then
        return ability.Func(ability, targetInfo, targetInfo.Target);
    elseif not ability.IsKnown then
        return;
    elseif ability.IsUsableCheck and not IsUsableSpell(spellName) then
        return;
    end

    local start, duration = GetSpellCooldown(ability.SpellId);
    if (duration + start - GetTime()) > AddonFrame.ping then
        return;
    end

    local castPing = AddonFrame.ping * 1000;
    if not ability.CancelCasting then
        local endTime = select(6, UnitCastingInfo("player")) or 0;
        if (endTime - (GetTime() * 1000)) >= castPing then
            return;
        end
    end

    if not ability.DropChanel then
        local endTime = select(6, UnitChannelInfo("player")) or 0;
        if (endTime - (GetTime() * 1000)) >= castPing then
            return;
        end
    end

    if ability.RangeCheck then
        assert(AddonFrame.RangeSpell, "Ability: "..ability.Name.." set range check and not set range spell")
        if IsSpellInRange(AddonFrame.RangeSpell, "target") ~= 1 then
            return;
        end
    end

    if (ability.IsMovingCheck == "notmoving"  and PLAYER.IsMoving)
    or (ability.IsMovingCheck == "moving" and not PLAYER.IsMoving) then
        return;
    end

    local result = ability.Func(ability, targetInfo, targetInfo.Target);
    if not result then
        return;
    elseif type(result) == "string" then
        targetInfo.Target = result;
    end

    if targetInfo.Target ~= "none" and targetInfo.Target ~= "player" and targetInfo.Target ~= "mouselocation" then
        if not UnitExists(targetInfo.Target) then
            return;
        elseif SpellHasRange(spellName) and IsSpellInRange(spellName, targetInfo.Target) == 0 then
            return;
        elseif IsHelpfulSpell(spellName) and not UnitIsFriend("player", targetInfo.Target) then
            return;
        elseif IsHarmfulSpell(spellName) and UnitIsFriend("player", targetInfo.Target) then
            return;
        elseif not UnitIsFriend("player", targetInfo.Target) then
            if UnitIsDeadOrGhost(targetInfo.Target) or not UnitCanAttack("player", targetInfo.Target) then
                return;
            end
        end
    end

    if ability.CancelCasting then
        SpellStopCasting();
    end

    targetInfo.Guid = UnitGUID(targetInfo.Target);
    targetInfo.LastCastingTime = GetTime() + (select(7, GetSpellInfo(ability.SpellId)) or 0) / 1000;

    if targetInfo.Target == "mouselocation" then
        --CastSpellByName(spellName, nil);
        --CameraOrSelectOrMoveStart();
        --CameraOrSelectOrMoveStop();
        --CastSpellByName(spellName, nil);
    elseif targetInfo.Target == "none" then
        --LAST_TARGET = UnitGUID("player");
        --CastSpellByName(spellName, nil);
    else
        LAST_TARGET = UnitGUID(targetInfo.Target);
        --CastSpellByName(spellName, targetInfo.Target);
        BomberFrame.SetKey(ability.HotKey);
    end
    return true;
end

function SetTargetCastintInfo(spellId, guid, castTime)
    local dstGuid = guid and guid or LAST_TARGET;
    for _,ability in ipairs(ABILITY_TABLE) do
        for _,targetInfo in ipairs(ability.TargetList) do
            if spellId == ability.SpellId and UnitGUID(targetInfo.Target) == dstGuid then
                targetInfo.Guid = guid;
                targetInfo.LastCastingTime = castTime;
            end
        end
    end
end

function AddonFrame_OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        self:Show();
        CheckAllSpells();
    elseif event == "PLAYER_LOGOUT" then
        ChangeRotation();
    elseif event == "SPELLS_CHANGED" then
        CheckAllSpells();
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _,subEvent,_,sourceGUID,_,_,_,destGUID,_,_,_,spellId = ...;
        if subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") then
            SetTargetCastintInfo(spellId, destGUID, GetTime());
        elseif subEvent == "SPELL_CAST_FAILED" and sourceGUID == UnitGUID("player") then
            SetTargetCastintInfo(spellId, nil, 0);
        end

        if COMBATLOG_MODS[subEvent] then
            COMBATLOG_MODS[subEvent](...);
        end
    end

    if EVENT_MODS[event] then
        EVENT_MODS[event](...);
    end
end

-- Устанавливает доступность цели из шаблонного списка
function SetTargetListState(state, targetPattern)
    targetPattern = targetPattern or "boss%d";
    for _, ability in ipairs(ABILITY_TABLE) do
        for _, targetInfo in ipairs(ability.TargetList) do
            if string.find(targetInfo.Target, targetPattern) then
                -- Делаем наоборот, совместимость с клиенской частью
                targetInfo.IsDisable = not state;
            end
        end
    end
end

function AddonFrame_AbilityLoop()
    for _,ability in ipairs(ABILITY_TABLE) do
        if not ability.Failed then
            local targetList = ability.TargetList or { "none" };
            for _,targetInfo in ipairs(targetList) do
                if not targetInfo.IsDisable then
                    if CheckAndCastAbility(ability, targetInfo) then
                        return;
                    end
                end
            end
        end
    end
end

function AddonFrame_OnUpdate(self, elapsed)
    if type(ABILITY_TABLE) == "table" and GetTime() >= (AddonFrame.LastTime or 0) then
        if AddonFrame.CurentRotation and not UnitIsDeadOrGhost("player") and not UnitIsAFK("player") then
            AddonFrame.ping = select(4, GetNetStats()) / 1000;
            PLAYER:Init();
            PartyLogic:Init();
            AddonFrame_AbilityLoop();
        end
        AddonFrame.LastTime = GetTime() + math.random(150, 250) / 1000;
    end
    if (AddonFrame.Duration or 0) < GetTime() then
        AddonFrame.Msg:SetText("");
    end
end

