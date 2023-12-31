-- Working on client side

-- If clayVoid has parts which are will changed somehow, put clayVoid into model and parts to Folder with name "Debris"

local remotes = game:GetService('ReplicatedStorage').Remotes
local binds = game:GetService('ReplicatedStorage').Binds

local Modules = game:GetService('ServerScriptService').Modules
local ClayPowers = require(Modules.ClayPowers)
local Clay = require(Modules.Clay)

local ClayVoid = {}

ClayVoid.__index = ClayVoid

function ClayVoid.new(instance)
    local self = setmetatable({}, ClayVoid)

    self.Instance = instance
    self.Color = self.Instance.Color
    self.Cost = self:GetVolume(self.Instance)
    self.Power = self:GetPower()
    self.Instance.Transparency = .5
    self.Instance.CanCollide = false
    
    return self
end

function ClayVoid:Init()
    print('ClayVoid init')
    self.Instance:SetAttribute('Activated', false)
end

function ClayVoid:GetPower()
    local power = ClayPowers.SetPower(self.Color)
    return power
end

function ClayVoid:StartPower()
    self.Power(self.Instance)
    -- remotes.setMoney:FireClient
end

function ClayVoid:ChangeChildClay(childClay)
    local x,y,z
    if childClay.Size.X < self.Instance.Size.X then x = .5 else x = 0 end
    if childClay.Size.Y < self.Instance.Size.Y then y = .5 else y = 0 end  
    if childClay.Size.Z < self.Instance.Size.Z then z = .5 else z = 0 end 
    childClay.Size += Vector3.new(x,y,z)
end

function ClayVoid:UpgradeClay()
    local childClay = self.Instance:FindFirstChildIsA('Part')
    if childClay then
        self:ChangeChildClay(childClay)
        if self:GetVolume(childClay) >= self:GetVolume(self.Instance) then
            self:Activated(childClay)
        end
    else
        Clay.new(self.Instance, Vector3.new(0.5, 0.5, 0.5), true, self.Color)
    end
end

function ClayVoid:ShowActivated()
    -- this is function shows particles
end

function ClayVoid:Activated(childClay) 
        childClay:Destroy()
        self.Instance:SetAttribute('Activated', true)
        self:StartPower()
end

function ClayVoid:GetVolume(instance)
    local highestVector = (math.max(table.unpack({instance.Size.X, instance.Size.Y, instance.Size.Z})))
    local clayVolume = ((highestVector * 2) + highestVector)
    return clayVolume
end

return ClayVoid