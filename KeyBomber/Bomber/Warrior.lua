-- Arms
BOMBER_WARRIOR_1 = {}

-- Furry
BOMBER_WARRIOR_2 = {
    OnLoad = function()
    end,
    {   SpellId =      0, Name = "Инициализация",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = false,
        IsUsableCheck     = true,
        RangeCheck        = false,
        TargetList = {
            { Target = "none" }
        },
        Func = function(ability, targetInfo, target)
            BomberFrame.RangeSpell = GetSpellInfo(23881);
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
        IsUsableCheck     = true,
        RangeCheck        = false,
        TargetList = {
            { Target = "none" }
        },
        Func = function(ability, targetInfo, target)
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
        IsUsableCheck     = true,
        RangeCheck        = false,
        TargetList = {
            { Target = "none" }
        },
        Func = function(ability, targetInfo, target)
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
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
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
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
            if HealthByPercent("player") < 70 then
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
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
            return true;
        end
    },
    {   SpellId =  5308, Name = "Казнь",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
            return true;
        end
    },
    {   SpellId =  23881, Name = "Кровожадность",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
            return true;
        end
    },
    {   SpellId =  85288, Name = "Яростный выпад",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
            return true;
        end
    },
    {   SpellId =  190411, Name = "Вихрь",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
            return true;
        end
    },
}

BOMBER_WARRIOR_3 = {}