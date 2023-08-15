local GameSettings = game:GetService("ServerScriptService").Modules.GameSettings

local ClayShopScreen = {}

function ClayShopScreen.new(plrGui)

	local screenGui = Instance.new('ScreenGui')
	screenGui.Name = 'mainGui'
	screenGui.Parent = plrGui

	local mainFrame = Instance.new("Frame") -- , clayShopGui
	mainFrame.Name = "clayShopScreen"
	mainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	mainFrame.Parent = screenGui

	local uiCorner = Instance.new("UICorner")
	uiCorner.Parent = mainFrame

	local buttonsFolder = Instance.new("Folder")
	buttonsFolder.Parent = mainFrame
	buttonsFolder.Name = "Buttons"

	local buttonPosX = 0
	local buttonPosY = 0

	for name, list in pairs(GameSettings.ColorList) do
		local button = Instance.new("TextButton")
		button.Parent = buttonsFolder
		button.Size = UDim2.new(0.2, 0, 0.2, 0)
		button.Name = name .. "Button"

		local uiCorner = Instance.new("UICorner")
		uiCorner.Parent = button

		if buttonPosX < 1 then
			button.Position = UDim2.new(buttonPosX, 0, buttonPosY, 0)
			buttonPosX += button.Size.X.Scale
		else
			buttonPosX = 0
			buttonPosY += button.Size.Y.Scale
			button.Position = UDim2.new(buttonPosX, 0, buttonPosY, 0)
			buttonPosX += button.Size.X.Scale
		end

		GameSettings.SetText(button, name .. ": " .. list["cost"])
		button.BackgroundColor3 = list["color"]

		button:SetAttribute("Cost", list["cost"])
		-- button:SetAttribute('Color', list['color'])
	end

	local function createMenuButton(name, text, pos)
		local button = Instance.new("TextButton")
		button.Parent = mainFrame
		button.AnchorPoint = Vector2.new(0, 1)

		button.Size = UDim2.new(0.2, 0, 0.1, 0)
		GameSettings.SetText(button, text)
		button.Name = name
		button.Position = pos

		return button
	end

	local purchaseFrame = Instance.new("Frame")
	purchaseFrame.Parent = mainFrame
	purchaseFrame.Name = "purchaseFrame"
	purchaseFrame.Size = UDim2.new(1, 0, 0.2, 0)
	purchaseFrame.Position = UDim2.new(0, 0, 1, 0)
	purchaseFrame.BackgroundTransparency = 1

	local function createLabel(sign, pos)
		local label = Instance.new("TextLabel")
		label.Parent = purchaseFrame
		label.Size = UDim2.new(0.3, 0, 1, 0)

		GameSettings.SetText(label, sign .. ":")
		label.Name = sign .. "Label"
		label.Position = pos
	end

	local amountLabel = createLabel("Amount", UDim2.new(0, 0, 0, 0))

	local textBox = Instance.new("TextBox")
	textBox.Parent = purchaseFrame
	textBox.Name = "AmountClay"
	GameSettings.SetText(textBox, 0)
	textBox.Position = UDim2.new(amountLabel.Size.X.Scale, 0, 0, 0)
	textBox.Size = UDim2.new(0.2, 0, 1, 0)
	local uiCorner = Instance.new("UICorner")
	uiCorner = textBox

	local totalLabel = createLabel("Total", UDim2.new(amountLabel.Size.X.Scale + textBox.Size.X.Scale, 0, 0, 0))
	local costLabel = createLabel("Cost", UDim2.new(totalLabel.Size.X.Scale + totalLabel.Position.X.Scale, 0, 0, 0))
	costLabel.Text = 0 .. "$"
	costLabel.Size = UDim2.new(1 - (totalLabel.Size.X.Scale + totalLabel.Position.X.Scale), 0, 1, 0)
	local uiCorner = Instance.new("UICorner")
	uiCorner = costLabel

	createMenuButton("closeButton", "Close Shop", UDim2.new(0, 0, 0, 0))
	createMenuButton("buyButton", "Buy clay", UDim2.new(0.8, 0, 0, 0))

	mainFrame.Visible = false

	-- ClayShopWork.ConnectingButtonsWork(buttons, variablesFolder)
	-- ClayShopWork.ConnectingOrgerScreenWork(totalCostScreen, variablesFolder)

	return mainFrame
end

return ClayShopScreen