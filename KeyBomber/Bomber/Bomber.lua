
BomberFrame = CreateFrame("Frame", nil, UIParent);
BomberFrame:SetFrameStrata("BACKGROUND");
BomberFrame:SetWidth(20);
BomberFrame:SetHeight(10);
BomberFrame:SetPoint("BOTTOMLEFT", "UIParent");

BomberFrameMod = CreateFrame("Frame", BomberFrame, UIParent);
BomberFrameMod:SetFrameStrata("BACKGROUND");
BomberFrameMod:SetWidth(10);
BomberFrameMod:SetHeight(10);
BomberFrameMod:SetPoint("LEFT", "UIParent");
BomberFrameMod.texture = BomberFrameKey:CreateTexture(nil, "BACKGROUND");
BomberFrameMod.texture:SetAllPoints(true);
BomberFrameMod.texture:SetColorTexture(1.0, 1.0, 1.5, 1);

BomberFrameKey = CreateFrame("Frame", BomberFrame, UIParent);
BomberFrameKey:SetFrameStrata("BACKGROUND");
BomberFrameKey:SetWidth(10);
BomberFrameKey:SetHeight(10);
BomberFrameKey:SetPoint("RIGHT", "UIParent");
BomberFrameKey.texture = BomberFrameKey:CreateTexture(nil, "BACKGROUND");
BomberFrameKey.texture:SetAllPoints(true);
BomberFrameKey.texture:SetColorTexture(1.0, 0.5, 0.0, 1);

BomberFrame:Show();

function BomberFrame.SetModidier(modifier)
    --
end

function BomberFrame.SetKey(key)
    --
end