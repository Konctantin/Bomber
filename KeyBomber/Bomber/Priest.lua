-- Discipline
BOMBER_PRIEST_1 = {
    -- Healer spec impossible implemented
}

-- Holy
BOMBER_PRIEST_2 = {
    -- Healer spec impossible implemented
}

-- Shadow
BOMBER_PRIEST_3 = {
    OnLoad = function()
        SetInRangeSpell(8092);
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
            --or GetShapeshiftForm() ~= 4
            then
                return true;
            end
        end
    },
    {   SpellId = 15487, Name = "Безмолвие",
        RecastDelay       = 0,
        DropChanel        = true,
        CancelCasting     = true,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            if CheckInterrupt("target") then
                return true;
            end
        end
    },
    {   SpellId =  34433, Name = "Исчадие тьмы",
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
    {   SpellId = 34914, Name = "Прикосновение вампира",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return not PLAYER.IsMoving and select(3, HasDebuff("target", 589, "PLAYER")) < 3;
        end
    },
    {   SpellId = 8092, Name = "Взрыв разума",
        RecastDelay       = 0,
        DropChanel        = true,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = false,
        Target            = "target",
        Func = function(ability)
            return not PLAYER.IsMoving;
        end
    },
    {   SpellId = 228260, Name = "Извержение бездны",
        RecastDelay       = 0,
        DropChanel        = true,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return true;
        end
    },
    {   SpellId = 15407, Name = "Пытка разума",
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