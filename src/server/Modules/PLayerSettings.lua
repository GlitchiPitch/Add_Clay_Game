-- Get from donut tycoon save/load data module

local ClayShopScreen = require(game:GetService('ServerScriptService').Modules.ClayShopScreen)


local createVariables = function(player)
	local variablesFolder = Instance.new("Folder")
	variablesFolder.Name = "PlayerProperties"

	local money = Instance.new("IntValue")
	money.Parent = variablesFolder

	variablesFolder.Parent = player
	-- return variablesFolder
end



return {
	newPlayer = function(player)
		createVariables(player)
		ClayShopScreen.new(player.PlayerGui)
	end,
	getClayShopScreen = function(player)
		return player.PlayerGui:FindFirstChild('mainGui'):FindFirstChild('clayShopScreen')
	end
}
