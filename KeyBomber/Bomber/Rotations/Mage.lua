-- Arcane
BOMBER_MAGE_1 = {

}

-- Fire
BOMBER_MAGE_2 = {
    OnLoad = function()
        SetInRangeSpell(133);
    end,
    {   SpellId =      0, Name = "Initialization",
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
    {   SpellId = 11366, Name = "Огненная глыба",
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
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return not PLAYER.IsMoving;
        end
    },
    {   SpellId = 2948, Name = "Ожог",
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
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return not PLAYER.IsMoving;
        end
    },
    {   SpellId = 44614, Name = "Шквал",
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
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return not PLAYER.IsMoving;
        end
    },
}