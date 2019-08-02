-- Balance
BOMBER_DRUID_1 = {
    OnLoad = function()
        SetInRangeSpell(8921);
    end,
    {   SpellId =      0, Name = "Initialization",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = false,
        RangeCheck        = false,
        Target            = "none",
        Func = function(ability)
            if IsMounted()
            or IsStealthed()
            or GetShapeshiftForm() ~= 4
            then
                return true;
            end
        end
    },
    {   SpellId = 78674, Name = "Столб солнечного света",
        RecastDelay       = 0,
        DropChanel        = true,
        CancelCasting     = true,
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
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if CheckUsedCooldown() then
                return true;
            end
        end
    },
    {   SpellId = 78674, Name = "Звездный поток",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return not BOMBER_AOE or UnitPower("player") > 90;
        end
    },
    {   SpellId = 93402, Name = "Солнечный огонь",
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
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if not PLAYER.IsMoving and BOMBER_AOE or HasBuff("player", 164547) then
                return true;
            end
        end
    },
    {   SpellId = 190984, Name = "Солнечный гнев",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return not PLAYER.IsMoving;
        end
    },
}

-- Feral
BOMBER_DRUID_2 = {
    OnLoad = function()
        SetInRangeSpell(5221);
    end,
    {      SpellId =      0, Name = "Initialization",
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
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if CheckUsedCooldown() then
                return true;
            end
        end
    },
    {   SpellId = 5217, Name = "Тигриное неистовство",
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
    {   SpellId =  22842, Name = "Железный мех",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "none",
        Func = function(ability)
            if PLAYER.HP < 80 and PLAYER.Agro > 2 then
                return true;
            end
        end
    },
    {   SpellId =   8921, Name = "Лунный огонь",
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
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if PLAYER.Agro < 3 or (UnitPower("player") > 80 and PLAYER.HP > 80) then
                return true;
            end
        end
    },
    {   SpellId =  33917, Name = "Увечье",
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