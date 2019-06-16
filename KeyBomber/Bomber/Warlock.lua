
-- Affiction
BOMBER_WARLOCK_1 = {
    OnLoad = function()
        print("Hi")
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
            BomberFrame.RangeSpell = GetSpellInfo(232670);
            if IsModKeyDown(mkLeftAlt) or IsMounted() then
                return true;
            end
        end
    },
    {   SpellId = 980, Name = "Агония",
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
            if select(3, HasDebuff("target", 980, "PLAYER")) < 4 then
                return true
            end
        end
    },
    {   SpellId = 172, Name = "Порча",
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
            if not HasDebuff("target", 146739, "PLAYER") then
                return true
            end
        end
    },
    {   SpellId = 30108, Name = "Нестабильное колдовство",
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
            if not IsMoving() and UnitHealth("target") > UnitHealth("palyer") then
                return true
            end
        end
    },
    {   SpellId = 232670, Name = "Стрела Тьмы",
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
            --print('tick')
            return true
        end
    },
}

-- Demonology
BOMBER_WARLOCK_2 = {

}

-- Destruction
BOMBER_WARLOCK_3 = {

}