local ColorList = {
    black = {['color'] = Color3.new(0,0,0)}
}

local ClayPowers = {}

function ClayPowers.SetPower(color)
    local colorName = ClayPowers.GetColorName(color)
    local power = table.find(ClayPowers, colorName .. 'Power', 1)
    return power
end

function ClayPowers.GetColorName(color)
    
    for name, list in pairs(ColorList) do
        if list['color'] == color then
            return name
        end
    end
    return 'black'
end

function ClayPowers:OnTouched(instance, callback)
    instance.Touched:Connect(function(hitPart)
        local character = hitPart:FindFirstChild('Humanoid').Parent
        if not character then return end
        callback()
    end)
end

function ClayPowers.blackPower(instance)

    return ClayPowers:OnTouched(instance, function()
        print('ok')
    end)
end

return ClayPowers