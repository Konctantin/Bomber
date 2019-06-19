
-- Affiction
BOMBER_WARLOCK_1 = {
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
            BomberFrame.RangeSpell = GetSpellInfo(232670);
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
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
            return true
        end
    },
}

-- Demonology
BOMBER_WARLOCK_2 = {
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
            BomberFrame.RangeSpell = GetSpellInfo(232670);
            if IsMounted() then
                return true;
            end
        end
    },
}

-- Destruction
BOMBER_WARLOCK_3 = {
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
            BomberFrame.RangeSpell = GetSpellInfo(17962);
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
        IsUsableCheck     = true,
        RangeCheck        = true,
        TargetList = {
            { Target = "target" }
        },
        Func = function(ability, targetInfo, target)
            if select(3, HasDebuff("target", 157736, "PLAYER")) < 4 then
                return true;
            end
        end
    },
    {   SpellId = 17962, Name = "Поджигание",
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
            if not HasBuff("player", 117828) then
                return true;
            end
        end
    },
    {   SpellId = 116858, Name = "Стрела Хаоса",
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
            if not IsMoving() and not BOMBER_AOE then
                return true;
            end
        end
    },
    {   SpellId = 29722, Name = "Испепеление",
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
            if not IsMoving() or HasBuff("player", 279673) then
                return true;
            end
        end
    },
}