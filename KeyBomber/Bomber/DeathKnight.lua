-- Blood
BOMBER_DEATHKNIGHT_1 = {
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
            BomberFrame.RangeSpell = GetSpellInfo(47528);
            if IsMounted() then
                return true;
            end
        end
    },
    {   SpellId =  47528, Name = "Заморозка мозгов",
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
    {   SpellId =  49998, Name = "Удар смерти",
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
    {   SpellId =  195182, Name = "Дробление хребта",
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
            if not HasBuff("player", 195181) then
                return true;
            end
        end
    },
    {   SpellId =  50842, Name = "Вскипание крови",
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
    {   SpellId =  206930, Name = "Удар в сердце",
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
    {   SpellId =  195292, Name = "Прикосновение смерти",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        IsUsableCheck     = true,
        RangeCheck        = false,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
            if IsSpellInRange(GetSpellInfo(195292), "target") == 1 then
                return true;
            end
        end
    },
}

-- Frost
BOMBER_DEATHKNIGHT_2 = {

}

-- Unholy
BOMBER_DEATHKNIGHT_3 = {

}