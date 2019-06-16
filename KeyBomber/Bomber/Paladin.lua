﻿BOMBER_PALADIN_1 = {
    -- Healer spec impossible implemented
}

BOMBER_PALADIN_2 = {
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
            BomberFrame.RangeSpell = GetSpellInfo(96231);
            if IsModKeyDown(mkLeftAlt) or IsMounted() then
                return true;
            end
        end
    },
    {   SpellId =  31884, Name = "Гнев карателя",
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
    {   SpellId =  96231, Name = "Укор",
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
    {   SpellId =  184092, Name = "Свет защитника",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        IsUsableCheck     = true,
        RangeCheck        = false,
        TargetList = {
            { Target = "player" }
        },
        Func = function(ability, targetInfo, target)
            if HealthByPercent("player") < 70 then
                return true;
            end
        end
    },
    {   SpellId =  31935, Name = "Щит мстителя",
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
            if IsSpellInRange(GetSpellInfo(31935), "target") == 1 then
                return true;
            end
        end
    },
    {   SpellId =  26573, Name = "Освящение",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "none" }
        },
        Func = function(ability, targetInfo, target)
             if not HasBuff("player", 188370) then
                return true;
            end
        end
    },
    {   SpellId =  53600, Name = "Щит праведника",
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
            if not HasBuff("plaayer", 132403) then
                return true;
            end
        end
    },
    {   SpellId =  53595, Name = "Молот праведника",
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
    {   SpellId =  275779, Name = "Правосудие",
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
            if IsSpellInRange(GetSpellInfo(35395), "target") == 1 then
                return true;
            end
        end
    },
}

BOMBER_PALADIN_3 = {
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
            BomberFrame.RangeSpell = GetSpellInfo(35395);
            if IsModKeyDown(mkLeftAlt) or IsMounted() then
                return true;
            end
        end
    },
    {   SpellId =  203538, Name = "Великое благословление королей",
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
            if not HasBuff("player", 203538) then
                return true;
            end
        end
    },
    {   SpellId =  31884, Name = "Гнев карателя",
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
    {   SpellId =  96231, Name = "Укор",
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
    {   SpellId =  19750, Name = "Вспышка света",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        IsUsableCheck     = true,
        RangeCheck        = false,
        TargetList = {
            { Target = "player" }
        },
        Func = function(ability, targetInfo, target)
            if HealthByPercent("player") < 70 and select(2, HasBuff("player", 114250)) > 4 then
                return true;
            end
        end
    },
    {   SpellId =  255937, Name = "Испепеляющий след",
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
            if UnitPower("player", 9) < 1 then
                return true;
            end
        end
    },
    {   SpellId =  53385, Name = "Божественная буря",
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
            if BOMBER_AOE then
                return true;
            end
        end
    },
    {   SpellId =  85256, Name = "Вердикт храмовника",
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
            if not BOMBER_AOE then
                return true;
            end
        end
    },
    {   SpellId =  184575, Name = "Клинок справедливости",
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
    {   SpellId =  20271, Name = "Правосудие",
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
    {   SpellId =  35395, Name = "Удар воина света",
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