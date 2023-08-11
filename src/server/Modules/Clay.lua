local Clay = {}

Clay.__index = Clay

function Clay.new(parent, size, anchor, color)
	local clay = Instance.new("Part")
	clay.Parent = parent
	clay.Size = size
	clay.Anchored = anchor
    clay.Color = color
    
    return clay
end

return Clay
