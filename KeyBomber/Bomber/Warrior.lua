-- Arms
BOMBER_WARRIOR_1 = {

}

-- Furry
BOMBER_WARRIOR_2 = {
    OnLoad = function()
        SetInRangeSpell(6552);
    end,
    {   SpellId =      0, Name = "Initialization",
        IsMovingCheck     = "none",
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
    {   SpellId =  6673, Name = "Боевой крик",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if not HasBuff("player", 6673) then
                return true;
            end
        end
    },
    {   SpellId =  1719, Name = "Безразсудство",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if BOMBER_COOLDOWN
            and UnitExists("target")
            and not UnitIsDeadOrGhost("target")
            and UnitCanAttack("player", "target")
            and IsSpellInRange(BomberFrame.RangeSpell, "target") == 1
            then
                return true;
            end
        end
    },
    {   SpellId =  6552, Name = "Зуботычина",
        IsMovingCheck     = "none",
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
    {   SpellId =  202168, Name = "Верная победа",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if HealthByPercent("player") < 80 then
                return true;
            end
        end
    },
    {   SpellId =  184367, Name = "Буйство",
        IsMovingCheck     = "none",
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
    {   SpellId =  5308, Name = "Казнь",
        IsMovingCheck     = "none",
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
    {   SpellId =  23881, Name = "Кровожадность",
        IsMovingCheck     = "none",
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
    {   SpellId =  85288, Name = "Яростный выпад",
        IsMovingCheck     = "none",
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
    {   SpellId =  190411, Name = "Вихрь",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            return true;
        end
    },
    {   SpellId =  57755, Name = "Героический бросок",
        IsMovingCheck     = "none",
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

-- Protection
BOMBER_WARRIOR_3 = {
    OnLoad = function()
        SetInRangeSpell(23922);
    end,
    {   SpellId =      0, Name = "Initialization",
        IsMovingCheck     = "none",
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
    {   SpellId =  18499, Name = "Ярость берсерка",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if IsLossOfControl("FEAR", "PACIFY", "CHARM", "CONFUSE", "POSSESS") then
                return true;
            end
        end
    },
    {   SpellId =  190456, Name = "Стойкость к боли",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if PLAYER.Agro > 1 then
                return true;
            end
        end
    },
    {   SpellId =  2565, Name = "Блок щитом",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if PLAYER.Agro > 2 and UnitPower("player") > 30 then
                return true;
            end
        end
    },
    {   SpellId =  6552, Name = "Зуботычина",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if CheckInterrupt("target") then
                return true;
            end
        end
    },
    {   SpellId =  202168, Name = "Верная победа",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if PLAYER.HP < 80 then
                return true;
            end
        end
    },
    {   SpellId =  23922, Name = "Мощный удар щитом",
        IsMovingCheck     = "none",
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
    {   SpellId =  6343, Name = "Удар грома",
        IsMovingCheck     = "none",
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
    {   SpellId =  6572, Name = "Реванш",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if UnitPower("player") > 40 or HasBuff("player", 5302) then
                return true;
            end;
        end
    },
    {   SpellId =  20243, Name = "Сокрушение",
        IsMovingCheck     = "none",
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
    {   SpellId =  57755, Name = "Героический бросок",
        IsMovingCheck     = "none",
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