-- Assassination
BOMBER_ROGUE_1 = {
    OnLoad = function()
        SetInRangeSpell(703);
    end,
    {   SpellId =      0, Name = "Initialization",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = false,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if IsMounted() or IsStealthed() then
                return true;
            end
        end
    },
    {   SpellId =    1766, Name = "Пинок",
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
    {   SpellId =    703, Name = "Гаротта",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if select(3, HasDebuff("target", 703, "PLAYER")) < 4 then
                return true;
            end
        end
    },
    {   SpellId =   1943, Name = "Рваная рана",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if GetComboPoints("player", "target") > 3 then
                if select(3, HasDebuff("target", 1943, "PLAYER")) < 4 then
                    return true;
                end
            end
        end
    },
    {   SpellId =  32645, Name = "Отравленеие",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if GetComboPoints("player", "target") > 3 then
                if select(3, HasDebuff("target", 1943, "PLAYER")) > 5 then
                    return true;
                end
            end
        end
    },
    {   SpellId =   1329, Name = "Расправа",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return not BOMBER_AOE;
        end
    },
    {   SpellId =  51723, Name = "Веер клинков",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return BOMBER_AOE;
        end
    },
    {   SpellId =   185565, Name = "Отравленный нож",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if UnitPower("player") > 60 then
                return true;
            end
        end
    },
}

-- Combat
BOMBER_ROGUE_2 = {

}

-- Subtlety
BOMBER_ROGUE_3 = {

}