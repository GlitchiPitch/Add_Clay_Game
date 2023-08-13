-- Working on client side
local ClayShop = {}

ClayShop.__index = ClayShop

function ClayShop.new(instance)
    local self = setmetatable({}, ClayShop)

    self.Model = instance

    return self
end

function ClayShop:Init()
    self.Button = self.Model:FindFirstChild('shopButton')
    self.Button.Triggered:Connect(function()
        
    end)
end

return ClayShop