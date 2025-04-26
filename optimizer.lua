
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")


Lighting.GlobalShadows = false
Lighting.FogEnd = math.huge
Lighting.Brightness = 0
Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0

for _, obj in ipairs(Lighting:GetChildren()) do
    if obj:IsA("Sky") or obj:IsA("Clouds") then
        obj:Destroy()
    end
end

local function cleanVisuals(model)
    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        elseif obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            obj.CastShadow = false 
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") then
            obj.Enabled = false
        elseif obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("Accessory") or obj:IsA("ShirtGraphic") then
            obj:Destroy()
        elseif obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") then
            obj:Destroy()
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    if player.Character then
        cleanVisuals(player.Character)
    end
end

cleanVisuals(Workspace)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        cleanVisuals(char)
    end)
end)


Workspace.Terrain.WaterWaveSize = 0
Workspace.Terrain.WaterWaveSpeed = 0
Workspace.Terrain.WaterReflectance = 0
Workspace.Terrain.WaterTransparency = 0

print("Success")
