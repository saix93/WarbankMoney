local targetFrame = BankPanel

-- Properties
local width = 160
local height = 120                                                    -- Height of the addon frame
local padding = 10                                                    -- Padding between buttons and the frame edges
local bigButtonWidth = width - padding * 2                            -- Full width minus padding
local numSmallButtons = 4                                             -- Total small buttons (2 rows)
local bigButtonHeightRatio = 0.3                                      -- Proportion of the height for the big button
local bigButtonHeight = height *
bigButtonHeightRatio                                                  -- Big button height as a fraction of the frame's height
local remainingHeight = height - bigButtonHeight -
padding * 2                                                           -- Remaining height after accounting for the big button and padding
local smallButtonHeight = remainingHeight /
(numSmallButtons / 2 + 1)                                             -- Height divided among the rows, considering additional padding
local smallButtonWidth = (width - padding * 3) / 2                    -- Half width minus padding for small buttons

-- Main frame
local addonFrame = CreateFrame("Frame", "WarbankMoney", targetFrame, "InsetFrameTemplate")

local function OnShow(self)
    addonFrame:Show()
end

local function OnHide()
    addonFrame:Hide()
end

targetFrame:HookScript("OnShow", OnShow)
targetFrame:HookScript("OnHide", OnHide)
addonFrame:SetPoint("BOTTOMRIGHT", targetFrame, "BOTTOMRIGHT", width, 0)
addonFrame:SetSize(width, height)
addonFrame:Hide()

-- Create a button function
local function CreateButton(name, text, size, position, onClick)
    local button = CreateFrame("Button", name, addonFrame, "UIPanelButtonTemplate")
    button:SetSize(size.width, size.height)
    button:SetPoint("TOPLEFT", addonFrame, "TOPLEFT", position.x, position.y)
    button:SetText(text)
    button:SetScript("OnClick", onClick)
    return button
end

local function GetWithdrawableMoney(amount)
    local maxAmount = C_Bank.FetchDepositedMoney(2)

    if amount > maxAmount then
        return maxAmount
    else
        return amount
    end
end

-- "Deposit All" button
CreateButton("DepositAllButton", "Deposit All",
    { width = bigButtonWidth, height = bigButtonHeight },
    { x = padding, y = -padding },
    function()
        C_Bank.DepositMoney(2, GetMoney())
    end
)

-- "+1k" button
CreateButton("Get1kButton", "+1k",
    { width = smallButtonWidth, height = smallButtonHeight },
    { x = padding, y = -bigButtonHeight - padding * 1.5 },
    function()
        C_Bank.WithdrawMoney(2, GetWithdrawableMoney(10000000))
    end
)

-- "+10k" button
CreateButton("Get10kButton", "+10k",
    { width = smallButtonWidth, height = smallButtonHeight },
    { x = smallButtonWidth + padding * 2, y = -bigButtonHeight - padding * 1.5 },
    function()
        C_Bank.WithdrawMoney(2, GetWithdrawableMoney(100000000))
    end
)

-- "+100k" button
CreateButton("Get100kButton", "+100k",
    { width = smallButtonWidth, height = smallButtonHeight },
    { x = padding, y = -bigButtonHeight - smallButtonHeight - padding * 2.5 },
    function()
        C_Bank.WithdrawMoney(2, GetWithdrawableMoney(1000000000))
    end
)

-- "+1M" button
CreateButton("Get1MButton", "+1M",
    { width = smallButtonWidth, height = smallButtonHeight },
    { x = smallButtonWidth + padding * 2, y = -bigButtonHeight - smallButtonHeight - padding * 2.5 },
    function()
        C_Bank.WithdrawMoney(2, GetWithdrawableMoney(10000000000))
    end
)
