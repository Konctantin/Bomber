BOMBER_ABILITY = {
    __index = {
        
        IsAvailable = function(self)
            -- todo: few checks
        end,

        GetType = function(self)
            return self.AbilityType;
        end,

        IsSpell = function(self)
            return (self.AbilityType or "spell") == "spell";
        end,

        IsItem = function(self)
            return self.AbilityType == "item";
        end,

        IsMacro = function(self)
            return (self.AbilityType == "macro") or (self.AbilityType == "macros");
        end,
    }
}