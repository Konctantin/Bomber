local ACTION_BAR_TYPES = { 'Action', 'MultiBarBottomLeft', 'MultiBarBottomRight', 'MultiBarRight', 'MultiBarLeft' };

BOMBER_ABILITY = {
    AbilityId = nil, -- spell or item id or macro name
    AbilityType = "spell", -- spell, item, macro
    __index = {

        IsAvailable = function(self)
            -- todo: few checks
        end,

        GetHotKeyId = function(self)
            for _, barName in pairs(ACTION_BAR_TYPES) do
                for i = 1, 12 do
                    local button = _G[barName .. 'Button' .. i];
                    if button and button.HotKey then
                        local actionType, actionId = GetActionInfo(button:GetID());

                        if ((self.AbilityType == "spell" or self.AbilityType == "item") and actionType == self.AbilityType and actionId == self.AbilityId) or
                            (self.AbilityType == "macro" and actionType == self.AbilityType and GetMacroInfo(actionId) == self.AbilityId) then
                            local hotKey = string.upper(tostring(button.HotKey:GetText()));
                            local color = BOMBER_KEYMAP[hotKey]
                            if color then
                                return color;
                            end
                        end
                    end
                end
            end
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