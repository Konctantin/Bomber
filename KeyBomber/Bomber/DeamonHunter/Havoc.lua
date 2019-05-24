{
    CLASS = "DeamonHunter",
    SPEC = "Havoc",
    Core = function()
	    -- body
    end,


    AbilityList = {
        {
            Name = "Spell 1",
            Spell = 123,

            TargetList = { "target", "focus", "mouseover" },
            Func = function(ability, targer)
            end,
        },
        {   SpellId =  20243, Name = "Сокрушение",
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
}
