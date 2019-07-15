-- Beastmaster
BOMBER_HUNTER_1 = {
    OnLoad = function()
        SetInRangeSpell(193455);
    end,
    {   SpellId =      0, Name = "Initialization",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        IsCheckInCombat   = false,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if IsMounted() or IsStealthed() then
                return true;
            end
        end
    },
    {   SpellId = 193530, Name = "Дух дикой природы",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if CheckUsedCooldown() and UnitExists("pet") then
                return true;
            end
        end
    },
    {   SpellId =  19574, Name = "Звериный гнев",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if CheckUsedCooldown() and UnitExists("pet") then
                return true;
            end
        end
    },
    {   SpellId =  53209, Name = "Выстрел химеры",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if UnitPower("player") < 70 then
                return true;
            end
        end
    },
    {   SpellId = 217200, Name = "Разрывающий выстрел",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if select(3, HasDebuff("target", 217200, "PLAYER")) < 3 then
                return true;
            end
        end
    },
    {   SpellId =  34026, Name = "Команда Взять",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if UnitExists("pet") then
                return true;
            end
        end
    },
    {   SpellId =   2643, Name = "Залп",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if BOMBER_AOE then
                return true;
            end
        end
    },
    {   SpellId =   193455, Name = "Выстрел кобры",
        IsMovingCheck     = "none",
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
}

-- Marksmanship
BOMBER_HUNTER_2 = {

}

-- Survival
BOMBER_HUNTER_3 = {

}