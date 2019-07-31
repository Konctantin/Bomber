
local function PrintRangeCheck(spellId, spellBookId, spellBookType)
    local currentSpellName = GetSpellBookItemName(spellBookId, spellBookType);
    local link = GetSpellLink(spellBookId, spellBookType);

    local hasRange = SpellHasRange(spellBookId, spellBookType);
    local inRange = IsSpellInRange(spellBookId, spellBookType, "target");

    local hasRangePrefix = "|cffff0000";
    if hasRange then
        hasRangePrefix = "|cff00ff00";
    end

    local inRangePrefix = "|cffff0000";
    if inRange then
        inRangePrefix = "|cff00ff00";
    end

    print("|cff30ff60".."("..tostring(spellId)..") "..(link or "<none>").."|r ("..tostring(spellBookId)..") =>  HasRange: "
        ..hasRangePrefix..tostring(hasRange).."|r InRange: "..inRangePrefix..tostring(inRange).."|r")
end

function CheckSpellHasRange()
    print("|cff00ff00 Start range check...")
    if not UnitExists("target") then
        print("|cffff0000 You must select a unit of target!")
        return;
    end

    if BomberFrame.RangeSpellBookId then
        PrintRangeCheck(0, BomberFrame.RangeSpellBookId, BomberFrame.RangeSpellBookType);
    end

    for i, ability in ipairs(BomberFrame.AbilityList) do
        if ability.SpellId > 0 then
            PrintRangeCheck(ability.SpellId, ability.SpellBookId, ability.SpellBookType);
        end
    end

    print("|cffff0000 End range check.")
end

function DumpSpellBook()
    local _, _, offs, numspells = GetSpellTabInfo(2);
    local maxSpellNum = offs + numspells;

    print("======================");
    for _, bookType in ipairs({"spell", "pet"}) do
        print("====>", bookType)
        for spellBookID = offs, maxSpellNum do
            local link = GetSpellLink(spellBookID, bookType);
            local type, baseSpellID = GetSpellBookItemInfo(spellBookID, bookType);
            local baseLink = GetSpellLink(baseSpellID);
            if link then
                local currentSpellID = tonumber(link and link:gsub("|", "||"):match("spell:(%d+)"));
                print(format("|cff00ff00%s|r: [|cff00ff00%d|r] - (|cff6f0a9a%d|r) |cff00ff00%s|r -> %s",
                    bookType, spellBookID, currentSpellID, link, baseLink));
            end
        end
    end

    print("======================")
end

SLASH_RCHECK1= '/rcheck'
SLASH_DUMPSP1= '/dumpsp'
SLASH_BOMBERPAUSE1= '/bomberpause'

function SlashCmdList.RCHECK(msg)
    CheckSpellHasRange();
end

function SlashCmdList.DUMPSP(msg)
    DumpSpellBook();
end

function SlashCmdList.BOMBERPAUSE(msg)
    local delay = tonumber(string.match(msg, "(%d+)")) or 0;
    if delay > 0 and delay < 10000 then
        BomberFrame.LastTime = GetTime() + (delay/1000);
    else
        BomberFrame.LastTime = GetTime() + 1;
    end
end
