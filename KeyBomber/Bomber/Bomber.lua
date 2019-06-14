EVENT_MODS = { };
COMBATLOG_MODS = { };

function BomberFrame_OnUpdate(self, elapsed)
    if GetTime() >= (BomberFrame.LastTime or 0) then
        if not UnitIsDeadOrGhost("player") and not UnitIsAFK("player") then
            BomberFrame.ping = select(4, GetNetStats()) / 1000;
            --PLAYER:Init();
            --PartyLogic:Init();
            --AddonFrame_AbilityLoop();
            BomberFrame_SetKey()
        end
        BomberFrame.LastTime = GetTime() + math.random(150, 250) / 1000;
    end
end

function BomberFrame_OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        self:Show();
        CheckAllSpells();
    --elseif event == "PLAYER_LOGOUT" then
    --    ChangeRotation();
    elseif event == "SPELLS_CHANGED" then
        CheckAllSpells();
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        local unit = ...;
        print("Spec changed", unit)
        if UnitGUID(unit) == UnitGUID("palyer") then
            --LoadRotation();
        end
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _,subEvent,_,sourceGUID,_,_,_,destGUID,_,_,_,spellId = CombatLogGetCurrentEventInfo();
        if subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") then
            --SetTargetCastintInfo(spellId, destGUID, GetTime());
        elseif subEvent == "SPELL_CAST_FAILED" and sourceGUID == UnitGUID("player") then
            --SetTargetCastintInfo(spellId, nil, 0);
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

--BomberFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
--BomberFrame:RegisterEvent("PLAYER_LOGOUT");
--BomberFrame:RegisterEvent("WORLD_MAP_UPDATE");
--BomberFrame:RegisterEvent("MODIFIER_STATE_CHANGED");
--BomberFrame:RegisterEvent("SPELLS_CHANGED");


BomberFrame:Show();

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

