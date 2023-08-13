
local GameSettings = game:GetService('ServerScriptService').Modules.GameSettings

local commonFunctions = {}

commonFunctions.ShowHowMuchGetCash = function(instance, cost)
	local billboardGui = Instance.new('BillboardGui')
    billboardGui.Parent = instance
	billboardGui.AlwaysOnTop = true
	billboardGui.MaxDistance = 150
	billboardGui.Size = UDim2.new(4,0,2,0)

	local label = Instance.new('TextLabel')
    label.Parent = billboardGui
	label.Size = UDim2.new(1,0,1,0)
	GameSettings.SetText(label, cost .. '$')

	local timer = 1
	local tween = game:GetService('TweenService'):Create(billboardGui, TweenInfo.new(1, Enum.EasingStyle.Sine), {StudsOffsetWorldSpace = Vector3.new(0,5,0)})
	tween:Play()
	--tween.Completed:Wait()
	task.wait(timer)
	billboardGui:Destroy()
end

commonFunctions.createWarningGui = function(plrGui, text: string)
	local label = Instance.new('TextLabel')
    label.Parent = plrGui
	label.Size = UDim2.new(.3,0,.15,0)
	label.AnchorPoint = Vector2.new(.5,0)
	label.Position = UDim2.new(.5,0,.2,0)
	GameSettings.SetText(label, text)
    task.wait(2)
	label:Destroy()
end

return commonFunctions