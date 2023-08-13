-- Working on server side but clay powers will be sent to the client side, and some functions will work on the server

local GameProperties = require(game:GetService('ServerScriptService').Modules.GameProperties)

local colorList = GameProperties.ColorList

local BLACK_SUB_VALUE = 0.5
local GREEN_DEBRIS_LIFETIME = 1
local RED_CLAY_LIFETIME = 5

local ClayPowers = {}

function ClayPowers.SetPower(color)
	local colorName = ClayPowers.GetColorName(color)
	local power = table.find(ClayPowers, colorName .. "Power", 1)
	return power
end

function ClayPowers.GetColorName(color)
	for name, list in pairs(colorList) do
		if list["color"] == color then
			return name
		end
	end
	return "black"
end

function ClayPowers.pinkPower(instance)
    -- this power will show invisibily obby
    local debris = instance.Parent:FindFirstChild('Debris'):GetChildren()

    local function showItem(item)
        item.Material = Enum.Material.ForceField
        item.Transparency = 0
        item.CanCollide = true
        item.Color = instance.Color
    end

    for _, item in pairs(debris) do
        showItem(item)        
    end

end

function ClayPowers.cyanPower(instance) 
    local charge = 5
	instance.Material = Enum.Material.Neon

	instance.Touched:Connect(function(hitPart)
		local humanoid = hitPart.Parent:FindFirstChild('Humanoid')
		if not humanoid then return end
		instance.CanTouch = false
		charge -= 1
		humanoid.JumpPower = 150 -- привязать увеличение прыжка к размерам блока
		-- добавить партиклс на ноги чтобы показать усиление прыжка
		if charge <= 0 then
			instance.Material = Enum.Material.Plastic
			task.wait(5)
			instance:Destroy()
		end
		task.wait(5)
        humanoid.JumpPower = 50
		instance.CanTouch = true
	end)
end

function ClayPowers.yellowPower(instance)
	local nearestYellowClay = Instance.new("ObjectValue") -- , clay
	nearestYellowClay.Name = "nearestYellowClay"
	nearestYellowClay.Parent = instance

	local function getNearPart()
		local connectedPart = instance.Parent:FindFirstChild(tostring(tonumber(instance.Name) + 1))
		-- print(connectedPart)
		if connectedPart:GetAttribute("Activated") then
			-- print("find near")
			instance.nearestYellowClay.Value = connectedPart
			return true
		elseif not connectedPart then
			-- print("near not exist")
			return false
		end
		-- return false
	end

	local childAddedSignal
	local teleportCharacterRE = Instance.new("RemoteEvent")

	teleportCharacterRE.OnServerEvent:Connect(function(player, humanoidRootPart, nearPartCFrame)
        print('teleport ' .. player.Name)
		humanoidRootPart.CFrame = nearPartCFrame
	end)

	if not getNearPart() then
		print("childDetected")
		childAddedSignal = instance.Parent.ChildAdded:Connect(function()
			task.wait(3)
			print(instance.Name .. " " .. "Changed")
			if getNearPart() then
				print("disconnect")
				childAddedSignal:Disconnect()
			end
		end)
	end

	instance.Touched:Connect(function(otherPart)
		print("TOUCHED" .. instance.Name)
		local humanoidRootPart = otherPart.Parent:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			local nearPart = instance.nearestYellowClay
			print(nearPart.Value)
			if nearPart.Value ~= nil then
				teleportCharacterRE:FireServer(humanoidRootPart, nearPart.Value.CFrame)
				-- remotes.ClayPowerRemotes.yellowClayPower:FireServer(humanoidRootPart, nearPart.Value.CFrame)
			end
		end
	end)

	-- clay.CanCollide = false
	-- clay.Transparency = .8
end

function ClayPowers.redPower(instance)

	local function gravity(item)
		local AlignPosition = Instance.new("AlignPosition") -- , clay
		AlignPosition.Parent = instance
		local passiveAttachment = Instance.new("Attachment") -- , item
		passiveAttachment.Parent = item
		local activeAttachment = Instance.new("Attachment") -- , clay
		activeAttachment.Parent = instance

		AlignPosition.Attachment0 = passiveAttachment
		AlignPosition.Attachment1 = activeAttachment

		AlignPosition.MaxForce = 100000000
		return AlignPosition
	end

	local function nearest()
		local debris = instance.Parent:FindFirstChild("Debris"):GetChildren()
		for _, v in pairs(debris) do
			if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
				if v.Anchored then
					v.Anchored = false
				end
				gravity(v)
			end
		end
		wait(5)
		for _, item in pairs(debris:GetChildren()) do
			if item:IsA("AlignPosition") or item:IsA("Attachment") then
				item:Destroy()
			end
		end
		instance.Anchored = false
	end

	nearest()
	wait(RED_CLAY_LIFETIME)
	instance:Destroy()
end

function ClayPowers.bluePower(instance) 
    local debris = instance.Parent:FindFirstChild('Debris'):GetChildren()

	local function createSilhouette(item)
		local faces = Enum.NormalId:GetEnumItems()
		for i = 1,#faces do -- 6
			local surfaceGui = Instance.new('SurfaceGui')
            surfaceGui.Parent = item
			game:GetService('Debris'):AddItem(surfaceGui, 60)
			surfaceGui.Face = faces[i]
			local label = Instance.new('ImageLabel')
            label.Parent = surfaceGui
			label.Size = UDim2.fromScale(1,1)
			label.BackgroundTransparency = 1
			surfaceGui.AlwaysOnTop = true
			label.Image = 'rbxassetid://12754479702'
		end
	end

	if debris then
		for _, item in pairs(debris) do
			createSilhouette(item)
			--v.Transparency = .5
			task.wait(.2)
		end
	end
end

function ClayPowers.greenPower(instance)
	local debrisLifeTime = GREEN_DEBRIS_LIFETIME

	local debris = instance.Parent:FindFirstChild("Debris"):GetChildren()

	local function getRandomDebris()
		local currentDebris = debris[#debris]
		table.remove(debris, table.find(debris, currentDebris, 1))
		currentDebris.Touched:Connect(function(hitPart)
			local humanoid = hitPart.Parent:FindFirstChild("Humanoid")
			if not humanoid then
				return
			end
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

	coroutine.wrap(function()
		while #debris > 0 do
			destroyDebris(getRandomDebris()) -- if debris then <<>> end
		end
		instance:Destroy()
	end)()
end

function ClayPowers.blackPower(instance)

	local function getStrength()
		local strength = (math.max(table.unpack({ instance.Size.X, instance.Size.Y, instance.Size.Z })))
		return strength
	end

	instance:SetAttribute("Strength", getStrength())

	instance.Touched:Connect(function()
		local x, y, z
		instance.CanTouch = false
		if instance.Size.X > BLACK_SUB_VALUE then x = BLACK_SUB_VALUE else x = 0 end
		if instance.Size.Y > BLACK_SUB_VALUE then y = BLACK_SUB_VALUE else y = 0 end
		if instance.Size.Z > BLACK_SUB_VALUE then z = BLACK_SUB_VALUE else z = 0 end
		instance.Size -= Vector3.new(x, y, z)
		local tween = game:GetService("TweenService"):Create(
			instance,
			TweenInfo.new(2, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, 10, true),
			{ Size = instance.Size - Vector3.new(0.5, 0.5, 0.5) }
		)
		tween:Play()
		tween.Completed:Wait()
		-- task.wait(2)
		instance:SetAttribute("Strength", instance:GetAttribute("Strength") - 1)
		instance.CanTouch = true
		if instance:GetAttribute("Strength") <= 0 then
			instance:Destroy()
		end
	end)
end

return ClayPowers
