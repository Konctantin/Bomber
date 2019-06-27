-- Balance
BOMBER_DRUID_1 = {
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
            BomberFrame.RangeSpell = GetSpellInfo(8921);
            if IsMounted() or IsStealthed() or GetShapeshiftForm() ~= 4 then
                return true;
            end
        end
    },
    {   SpellId = 78674, Name = "Столб солнечного света",
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
    {   SpellId =  194223, Name = "Парад планет",
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
    {   SpellId = 78674, Name = "Звездный поток",
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
            return not BOMBER_AOE and UnitPower("player") > 40;
        end
    },
    {   SpellId = 93402, Name = "Солнечный огонь",
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
            if select(3, HasDebuff("target", 164815, "PLAYER")) < 4 then
                return true;
            end
        end
    },
    {   SpellId = 8921, Name = "Лунный огонь",
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
            if IsMoving() or select(3, HasDebuff("target", 164812, "PLAYER")) < 4 then
                return true;
            end
        end
    },
    {   SpellId = 194153, Name = "Лунный удар",
        IsMovingCheck     = "notmoving",
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
            if BOMBER_AOE or HasBuff("player", 164547) then
                return true;
            end
        end
    },
    {   SpellId = 190984, Name = "Солнечный гнев",
        IsMovingCheck     = "notmoving",
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

-- Feral
BOMBER_DRUID_2 = {

}

-- Guardian
BOMBER_DRUID_3 = {
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
            BomberFrame.RangeSpell = GetSpellInfo(33917);
            if IsMounted() or IsStealthed() or GetShapeshiftForm() ~= 1 then
                return true;
            end
        end
    },
    {   SpellId = 109839, Name = "Лобовая атака",
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
            if CheckInterrupt("target") then
                return true;
            end
        end
    },
    {   SpellId =   22842, Name = "Неистовое восстановление",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "player" }
        },
        Func = function(ability, targetInfo, target)
            if PLAYER.HP < 70 then
                return true;
            end
        end
    },
    {   SpellId =  8921, Name = "Лунный огонь",
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
            if select(3, HasDebuff("target", 164812, "PLAYER")) < 3 then
                return true;
            end
        end
    },
    {   SpellId =  77758, Name = "Взбучка",
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
            return true;
        end
    },
    {   SpellId =   6807, Name = "Трепка",
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
            --if UnitPower("player") > 20 then
                return true;
            --end
        end
    },
    {   SpellId =   33917, Name = "Увечье",
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
    {   SpellId = 213771, Name = "Размах",
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
            return true;
        end
    },
}

-- Restoratin
BOMBER_DRUID_4 = {
    -- Healer spec impossible implemented
}