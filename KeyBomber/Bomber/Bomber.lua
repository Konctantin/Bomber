EVENT_MODS = { };
COMBATLOG_MODS = { };
ABILITY_TABLE = { }

mkLeftShift     = 1;
mkLeftControl   = 2;
mkLeftAlt       = 3;
mkRightShift    = 4;
mkRightControl  = 5;
mkRightAlt      = 6;

BOMBER_AOE = false;
BOMBER_COOLDOWN = false;
BOMBER_PAUSE = false;
BOMBER_INTERRUPT = true;

function EVENT_MODS.MODIFIER_STATE_CHANGED(modifier, state)
    if state == 0 then return end; -- release key

    if modifier == "LCTRL" then
        if BOMBER_AOE then
            BOMBER_AOE = false;
            BomberFrameInfo.print("|cff00ff00Single target", true);
        else
            BOMBER_AOE = true;
            BomberFrameInfo.print("|cffff0000AOE", true);
        end
    elseif modifier == "RSHIFT" then
        if BOMBER_COOLDOWN then
            BOMBER_COOLDOWN = false;
            BomberFrameInfo.print("|cff00fff00Cooldown ON", true);
        else
            BOMBER_COOLDOWN = true;
            BomberFrameInfo.print("|cffff0000Cooldown OFF", true);
        end
    elseif modifier == "RCTRL" then
        if BOMBER_INTERRUPT then
            BOMBER_INTERRUPT = false;
            BomberFrameInfo.print("|cff00ff00Spell interrupt OFF", true);
        else
            BOMBER_INTERRUPT = true;
            BomberFrameInfo.print("|cffff0000Spell interrupt ON", true);
        end
    elseif modifier == "RALT" then
        if BOMBER_PAUSE then
            BOMBER_PAUSE = false;
            BomberFrameInfo.print("|cffff0000Pause OFF", true);
        else
            BOMBER_PAUSE = true;
            BomberFrameInfo.print("|cff00ff00Pause ON", true);
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

    HasBuff = function(self, spellId, filter)
        return HasBuff("player", spellId, filter)
    end
};

TARGET = {
    HP = 0,
    ID = 0,

    Init = function(self)
        self.HP = 100 * (UnitHealth("target") or 1) / (UnitHealthMax("target") or 1) or 0;
        self.ID = UnitId("target");
    end,

    HasDebuf = function (self, spellId, filter)
        return HasDebuff("target", spellId, filter)
    end,
}

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

-- Checking if needs is interrupt unit's cast.
function CheckInterrupt(unit, sec)
    if BOMBER_INTERRUPT then
        local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(unit);
        if name and not (notInterruptible or isTradeSkill) then
            if (((endTime / 1000) - GetTime()) - BomberFrame.ping) <= (sec or 1) then
                return true;
            end
        end

        local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = UnitChannelInfo(unit);
        if name and not (notInterruptible or isTradeSkill) then
            return true;
        end
    end
end

function IsLossOfControl(...)
    --[[
    STUN_MECHANIC
    SCHOOL_INTERRUPT
    DISARM
    PACIFYSILENCE
    SILENCE
    ROOT
    PACIFY
    STUN
    FEAR
    CHARM
    CONFUSE
    POSSESS
    ]]

    local numEvents = C_LossOfControl.GetNumEvents() or 0;
    if numEvents > 0 then
        local types = { ... };
        for i = 1, numEvents do
            local locType, spellID, text, iconTexture, startTime, timeRemaining, duration, lockoutSchool, priority, displayType = C_LossOfControl.GetEventInfo(i);
            for _, etype in ipairs(types) do
                if locType == etype then
                    return true;
                end
            end
        end
    end
end

function SetInRangeSpell(spellId)
    BomberFrame.RangeSpellBookId = nil;
    if (spellId or 0) > 0 then
        local name = GetSpellInfo(spellId);
        assert(name, "Unknown spell by Id "..tostring(spellId));
        assert(SpellHasRange(name), "Spell "..tostring(rangeSpell).." "..name.." don't have a range");

        local bookId, bookType = GetSpellBookId(spellId);
        assert(bookId, "SpellBookId not found for spell "..name.." ("..tostring(spellId)..")");
        BomberFrame.RangeSpellBookId = bookId;
        BomberFrame.RangeSpellBookType = bookType;
    end
end

function GetSpellBookId(spellId)
    local spellName = GetSpellInfo(spellId);

    local _, _, offs, numspells = GetSpellTabInfo(2);
    local maxSpellNum = offs + numspells;

    for _, bookType in ipairs({"spell", "pet"}) do
        for spellBookID = 1, maxSpellNum do
            local type, baseSpellID = GetSpellBookItemInfo(spellBookID, bookType);

            local currentSpellName = GetSpellBookItemName(spellBookID, bookType);
            local link = GetSpellLink(currentSpellName);
            local currentSpellID = tonumber(link and link:gsub("|", "||"):match("spell:(%d+)"));

            if spellId == currentSpellID or spellName == currentSpellName then
                return spellBookID, bookType;
            end
        end
    end
end

function CheckKnownAbility(ability)
    ability.SpellName = GetSpellInfo(ability.SpellId);
    ability.IsKnown = false;

    if not ability.SpellName then
        print("|cff15bd05Ability: "..ability.Name..", invalid spell id ", ability.SpellId.."|r")
        return;
    end

    -- main check
    if IsPlayerSpell(ability.SpellId)
        or IsSpellKnown(ability.SpellId) or IsSpellKnown(ability.SpellId, true)
        or IsTalentSpell(ability.SpellName) then
        ability.IsKnown = true;
    end

    -- check specialization spells
    if not ability.IsKnown then
        local spec = GetSpecialization();
        if spec then
            local spellList = { GetSpecializationSpells(spec) };
            local lvl = UnitLevel("player");
            for i = 1, #spellList, 2 do
                if spellList[i] == ability.SpellId and lvl > (spellList[i+1] or 0) then
                    ability.IsKnown = true;
                end
            end
        end
    end

    -- check spell on the spellbook
    if not ability.IsKnown then
        local spellId = select(2, GetSpellBookItemInfo(ability.SpellName));
        if spellId and ability.SpellId ~= spellId then
            print(string.format("|cff15bd05Changed spell: %s Id %d -> %d|r", ability.SpellName, ability.SpellId, spellId));
            ability.SpellId = spellId;
            ability.IsKnown = true;
        end
    end

    local bookId, bookType = GetSpellBookId(ability.SpellId);

    if not bookId then
        print("|cffff0000*SpellBookId for ("..tostring(ability.SpellId)..") "..ability.SpellName.." don't found");
    end

    ability.SpellBookId = bookId;
    ability.SpellBookType = bookType;
end

function CheckAllSpells()
    if type(ABILITY_TABLE) == "table" then
        for _, ability in ipairs(ABILITY_TABLE) do
            if ability.SpellId > 0 then
                CheckKnownAbility(ability);
            end
        end
    end
end

local ACTION_BAR_TYPES = { 'Action', 'MultiBarBottomLeft', 'MultiBarBottomRight', 'MultiBarRight', 'MultiBarLeft' };

function GetHotKeyColorBySpellId(spellId)
    local actionList = C_ActionBar.FindSpellActionButtons(spellId);
    if actionList and #actionList > 0 then
        for _, actionID in ipairs(actionList) do
            for _, barName in pairs(ACTION_BAR_TYPES) do
                for i = 1, 12 do
                    local button = _G[barName .. 'Button' .. i];
                    if button and button.action == actionID then
                        local hotKey = string.upper(tostring(button.HotKey:GetText()));
                        local color = BOMBER_KEYMAP[hotKey]
                        if color then
                            return color;
                        end
                    end
                end
            end
        end
    end
end

function CheckAndCastAbility(ability)
    BomberFrame_SetColor(nil);

    if GetCurrentKeyBoardFocus() or IsModKeyDown(mkLeftAlt) or BOMBER_PAUSE then
        return;
    end

    if UnitIsDeadOrGhost("player") then
        return;
    end

    if UnitHasVehicleUI("player") then
        return;
    end

    if ability.IsCheckInCombat and not UnitAffectingCombat("player") then
        return;
    end

    local target = ability.Target or "none";
    local spellName, _, spellIcon, spellCost, spellIsFunnel, spellPowerType, spellCastTime, spellMinRage, spellMaxRange = GetSpellInfo(ability.SpellId);
    spellCastTime = spellCastTime or 0;

    if not spellName and ability.SpellId > 0 then
        return;
    end

    if ability.RecastDelay > 0
        and tarabilitygetInfo.Guid == UnitGUID(target)
        and ((ability.LastCastingTime or 0) + ability.RecastDelay) >= GetTime() then
        return;
    end

    if (ability.SpellId or 0) == 0 then
        if type(ability.Func) == "function" then
            local result = ability.Func(ability);
            return result;
        end
    elseif not ability.IsKnown then
        return;
    elseif not IsUsableSpell(ability.SpellBookId, ability.SpellBookType) then
        return;
    end

    local start, duration = GetSpellCooldown(ability.SpellId);
    if (duration + start - GetTime()) > BomberFrame.ping then
        return;
    end

    local castPing = BomberFrame.ping * 1000;
    if not ability.CancelCasting then
        -- local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID
        local endTime = select(5, UnitCastingInfo("player")) or 0;
        if (endTime - (GetTime() * 1000)) >= castPing then
            return;
        end
    end

    if not ability.DropChanel then
        -- name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID
        local endTime = select(5, UnitChannelInfo("player")) or 0;
        if (endTime - (GetTime() * 1000)) >= castPing then
            return;
        end
    end

    if ability.RangeCheck then
        assert(BomberFrame.RangeSpellBookId, "Ability: "..ability.Name.." set range check and not set range spell");
        if IsSpellInRange(BomberFrame.RangeSpellBookId, BomberFrame.RangeSpellBookType, "target") == 0 then
            return;
        end
    end

    if spellCastTime > 0 then
        if (ability.IsMovingCheck == "notmoving"  and PLAYER.IsMoving)
        or (ability.IsMovingCheck == "moving" and not PLAYER.IsMoving) then
            return;
        end
    end

    if type(ability.Func) == "function" then
        local result = ability.Func(ability);
        if not result then
            return;
        end
    end

    if target == "target" then
        if not UnitExists(target) then
            return;
        elseif SpellHasRange(ability.SpellBookId, ability.SpellBookType) and IsSpellInRange(ability.SpellBookId, ability.SpellBookType, target) == 0 then
            return;
        elseif IsHelpfulSpell(ability.SpellBookId, ability.SpellBookType) and not UnitIsFriend("player", target) then
            return;
        elseif IsHarmfulSpell(ability.SpellBookId, ability.SpellBookType) and UnitIsFriend("player", target) then
            return;
        elseif not UnitIsFriend("player", target) then
            if UnitIsDeadOrGhost(target) or not UnitCanAttack("player", target) then
                return;
            end
        end
    end

    local hotKeyColor = GetHotKeyColorBySpellId(ability.SpellId);

    BomberFrame_SetColor(hotKeyColor);

    ability.Guid = UnitGUID(target);
    ability.LastCastingTime = GetTime() + (spellCastTime / 1000);

    if not hotKeyColor and ability.SpellId > 0 then
        print("HotKey color by ("..spellName..") not found");
    end

    return hotKeyColor ~= nil;
end

function AddonFrame_AbilityLoop()
    if type(ABILITY_TABLE) == "table" then 
        for _, ability in ipairs(ABILITY_TABLE) do
            if type(ability) == "table" and not ability.Failed then
                if not ability.IsDisable then
                    if CheckAndCastAbility(ability) then
                        return;
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
            TARGET:Init();
            AddonFrame_AbilityLoop();
        end
        BomberFrame.LastTime = GetTime() + math.random(150, 250) / 1000;
    end
end

function LoadRotation()
    local className, classMnkd = UnitClass("player");
    local rotationName = "BOMBER_"..classMnkd.."_"..tostring(GetSpecialization());
    ABILITY_TABLE = _G[rotationName];

    BOMBER_AOE = false;
    BOMBER_COOLDOWN = false;
    BOMBER_PAUSE = false;
    BomberFrame.RangeSpellBookId = nil;
    BomberFrame.RangeSpellBookType = nil;

    if type(ABILITY_TABLE) == "table" and #ABILITY_TABLE > 0 then
        if type(ABILITY_TABLE.OnLoad) == "function" then
            ABILITY_TABLE.OnLoad();
        end
        local spec = select(2, GetSpecializationInfo(GetSpecialization()));
        BomberFrameInfo.print("|cff15bd05Rotation: |r|cff6f0a9a"..className..": "..spec.."|r|cff15bd05 is enabled.|r", true);
        CheckAllSpells();
    end
end

function SetTargetCastintInfo(spellId, guid, castTime)
    if type(ABILITY_TABLE) == "table" then
        local dstGuid = guid and guid or LAST_TARGET;
        for _, ability in ipairs(ABILITY_TABLE) do
            if type(ability) == "table" and ability.Target then
                if spellId == ability.SpellId and (not guid or (UnitGUID(ability.Target) == dstGuid)) then
                    ability.Guid = guid;
                    ability.LastCastingTime = castTime;
                end
            end
        end
    end
end

function BomberFrame_OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        self:Show();
        LoadRotation();
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
            --print(CombatLogGetCurrentEventInfo())
            BomberFrame_SetColor(nil);
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
BomberFrameInfo.print = function(msg, toChat)
    BomberFrameInfo.Msg:SetText(msg);
    if toChat then print(msg) end
    BomberFrameInfo.Duration = GetTime() + 5;
end;
BomberFrameInfo:SetPoint("CENTER", 0, 200);
BomberFrameInfo:Show();

function BomberFrame_SetColor(color)
    if color then
        --print(color.R, color.G, color.B)
        BomberFrame.texture:SetColorTexture(color.R, color.G, color.B, 1);
    else
        BomberFrame.texture:SetColorTexture(0, 0, 0, 1);
    end
end

local function PrintRangeCheck(spellId, spellBookId, spellBookType)
    local currentSpellName = GetSpellBookItemName(spellBookId, spellBookType);

    local hasRange = SpellHasRange(spellBookId, spellBookType);
    local inRange = IsSpellInRange(spellBookId, spellBookType, "target");

    local hasRangePrefix = "|cffff0000";
    if hasRange then
        hasRangePrefix = "|cff00ff00";
    end

    local inRangePrefix = "|cffff0000";
    if inRange then
        inRangePrefix = "|cff00ff00";
    end

    print("|cff30ff60".."("..tostring(spellId)..") "..currentSpellName.."|r ("..tostring(spellBookId)..") =>  HasRange: "
        ..hasRangePrefix..tostring(hasRange).."|r InRange: "..inRangePrefix..tostring(inRange).."|r")
end

function CheckSpellHasRange()
    print("|cff00ff00 Start range check...")
    if not UnitExists("target") then
        print("|cffff0000 You must select a unit of target!")
        return;
    end

    if BomberFrame.RangeSpellBookId then
        PrintRangeCheck(0, BomberFrame.RangeSpellBookId, BomberFrame.RangeSpellBookType);
    end

    for i, ability in ipairs(ABILITY_TABLE) do
        if ability.SpellId > 0 then
            PrintRangeCheck(ability.SpellId, ability.SpellBookId, ability.SpellBookType);
        end
    end

    print("|cffff0000 End range check.")
end

function DumpSpellBook()
    local _, _, offs, numspells = GetSpellTabInfo(2);
    local maxSpellNum = offs + numspells;

    print("======================");
    for _, bookType in ipairs({"spell", "pet"}) do
        print("====>", bookType)
        for spellBookID = 1, maxSpellNum do
            local currentSpellName = GetSpellBookItemName(spellBookID, bookType);
            if currentSpellName then
                local link = GetSpellLink(currentSpellName);
                local currentSpellID = tonumber(link and link:gsub("|", "||"):match("spell:(%d+)"));

                print(format("|cff00ff00%s|r: [|cff00ff00%d|r] - (|cff6f0a9a%d|r) |cff00ff00%s|r",
                    bookType, spellBookID, currentSpellID, currentSpellName));
            end
        end
    end

    print("======================")
end

SLASH_RCHECK1= '/rcheck'
SLASH_DUMPSP1= '/dumpsp'

function SlashCmdList.RCHECK(msg)
    CheckSpellHasRange();
end

function SlashCmdList.DUMPSP(msg)
    DumpSpellBook();
end