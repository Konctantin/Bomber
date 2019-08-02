-- Holy
BOMBER_PALADIN_1 = {
    -- Healer spec impossible implemented
}

-- Protection
BOMBER_PALADIN_2 = {
    OnLoad = function()
        SetInRangeSpell(96231);
    end,
    {   SpellId =      0, Name = "Initialization",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = false,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if IsMounted() then
                return true;
            end
        end
    },
    {   SpellId =  31884, Name = "Гнев карателя",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if CheckUsedCooldown() then
                return true;
            end
        end
    },
    {   SpellId =  96231, Name = "Укор",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if CheckInterrupt("target") then
                return true;
            end
        end
    },
    {   SpellId =  184092, Name = "Свет защитника",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "player",
        Func = function(ability)
            if HealthByPercent("player") < 70 then
                return true;
            end
        end
    },
    {   SpellId =  31935, Name = "Щит мстителя",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if IsSpellInRange(GetSpellInfo(31935), "target") == 1 then
                return true;
            end
        end
    },
    {   SpellId =  26573, Name = "Освящение",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
             if not HasBuff("player", 188370) then
                return true;
            end
        end
    },
    {   SpellId =  53600, Name = "Щит праведника",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if not HasBuff("plaayer", 132403) then
                return true;
            end
        end
    },
    {   SpellId =  53595, Name = "Молот праведника",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return true;
        end
    },
    {   SpellId =  275779, Name = "Правосудие",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if IsSpellInRange(GetSpellInfo(35395), "target") == 1 then
                return true;
            end
        end
    },
}

-- Retribution
BOMBER_PALADIN_3 = {
    OnLoad = function()
        SetInRangeSpell(96231);
    end,
    {   SpellId =      0, Name = "Initialization",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = false,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if IsMounted() then
                return true;
            end
        end
    },
    {   SpellId =  203538, Name = "Великое благословление королей",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            --if not HasBuff("player", 203538) and IsInParty() then
            --    return true;
            --end
            return false
        end
    },
    {   SpellId =  31884, Name = "Гнев карателя",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if CheckUsedCooldown() then
                return true;
            end
        end
    },
    {   SpellId =  96231, Name = "Укор",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if CheckInterrupt("target") then
                return true;
            end
        end
    },
    {   SpellId =  19750, Name = "Вспышка света",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "player",
        Func = function(ability)
            if HealthByPercent("player") < 80 and select(2, HasBuff("player", 114250)) > 4 then
                return true;
            end
        end
    },
    {   SpellId =  255937, Name = "Испепеляющий след",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if UnitPower("player", 9) < 1 then
                return true;
            end
        end
    },
    {   SpellId =  53385, Name = "Божественная буря",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if BOMBER_AOE or HasBuff("player", 286393) then
                return true;
            end
        end
    },
    {   SpellId =  85256, Name = "Вердикт храмовника",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if not BOMBER_AOE then
                return true;
            end
        end
    },
    {   SpellId =  184575, Name = "Клинок справедливости",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return true;
        end
    },
    {   SpellId =  20271, Name = "Правосудие",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return true;
        end
    },
    {   SpellId =  35395, Name = "Удар воина света",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return true;
        end
    },
}