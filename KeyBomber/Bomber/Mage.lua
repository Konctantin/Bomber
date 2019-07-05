-- Arcane
BOMBER_MAGE_1 = {

}

-- Fire
BOMBER_MAGE_2 = {
    OnLoad = function()
        SetInRangeSpell(133);
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
    {   SpellId = 2139, Name = "Антимагия",
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
    {   SpellId = 235313, Name = "Ледяная преграда",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "player",
        Func = function(ability)
            if not HasBuff("player", 235313, "PLAYER") then
                return true
            end
        end
    },
    {   SpellId = 44457, Name = "Живая бомба",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return BOMBER_AOE;
        end
    },
    {   SpellId =  190319, Name = "Возгорание",
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
    {   SpellId = 11366, Name = "Огненная глыба",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if HasBuff("player", 48108, "PLAYER") then
                return true
            end
        end
    },
    {   SpellId = 257541, Name = "Пламя феникса",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if GetSpellCharges(257541) > 1 or HasBuff("player", 48107, "PLAYER") then
                return true;
            end
        end
    },
    {   SpellId = 108853, Name = "Огненный взрыв",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if GetSpellCharges(108853) > 1 or HasBuff("player", 48107, "PLAYER") then
                return true;
            end
        end
    },
    {   SpellId = 133, Name = "Огненный шар",
        IsMovingCheck     = "notmoving",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return true
        end
    },
    {   SpellId = 2948, Name = "Ожог",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return true
        end
    },
}

-- Frost
BOMBER_MAGE_3 = {
    OnLoad = function()
        SetInRangeSpell(116);
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
    {   SpellId = 11426, Name = "Ледяная преграда",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "player",
        Func = function(ability)
            if not HasBuff("player", 11426, "PLAYER") then
                return true
            end
        end
    },
    {   SpellId = 2139, Name = "Антимагия",
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
    {   SpellId = 30455, Name = "Ледяное копье",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if HasBuff("player", 44544, "PLAYER") or IsMoving() then
                return true
            end
        end
    },
    {   SpellId = 199786, Name = "Ледовый шип",
        IsMovingCheck     = "notmoving",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return true
        end
    },
    {   SpellId = 44614, Name = "Шквал",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if HasBuff("player", 190446, "PLAYER") then
                return true
            end
        end
    },
    {   SpellId = 116, Name = "Ледяная стрела",
        IsMovingCheck     = "notmoving",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return true
        end
    },
}