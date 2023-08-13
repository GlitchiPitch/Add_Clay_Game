local remotes = game:GetService('ReplicatedStorage').Remotes

local player = game:GetService('Players').LocalPlayer
local playerGui = player.PlayerGui.MainGui

local playerProperties = player:FindFirstChild('PlayerProperties') -- Folder
local clayShopScreen = playerGui:FindFirstChild('clayShopScreen') -- Frame
local playerPropertiesScreen = playerGui:FindFirstChild('playerPropertiesScreen') -- Frame

remotes.clayShopScreen.OnClientEvent:Connect(function()
    if clayShopScreen.Visible then
        clayShopScreen.Visible = false
    else
        clayShopScreen.Visible = true
    end
end)

playerProperties.Money.Changed:Connect(function(value)
    playerPropertiesScreen.Money.Text = value
end)