-- Elemental
BOMBER_SHAMAN_1 = {
    OnLoad = function()
        SetInRangeSpell(188196);
    end,
    {   SpellId =      0, Name = "Initialization",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = false,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if IsMounted()
            or IsStealthed()
            or HasBuff("player", 2645)
            --or GetShapeshiftForm() ~= 4
            then
                return true;
            end
        end
    },
    {   SpellId = 57994, Name = "Пронзающий ветер",
        RecastDelay       = 0,
        DropChanel        = true,
        CancelCasting     = true,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if CheckInterrupt("target") then
                return true;
            end
        end
    },
    {   SpellId = 188389, Name = "Огненный шок",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if IsMoving() or select(3, HasDebuff("target", 188389, "PLAYER")) < 4 then
                return true;
            end
        end
    },
    {   SpellId = 8042, Name = "Земной шок",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return not BOMBER_AOE;
        end
    },
    {   SpellId = 51505, Name = "Выброс лавы",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return not PLAYER.IsMoving or HasBuff("player", 77762);
        end
    },
    {   SpellId = 188443, Name = "Цепная молния",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return not PLAYER.IsMoving and BOMBER_AOE;
        end
    },
    {   SpellId = 188196, Name = "Молния",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return not PLAYER.IsMoving and not BOMBER_AOE;
        end
    },
}

-- Enhancement
BOMBER_SHAMAN_2 = {

}

-- Restoration
BOMBER_SHAMAN_3 = {
    -- Healer spec impossible implemented
}