local Modules = game:GetService('ServerScriptService').Modules

local CollectionService = game:GetService('CollectionService')

local Game = {}

Game.__index = Game

function Game.new()
    local self = setmetatable({}, Game)
    return self
end

function Game:Init()
    for _, tag in ipairs(CollectionService:GetAllTags()) do
        if tag == 'TagEditorTagContainer' then continue end
        print(tag)
        if CollectionService:GetTagged(tag) then
            print('taaag')
            local module = require(Modules:FindFirstChild(tag))
            for _, item in pairs(CollectionService:GetTagged(tag)) do
                module.new(item)
            end
        else
            self:InitModules(tag)
        end
    end
end

function Game:InitModules(tag)
    local module = require(Modules:FindFirstChild(tag))
    module:Init()
end

return Game