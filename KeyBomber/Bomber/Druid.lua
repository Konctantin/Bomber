-- Balance
BOMBER_DRUID_1 = {
    OnLoad = function()
        SetInRangeSpell(8921);
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
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
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
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if BOMBER_COOLDOWN
            and UnitExists("target")
            and not UnitIsDeadOrGhost("target")
            and UnitCanAttack("player", "target")
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
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return not BOMBER_AOE and UnitPower("player") > 40;
        end
    },
    {   SpellId = 93402, Name = "Солнечный огонь",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
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
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
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
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
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
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return true;
        end
    },
}

-- Feral
BOMBER_DRUID_2 = {
    OnLoad = function()
        SetInRangeSpell(5221);
    end,
    {      SpellId =      0, Name = "Initialization",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = false,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if IsMounted() or IsStealthed() or GetShapeshiftForm() ~= 2 then
                return true;
            end
        end
    }, {   SpellId = 106839, Name = "Лобовая атака",
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
    {   SpellId = 106951, Name = "Берсерк",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if BOMBER_COOLDOWN
            and UnitExists("pet")
            and UnitExists("target")
            and not UnitIsDeadOrGhost("target")
            and UnitCanAttack("player", "target")
            then
                return true;
            end
        end
    },
    {   SpellId = 5217, Name = "Тигриное неистовство",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if UnitExists("target")
            and not UnitIsDeadOrGhost("target")
            and UnitCanAttack("player", "target")
            and UnitPower("player") < (UnitPowerMax("player")-50)
            and not HasBuff("player", 106951, "PLAYER")
            then
                return true;
            end
        end
    },
    {   SpellId =  1822, Name = "Глубокая рана",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if select(3, HasDebuff("target", 155722, "PLAYER")) < 3 then
                return true;
            end
        end
    },
    {   SpellId =  155625, Name = "Лунный огонь",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            --if select(3, HasDebuff("target", 155625, "PLAYER")) < 3 then
            --    print(12)
            --    return true;
            --end
        end
    }, 
    {   SpellId =  1079, Name = "Разорвать",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if GetComboPoints("player", "target") > 4 then
                if select(3, HasDebuff("target", 1079, "PLAYER")) < 5 then
                    return true;
                end
            end
        end
    }, {   SpellId =  22568, Name = "Свирепый укус",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if GetComboPoints("player", "target") > 4 and UnitPower("player") >= 50  then
                return true;
            end
        end
    }, {   SpellId =  5221, Name = "Полоснуть",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if (GetComboPoints("player", "target") < 5) or HasBuff("player", 135700) then
                return true;
            end
        end
    },
}

-- Guardian
BOMBER_DRUID_3 = {
    OnLoad = function()
        SetInRangeSpell(6807);
    end,
    OnTackt = function()
        if IsMounted() or IsStealthed() or GetShapeshiftForm() ~= 1 then
            return false;
        end
        return true;
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
            if IsMounted() or IsStealthed() or GetShapeshiftForm() ~= 1 then
                return true;
            end
        end
    },
    {   SpellId = 106839, Name = "Лобовая атака",
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
    {   SpellId =  22842, Name = "Неистовое восстановление",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "player",
        Func = function(ability)
            if PLAYER.HP < 70 then
                return true;
            end
        end
    },
    {   SpellId =   8921, Name = "Лунный огонь",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if (select(3, HasDebuff("target", 164812, "PLAYER")) < 3)
            or HasBuff("player", 213708)
            or IsSpellInRange(GetSpellInfo(6807), "target") == 0
            then
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
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            return true;
        end
    },
    {   SpellId =   6807, Name = "Трепка",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            --if UnitPower("player") > 20 then
                return true;
            --end
        end
    },
    {   SpellId =  33917, Name = "Увечье",
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
    {   SpellId = 213771, Name = "Размах",
        IsMovingCheck = "none",
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
}

-- Restoratin
BOMBER_DRUID_4 = {
    -- Healer spec impossible implemented
}