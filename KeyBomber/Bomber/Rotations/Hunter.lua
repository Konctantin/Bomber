-- Beastmaster
BOMBER_HUNTER_1 = {
    OnLoad = function()
        SetInRangeSpell(193455);
    end,
    {   SpellId =      0, Name = "Initialization",
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
    {   SpellId = 136, Name = "Лечение питомца",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if PLAYER.HasAlivePet and HealthByPercent("pet") < 80 then
                return true;
            end
        end
    },
    {   SpellId = 193530, Name = "Дух дикой природы",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if CheckUsedCooldown() and PLAYER.HasAlivePet then
                return true;
            end
        end
    },
    {   SpellId =  19574, Name = "Звериный гнев",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if CheckUsedCooldown() and PLAYER.HasAlivePet then
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
    {   SpellId =  53209, Name = "Выстрел химеры",
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
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if PLAYER.HasAlivePet then
                return true;
            end
        end
    },
    {   SpellId =   2643, Name = "Залп",
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