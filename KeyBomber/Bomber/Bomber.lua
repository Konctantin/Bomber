﻿EVENT_MODS = { };
COMBATLOG_MODS = { };

BOMBER_AOE = false;
BOMBER_COOLDOWN = true;
BOMBER_PAUSE = false;
BOMBER_INTERRUPT = true;

function PrintStateChangeText(text, onoff)
    local state = onoff and "|cff00ff00 ON|r" or "|cffff0000 OFF|r";
    BomberFrameInfo.print("|cff6f0a9a "..text.."|r"..state, true);
end

function EVENT_MODS.MODIFIER_STATE_CHANGED(modifier, state)
    if state == 0 then return end; -- release key

    if modifier == "LCTRL" then
        BOMBER_AOE = not BOMBER_AOE;
        PrintStateChangeText("AOE Mode", BOMBER_AOE);
    elseif modifier == "RSHIFT" then
        BOMBER_COOLDOWN = not BOMBER_COOLDOWN;
        PrintStateChangeText("Cooldowns", BOMBER_COOLDOWN);
    elseif modifier == "RCTRL" then
        BOMBER_INTERRUPT = not BOMBER_INTERRUPT;
        PrintStateChangeText("Spell interrupt", BOMBER_INTERRUPT);
    elseif modifier == "RALT" then
        BOMBER_PAUSE = not BOMBER_PAUSE;
        PrintStateChangeText("Global rotation pause", BOMBER_PAUSE);
    end
end

function SetInRangeSpell(spellId)
    BomberFrame.RangeSpellId = spellId;
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

    for i = 1, 2 do
        local _, _, offs, numspells = GetSpellTabInfo(i);
        local maxSpellNum = offs + numspells;

        --for _, bookType in ipairs({"spell", "pet"}) do
        local bookType = "spell"
        for spellBookID = offs, maxSpellNum do
            if spellBookID > 0 then
                local type, baseSpellID = GetSpellBookItemInfo(spellBookID, bookType);
                local currentSpellName = GetSpellBookItemName(spellBookID, bookType);
                --print(spellBookID, bookType)
                local link = GetSpellLink(spellBookID, bookType);
                local currentSpellID = tonumber(link and link:gsub("|", "||"):match("spell:(%d+)"));

                if spellId == currentSpellID
                or spellId == baseSpellID
                or spellName == currentSpellName
                then
                    --print(format("|cff00ff00%s|r: [|cff00ff00%d|r] - (|cff6f0a9a%d|r) |cff00ff00%s|r",
                    --    bookType, spellBookID, spellId, link));
                    return spellBookID, bookType;
                end
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

    -- todo: move to test case
    --if not bookId then
    --    print("|cffff0000*SpellBookId for ("..tostring(ability.SpellId)..") "..ability.SpellName.." don't found");
    --end

    --local link = GetSpellLink(bookId, bookType);
    --print(format("|cff00ff00%s|r: [|cff00ff00%d|r] - (|cff6f0a9a%d|r) |cff00ff00%s|r",
    --               bookType, bookId, ability.SpellId, link));

    ability.SpellBookId = bookId;
    ability.SpellBookType = bookType;
end

function CheckAllSpells()
    if type(BomberFrame.AbilityList) == "table" then
        for _, ability in ipairs(BomberFrame.AbilityList) do
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
                    if button and button.action == actionID and button.HotKey then
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
    if BOMBER_PAUSE
    or GetCurrentKeyBoardFocus()
    or IsLeftAltKeyDown()
    or UnitIsDeadOrGhost("player")
    or UnitIsAFK("player")
    or UnitHasVehicleUI("player") then
        return;
    end

    if ability.IsCheckInCombat and not UnitAffectingCombat("player") then
        return;
    end

    local target = ability.Target or "none";
    local spellName, _, icon, cost, isFunnel, powerType, castTime, minRage, maxRange = GetSpellInfo(ability.SpellBookId, ability.SpellBookType);
    if not spellName and ability.SpellId > 0 then
        return;
    end

    if ability.RecastDelay > 0
        and ability.Guid == UnitGUID(target)
        and ((ability.LastCastingTime or 0) + (ability.RecastDelay*0.001)) >= GetTime() then
        return;
    end

    if (ability.SpellId or 0) == 0 then
        if type(ability.Func) == "function" then
            local result = ability.Func(ability);
            return result;
        end
        return false;
    end

    local bookId, bookType = GetSpellBookId(ability.SpellId);
    ability.SpellBookId = bookId;
    ability.SpellBookType = bookType;

    if not ability.IsKnown then
        return;
    elseif not IsUsableSpell(ability.SpellBookId, ability.SpellBookType) then
        return;
    end

    local start, duration = GetSpellCooldown(ability.SpellBookId, ability.SpellBookType);
    if (duration + start - GetTime()) > BomberFrame.ping then
        return;
    end

    local castPing = BomberFrame.ping * 1000;
    if not ability.CancelCasting then
        -- local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellID
        local endTime = select(5, UnitCastingInfo("player")) or 0;
        if (endTime - (GetTime() * 1000)) >= castPing + 0.7 then
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
        if IsSpellInRange(BomberFrame.RangeSpellBookId, BomberFrame.RangeSpellBookType, "target") ~= 1 then
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

    --ability.Guid = UnitGUID(target);
    --ability.LastCastingTime = GetTime() + (castTime / 1000);

    -- todo: move to test case
    --if not hotKeyColor and ability.SpellId > 0 then
    --    print("HotKey color by ("..spellName..") not found");
    --end

    return hotKeyColor ~= nil;
end

function AddonFrame_AbilityLoop()
    if type(BomberFrame.AbilityList) == "table" then
        if not BomberFrame.AbilityList.OnTackt or BomberFrame.AbilityList.OnTackt() then
            for _, ability in ipairs(BomberFrame.AbilityList) do
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
end

function LoadRotation()
    local classDisplayName, classMnkd = UnitClass("player");
    local rotationName = "BOMBER_"..classMnkd.."_"..tostring(GetSpecialization());
    BomberFrame.AbilityList = _G[rotationName];

    BOMBER_AOE = false;
    BOMBER_COOLDOWN = true;
    BOMBER_PAUSE = false;
    BomberFrame.RangeSpellBookId = nil;
    BomberFrame.RangeSpellBookType = nil;

    if type(BomberFrame.AbilityList) == "table" and #BomberFrame.AbilityList > 0 and UnitLevel("player") >= 10 then
        for _, ability in ipairs(BomberFrame.AbilityList) do
            setmetatable(ability, BOMBER_ABILITY);
        end

        if type(BomberFrame.AbilityList.OnLoad) == "function" then
            BomberFrame.AbilityList.OnLoad();
        end

        local classColorStr = RAID_CLASS_COLORS[classMnkd].colorStr;
        local classColoredText = HEIRLOOMS_CLASS_FILTER_FORMAT:format(classColorStr, classDisplayName);

        local spec = select(2, GetSpecializationInfo(GetSpecialization()));
        BomberFrameInfo.print("|cff15bd05Rotation:|r "..classColoredText.." |cff6f0a9a"..spec.."|r|cff15bd05 is enabled.|r", true);
        CheckAllSpells();
    end
end

function SetTargetCastintInfo(spellId, guid, castTime)
    if type(BomberFrame.AbilityList) == "table" then
        local dstGuid = guid and guid or LAST_TARGET;
        for _, ability in ipairs(BomberFrame.AbilityList) do
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
    elseif event == "LEARNED_SPELL_IN_TAB" then
        CheckAllSpells();
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        local unit = ...;
        if UnitIsUnit(unit, "player") then
            LoadRotation();
        end
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _,subEvent,_,sourceGUID,_,_,_,destGUID,_,_,_,spellId = CombatLogGetCurrentEventInfo();
        if sourceGUID == UnitGUID("player") then
            if subEvent == "SPELL_CAST_SUCCESS" then
                SetTargetCastintInfo(spellId, destGUID, GetTime());
            elseif subEvent == "SPELL_CAST_FAILED" then
                SetTargetCastintInfo(spellId, nil, 0);
            elseif subEvent == "SPELL_CAST_START" then
                -- after start spell cast need reset frame color
                --print(CombatLogGetCurrentEventInfo())
                SetTargetCastintInfo(spellId, destGUID, GetTime()+0.002);
                BomberFrame_SetColor(nil);
            end
        end

        local combatMod = COMBATLOG_MODS[subEvent];
        if combatMod then
            combatMod(...);
        end
    end

    local eventMod = EVENT_MODS[event];
    if eventMod then
        eventMod(...);
    end
end

function BomberFrame_OnUpdate(self, elapsed)
    if GetTime() >= (BomberFrame.LastTime or 0) then
        BomberFrame_SetColor(nil);
        BomberFrame.ping = select(4, GetNetStats()) / 1000;
        PLAYER:Init();
        TARGET:Init();

        local bookId, bookType = GetSpellBookId(BomberFrame.RangeSpellId);
        BomberFrame.RangeSpellBookId = bookId;
        BomberFrame.RangeSpellBookType = bookType;

        if C_PetBattles.IsInBattle() and not BOMBER_PAUSE and not IsModKeyDown(mkLeftAlt) then
            if tdBattlePetScriptAutoButton and tdBattlePetScriptAutoButton:IsEnabled() then
                local hotKey = string.upper(tostring(tdBattlePetScriptAutoButton.HotKey:GetText()));
                local color = BOMBER_KEYMAP[hotKey]
                BomberFrame_SetColor(color);
            end
        else
            AddonFrame_AbilityLoop();
        end
        BomberFrame.LastTime = GetTime() + math.random(150, 250) / 1000;
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
BomberFrame:RegisterEvent("LEARNED_SPELL_IN_TAB");
BomberFrame.AbilityList = { };
BomberFrame:Show();

BomberFrameInfo = CreateFrame("Frame");
BomberFrameInfo:SetScript("OnUpdate", function (self, elapsed)
    if (BomberFrameInfo.Duration or 0) < GetTime() then
        BomberFrameInfo.Msg:SetText("");
    end
end);
BomberFrameInfo:SetHeight(300);
BomberFrameInfo:SetWidth(600);
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
