local ClayShop = {}

ClayShop.__index = ClayShop

function ClayShop.new(instance)
    local self = setmetatable({}, ClayShop)

    self.Model = instance

    return self
end

function ClayShop:Init()
    -- self.Button =
end

return ClayShop