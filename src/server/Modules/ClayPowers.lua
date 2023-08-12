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



function ClayPowers.greenPower(instance)

    local debrisLifeTime = 1

    local debris = instance.Parent:FindFirstChild('Debris'):GetChildren()
    local function getRandomDebris()
        local currentDebris = debris[#debris]
        table.remove(debris, table.find(debris, currentDebris, 1))
        currentDebris.Touched:Connect(function(hitPart)
            local humanoid = hitPart.Parent:FindFirstChild('Humanoid')
            if not humanoid then return end
            humanoid.Health -= 5
        end)
        return currentDebris
    end

    local function destroyDebris(debris)
        debris.Color = instance.Color
        debris.Anchored = false
        task.wait(debrisLifeTime)
        -- play sound acid burn
        debris:Destory()

    end

    return coroutine.wrap(function()
        while #debris > 0 do
            destroyDebris(getRandomDebris())
        end
        instance:Destroy()
    end)


end

function ClayPowers.blackPower(instance)
    
    local subValue = .5

    local function getStrength()
        local strength = (math.max(table.unpack({instance.Size.X, instance.Size.Y, instance.Size.Z})))
        return strength
    end
    
    instance:SetAttribute('Strength', getStrength())

    return function(instance)
        instance.Touched:Connect(function()
            local x,y,z
            instance.CanTouch = false
            if instance.Size.X > subValue then x = subValue else x = 0 end 
            if instance.Size.Y > subValue then y = subValue else y = 0 end
            if instance.Size.Z > subValue then z = subValue else z = 0 end
            instance.Size -= Vector3.new(x,y,z)
            local tween = game:GetService('TweenService'):Create(instance, TweenInfo.new(2,Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, 10, true), {Size = instance.Size - Vector3.new(.5,.5,.5)})
            tween:Play()
            tween.Completed:Wait()
            -- task.wait(2)
            instance:SetAttribute('Strength', instance:GetAttribute('Strength') - 1)
            instance.CanTouch = true
            if instance:GetAttribute('Strength') <= 0 then instance:Destroy() end
        end)
    end
end

return ClayPowers