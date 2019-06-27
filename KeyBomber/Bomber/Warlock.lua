
-- Affiction
BOMBER_WARLOCK_1 = {
    OnLoad = function()
        SetInRangeSpell(232670);
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
    {   SpellId = 980, Name = "Агония",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
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
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
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
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if not IsMoving() and UnitHealth("target") > UnitHealth("palyer") then
                local count = 0;
                for i = 1, 40 do
                    local spellId = UnitDebuff("target", i, "PLAYER");
                    if not spellId then break end
                    if spellId == 30108 then
                        count = count + 1
                    end
                end
                if count < 3 or UnitPower("player", 7) > 4 then
                    return true;
                end
            end
        end
    },
    {   SpellId = 232670, Name = "Стрела Тьмы",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            return true
        end
    },
}

-- Demonology
BOMBER_WARLOCK_2 = {
    OnLoad = function()
        SetInRangeSpell(232670);
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
}

-- Destruction
BOMBER_WARLOCK_3 = {
    OnLoad = function()
        SetInRangeSpell(17962);
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
    {   SpellId = 348, Name = "Жертвенный огонь",
        IsMovingCheck     = "none",
        RecastDelay       = 2,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if select(3, HasDebuff("target", 157736, "PLAYER")) < 4 then
                return true;
            end
        end
    }, {   SpellId = 17962, Name = "Поджигание", -- lol
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if not HasBuff("player", 117828) then
                return true;
            end
        end
    }, {   SpellId = 116858, Name = "Стрела Хаоса",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if not IsMoving() and not BOMBER_AOE then
                return true;
            end
        end
    }, {   SpellId = 29722, Name = "Испепеление",
        IsMovingCheck     = "none",
        RecastDelay       = 0,
        DropChanel        = false,
        CancelCasting     = false,
        IsCheckInCombat   = true,
        RangeCheck        = true,
        Target            = "target",
        Func = function(ability)
            if not IsMoving() or HasBuff("player", 279673) then
                return true;
            end
        end
    },
}