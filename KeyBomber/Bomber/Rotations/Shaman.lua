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
    {   SpellId =  310690, Name = "Голодное пламя",
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
    OnLoad = function()
        SetInRangeSpell(17364);
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
    {   SpellId =  188070, Name = "Исцеляющий сплеск",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "player",
        Func = function(ability)
            if HealthByPercent("player") < 80 and UnitPower("player") > 40 then
                return true;
            end
        end
    },
    {   SpellId = 51533, Name = "Дух дикого звверя",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if CheckUsedCooldown() then
                return true;
            end
        end
    },
    {   SpellId =  310690, Name = "Голодное пламя",
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
    {   SpellId = 193796, Name = "Язык пламени",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if not HasBuff("player", 194084) then
                return true;
            end
        end
    },
    {   SpellId = 187874, Name = "Сокрушающая молния",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if BOMBER_AOE and not HasBuff("player", 187878) then
                return true;
            end
        end
    },
    {   SpellId = 17364, Name = "Удар бури",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if HasBuff("player", {201846, 262652}) then
                return true;
            end
        end
    },
    {   SpellId = 60103, Name = "Вскипание лавы",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if HasBuff("player", 215785) then
                return true;
            end
        end
    },
    {   SpellId = 17364, Name = "Удар бури",
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
    {   SpellId = 60103, Name = "Вскипание лавы",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if UnitPower("player") > 60 then
                return true;
            end
        end
    },
    {   SpellId = 193786, Name = "Камнедробитель",
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
    {   SpellId = 187837, Name = "Молния",
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
}

-- Restoration
BOMBER_SHAMAN_3 = {
    -- Healer spec impossible implemented
}