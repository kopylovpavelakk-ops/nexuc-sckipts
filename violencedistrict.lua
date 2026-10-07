-- NX // nexuc sckipts | Violence District
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
Name = "NX // nexuc sckipts | Violence District",
LoadingTitle = "Violence District",
LoadingSubtitle = "by nexuc",
ConfigurationSaving = {
Enabled = false,
},
KeySystem = false,
})
local MainTab = Window:CreateTab("Главная")
local ESPTab = Window:CreateTab("ESP")
local MiscTab = Window:CreateTab("Misc")
-- Быстрый взлом
MainTab:CreateSection("Быстрый взлом")
MainTab:CreateSlider({
Name = "Скорость бега (Speed Hack)",
Range = {16, 100},
Increment = 1,
CurrentValue = 16,
Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end,
})
-- Освещение
MainTab:CreateSection("Освещение (FullBright)")
MainTab:CreateToggle({
Name = "Включить FullBright",
CurrentValue = false,
Callback = function(Value)
if Value then
game.Lighting.Brightness = 2
game.Lighting.ClockTime = 14
game.Lighting.FogEnd = 100000
game.Lighting.GlobalShadows = false
else
game.Lighting.Brightness = 1
game.Lighting.GlobalShadows = true
end
end,
})
-- ESP для игроков
ESPTab:CreateSection("Игроки ESP")
local ESPPlayers = false
ESPTab:CreateToggle({
Name = "Игроки ESP",
CurrentValue = false,
Callback = function(Value)
ESPPlayers = Value
task.spawn(function()
while ESPPlayers do
task.wait(1)
for _, player in ipairs(game.Players:GetPlayers()) do
if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
if not player.Character.Head:FindFirstChild("ESPText") then
local billboard = Instance.new("BillboardGui", player.Character.Head)
billboard.Name = "ESPText"
billboard.Size = UDim2.new(0, 100, 0, 50)
billboard.AlwaysOnTop = true
local text = Instance.new("TextLabel", billboard)
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = player.Name
text.TextColor3 = Color3.new(1, 0, 0)
text.TextScaled = true
end
end
end
end
-- Очистка ESP при выключении
for _, player in ipairs(game.Players:GetPlayers()) do
if player.Character and player.Character:FindFirstChild("Head") then
local esp = player.Character.Head:FindFirstChild("ESPText")
if esp then
esp:Destroy()
end
end
end
end)
end,
})
Rayfield:Notify({
Title = "Успешный запуск!",
Content = "Скрипт Violence District загружен.",
Duration = 6.5,
})
