-- Assassination
BOMBER_ROGUE_1 = {
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
            BomberFrame.RangeSpell = GetSpellInfo(703);
            if IsMounted() or IsStealthed() then
                return true;
            end
        end
    },
    {   SpellId =    703, Name = "Гаротта",
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
            if select(3, HasDebuff("target", 703, "PLAYER")) < 4 then
                return true;
            end
        end
    },
    {   SpellId =   1943, Name = "Рваная рана",
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
            if GetComboPoints("player", "target") > 3 then
                if select(3, HasDebuff("target", 1943, "PLAYER")) < 4 then
                    return true;
                end
            end
        end
    },
    {   SpellId =  32645, Name = "Отравленеие",
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
            if GetComboPoints("player", "target") > 3 then
                if select(3, HasDebuff("target", 1943, "PLAYER")) > 5 then
                    return true;
                end
            end
        end
    },
    {   SpellId =   1329, Name = "Расправа",
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

-- 
BOMBER_ROGUE_2 = {
}

-- 
BOMBER_ROGUE_3 = {
}