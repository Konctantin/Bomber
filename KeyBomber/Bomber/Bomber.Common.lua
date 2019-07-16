mkLeftShift     = 1;
mkLeftControl   = 2;
mkLeftAlt       = 3;
mkRightShift    = 4;
mkRightControl  = 5;
mkRightAlt      = 6;

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
    IsMeele = false,

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

function IsInRange(unit)
    return IsSpellInRange(BomberFrame.RangeSpellBookId, BomberFrame.RangeSpellBookType, unit) == 1;
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

function UnitIsEncounterBoss(target)
    return UnitIsUnit(target, "boss1")
        or UnitIsUnit(target, "boss2")
        or UnitIsUnit(target, "boss3")
        or UnitIsUnit(target, "boss4")
end

local function UnitHpIsGreat(target, koef)
    return (UnitHealth(target) or 0) > ((UnitHealthMax("player") or 0) * koef);
end

function CheckUsedCooldown(soloMod)
    if BOMBER_COOLDOWN
    and UnitExists("target")
    and not UnitIsDeadOrGhost("target")
    and UnitCanAttack("player", "target")
    and IsInRange("target") then
        if IsInRaid() then
            return (UnitIsEncounterBoss("target") or UnitHpIsGreat("target", 10);
        elseif IsInGroup() then
            return (UnitIsEncounterBoss("target") or UnitHpIsGreat("target", 6);
        else
            return UnitHpIsGreat("target", soloMod or 2);
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
