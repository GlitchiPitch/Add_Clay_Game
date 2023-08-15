-- Working on server side
local PlayerSettings = require(game:GetService('ServerScriptService').Modules.PLayerSettings)

local ClayShop = {}

ClayShop.__index = ClayShop

function ClayShop.new(instance)
    local self = setmetatable({}, ClayShop)

    self.Model = instance

    return self
end

function ClayShop:Init()
    self.Button = self.Model:FindFirstChild('shopButton')
    self.Button.Triggered:Connect(function(player)
        local clayShopScreen = PlayerSettings.getClayShopScreen(player)
        if clayShopScreen.Visible then
            clayShopScreen.Visible = false
        else
            clayShopScreen.Visible = true
        end
    end)
end

return ClayShop