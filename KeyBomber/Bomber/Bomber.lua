EVENT_MODS = { };
COMBATLOG_MODS = { };
ABILITY_TABLE = {}

-- Константы горячих клавиш
mkLeftShift     = 1;
mkLeftControl   = 2;
mkLeftAlt       = 3;
mkRightShift    = 4;
mkRightControl  = 5;
mkRightAlt      = 6;

BOMBER_AOE = false;
BOMBER_COOLDOWN = false;
BOMBER_PAUSE = false;

function EVENT_MODS.MODIFIER_STATE_CHANGED(modifier, state)
    if state == 0 then return end; -- release key

    if modifier == "LCTRL" then
        if BOMBER_AOE then
            BOMBER_AOE = false;
            BomberFrameInfo.print("|cff00ff00Одиночная цель", true);
        else
            BOMBER_AOE = true;
            BomberFrameInfo.print("|cffff0000AOE", true);
        end
    elseif modifier == "RSHIFT" then
        if BOMBER_COOLDOWN then
            BOMBER_COOLDOWN = false;
            BomberFrameInfo.print("|cffff0000Кулдауны выключены", true);
        else
            BOMBER_COOLDOWN = true;
            BomberFrameInfo.print("|cff00ff00Кулдауны включены", true);
        end
    elseif modifier == "LALT" then
        if BOMBER_PAUSE then
            BOMBER_PAUSE = false;
            BomberFrameInfo.print("|cffff0000Пауза выключена", true);
        else
            BOMBER_PAUSE = true;
            BomberFrameInfo.print("|cff00ff00Пауза включена", true);
        end
    end
end

PLAYER = {
    HP   = 0,
    Agro = 0,
    IsMoving  = false,
    IsMounted = false,

    Init = function(self)
        self.HP = 100 * (UnitHealth("player") or 1) / (UnitHealthMax("player") or 1) or 0;
        self.IsMoving = IsMoving();
        self.IsMounted= IsMounted() and not HasBuff("player", 165803);
        self.Agro     = UnitThreatSituation("player") or 0;
    end,
};

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
           for i = 1, 40 do
               local name, icon, count, debuffType, duration, expires, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitBuff(unit, i, filter);
               if not name then
                   return nil, 0, 0, nil, 0, 0;
               end
               if name == spellName then
                   local rem = min(max((expires or 0) - (GetTime() - (BomberFrame.ping or 0)), 0), 0xffff);
                   return name, count, rem, value1, value2, value3;
               end
           end
        end
    end
    return nil, 0, 0, nil, 0, 0;
end

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
           for i = 1, 40 do
               local name, icon, count, debuffType, duration, expires, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitDebuff(unit, i, filter);
               if not name then
                   return nil, 0, 0, nil, 0, 0;
               end
               if name == spellName then
                   local rem = min(max((expires or 0) - (GetTime() - (BomberFrame.ping or 0)), 0), 0xffff);
                   return name, count, rem, value1, value2, value3;
               end
           end
        end
    end
    return nil, 0, 0, nil, 0, 0;
end

function SpellCD(m_spell)
    local start, duration, enable = GetSpellCooldown(m_spell);
    local cooldown = duration + start - GetTime();
    return (cooldown > 0 and cooldown - (BomberFrame.ping or 0) or 0), enable;
end

function IsMoving()
    return GetUnitSpeed("player") ~= 0 or IsFalling();
end

-- Return current health by percent
function HealthByPercent(m_target)
    return UnitExists(m_target) and 100 * (UnitHealth(m_target) or 1) / (UnitHealthMax(m_target) or 1) or 0;
end

-- Return current value of resource (mana, energy, focus, rage, ...) in percents.
function PowerByPercent(m_target, m_powertype)
    return UnitExists(m_target) and 100 * (UnitPower(m_target, m_powertype) or 1) / (UnitPowerMax(m_target, m_powertype) or 1) or 0;
end

--- Check if was pressed modifier key
-- @param m_key modifier key
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

-- Return Unit ID
function UnitId(unit)
    return tonumber((UnitGUID(unit) or ""):match("-(%d+)-%x+$"), 10);
end

-- Проверяет, надо ли сбивать заклинание текущему юниту.
function CheckInterrupt(unit, sec)
    -- чтение заклинания прерываем только перед окончанием каста.
    local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(unit);
    if name and not (notInterruptible or isTradeSkill) then
        if (((endTime / 1000) - GetTime()) - BomberFrame.ping) <= (sec or 1) then
            return true;
        end
    end
    -- канальное заклинание прерываем сразу.
    local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = UnitChannelInfo(unit);
    if name and not (notInterruptible or isTradeSkill) then
        return true;
    end
end

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
        print(string.format("|cff15bd05Changed spell: %s Id %d -> %d|r", ability.SpellName, ability.SpellId, spellId));
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

function GetHotKeyBySpellId(spellId)
    local actionList = C_ActionBar.FindSpellActionButtons(spellId);
    if actionList and #actionList > 0 then
        local actionID = actionList[1];
        for _, barName in pairs({'Action','MultiBarBottomLeft','MultiBarBottomRight','MultiBarRight','MultiBarLeft'}) do
            for i = 1, 12 do
                local button = _G[barName .. 'Button' .. i];
                if button.action == actionID then
                    return button.HotKey:GetText();
                end
            end
        end
    end
end

function CheckAndCastAbility(ability, targetInfo)
    BomberFrame_SetKey();

    if BOMBER_PAUSE then
        return;
    end

    if GetCurrentKeyBoardFocus() then
        return;
    end

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
    if (duration + start - GetTime()) > BomberFrame.ping then
        return;
    end

    local castPing = BomberFrame.ping * 1000;
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
        assert(BomberFrame.RangeSpell, "Ability: "..ability.Name.." set range check and not set range spell")
        if IsSpellInRange(BomberFrame.RangeSpell, "target") ~= 1 then
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

    local hotKey = GetHotKeyBySpellId(ability.SpellId);
    BomberFrame_SetKey(hotKey);

    -- move to SPELL_CAST_START
    targetInfo.Guid = UnitGUID(targetInfo.Target);
    targetInfo.LastCastingTime = GetTime() + (select(7, GetSpellInfo(ability.SpellId)) or 0) / 1000;

    if not hotKey and ability.SpellId > 0 then
        print("HotKey by "..spellName.." not found");
    end

    return hotKey ~= nil;
end

function AddonFrame_AbilityLoop()
    if type(ABILITY_TABLE) == "table" then 
        for _,ability in ipairs(ABILITY_TABLE) do
            if type(ability) == "table" and not ability.Failed then
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
end

function BomberFrame_OnUpdate(self, elapsed)
    if GetTime() >= (BomberFrame.LastTime or 0) then
        if not UnitIsDeadOrGhost("player") and not UnitIsAFK("player") then
            BomberFrame.ping = select(4, GetNetStats()) / 1000;
            PLAYER:Init();
            AddonFrame_AbilityLoop();
        end
        BomberFrame.LastTime = GetTime() + math.random(150, 250) / 1000;
    end
end

function LoadRotation()
    local rotationName = "BOMBER_"..select(2, UnitClass("player")).."_"..tostring(GetSpecialization());
    ABILITY_TABLE = _G[rotationName];

    BOMBER_AOE = false;
    BOMBER_COOLDOWN = false;
    BOMBER_PAUSE = false;

    if ABILITY_TABLE and type(ABILITY_TABLE.OnLoad) == "function" then
        ABILITY_TABLE.OnLoad();
        BomberFrameInfo.print("|cff15bd05Rotation: |r|cff6f0a9a"..select(2, GetSpecializationInfo(GetSpecialization())).."|r|cff15bd05 is enabled.|r", true);
    end
end

function SetTargetCastintInfo(spellId, guid, castTime)
    if type(ABILITY_TABLE) == "table" then 
        local dstGuid = guid and guid or LAST_TARGET;
        for _,ability in ipairs(ABILITY_TABLE) do
            if type(ability) == "table" then
                for _,targetInfo in ipairs(ability.TargetList) do
                    if spellId == ability.SpellId and UnitGUID(targetInfo.Target) == dstGuid then
                        targetInfo.Guid = guid;
                        targetInfo.LastCastingTime = castTime;
                    end
                end
            end
        end
    end
end

function BomberFrame_OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        self:Show();
        LoadRotation();
        CheckAllSpells();
    elseif event == "SPELLS_CHANGED" then
        CheckAllSpells();
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        local unit = ...;
        if UnitGUID(unit) == UnitGUID("player") then
            LoadRotation();
        end
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _,subEvent,_,sourceGUID,_,_,_,destGUID,_,_,_,spellId = CombatLogGetCurrentEventInfo();
        if subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") then
            SetTargetCastintInfo(spellId, destGUID, GetTime());
        elseif subEvent == "SPELL_CAST_FAILED" and sourceGUID == UnitGUID("player") then
            SetTargetCastintInfo(spellId, nil, 0);
        elseif subEvent == "SPELL_CAST_START" then
            -- after start spell cast need reset frame color
            BomberFrame_SetKey(nil);
        end

        if COMBATLOG_MODS[subEvent] then
            COMBATLOG_MODS[subEvent](...);
        end
    end

    if EVENT_MODS[event] then
        EVENT_MODS[event](...);
    end
end

BomberFrame = CreateFrame("Frame", nil, UIParent);
BomberFrame:SetFrameStrata("BACKGROUND");
BomberFrame:SetWidth(5);
BomberFrame:SetHeight(5);
BomberFrame:SetPoint("BOTTOMLEFT", "UIParent");
BomberFrame.texture = BomberFrame:CreateTexture(nil, "BACKGROUND");
BomberFrame.texture:SetAllPoints(true);
BomberFrame.texture:SetColorTexture(1.0, 0.5, 0.0, 1);

BomberFrame:SetScript("OnUpdate", BomberFrame_OnUpdate);
BomberFrame:SetScript("OnEvent",  BomberFrame_OnEvent);
BomberFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
BomberFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
BomberFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
BomberFrame:RegisterEvent("MODIFIER_STATE_CHANGED");
BomberFrame:Show();

BomberFrameInfo = CreateFrame("Frame");
BomberFrameInfo:SetScript("OnUpdate", function (self, elapsed)
    if (BomberFrameInfo.Duration or 0) < GetTime() then
        BomberFrameInfo.Msg:SetText("");
    end
end);
BomberFrameInfo:SetHeight(300);
BomberFrameInfo:SetWidth(600);
BomberFrameInfo.Buttons = {};
BomberFrameInfo.Msg = BomberFrameInfo:CreateFontString(nil, "BACKGROUND", "PVPInfoTextFont");
BomberFrameInfo.Msg:SetAllPoints();
BomberFrameInfo.print = function(msg, con)
    BomberFrameInfo.Msg:SetText(msg);
    if con then print(msg) end
    BomberFrameInfo.Duration = GetTime() + 5;
end;
BomberFrameInfo:SetPoint("CENTER", 0, 200);
BomberFrameInfo:Show();

function BomberFrame_SetKey(key)
    if key then
        local color = BOMBER_KEYMAP[string.upper(key)];
        if color then
            BomberFrame.texture:SetColorTexture(color.R, color.G, color.B, 1);
        else
            BomberFrame.texture:SetColorTexture(0, 0, 0, 1);
        end
    else
        BomberFrame.texture:SetColorTexture(0, 0, 0, 1);
    end
end

