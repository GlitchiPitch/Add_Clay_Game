return {
    ColorList = {
        black = { ["color"] = Color3.new(0, 0, 0) },
        cayn = { ["color"] = Color3.new(0, 0.4, 0.5) },
        pink = { ["color"] = Color3.new(0.8, 0.5, 0.8) },
    },
    SetText = function(label, text)
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextStorkeTransparency = 0
        label.BackgroundTransparency = 1
        label.TextScaled = true
        label.Font = Enum.Font.FredokaOne
        label.Text = text
    end

}