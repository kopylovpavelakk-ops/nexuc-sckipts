-- NX // nexuc sckipts | Violence District
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "NX // nexuc sckipts | Violence District",
   LoadingTitle = "Violence District Hub",
   LoadingSubtitle = "by nexuc",
   ConfigurationSaving = {
      Enabled = false,
   },
   KeySystem = false,
})

local MainTab = Window:CreateTab("Главная", 4483362458)
local ESPTab = Window:CreateTab("ESP", 4483362458)
local MiscTab = Window:CreateTab("Разное", 4483362458)

-- Speed Hack
MainTab:CreateSlider({
   Name = "Скорость бега (Speed Hack)",
   Range = 16,
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      pcall(function()
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end)
   end,
})

-- FullBright
MiscTab:CreateToggle({
   Name = "FullBright (Убрать темноту)",
   CurrentValue = false,
   Flag = "FullBrightToggle",
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

-- Player ESP
local ESPPlayers = false
ESPTab:CreateToggle({
   Name = "Игроки ESP",
   CurrentValue = false,
   Flag = "PlayerESPToggle",
   Callback = function(Value)
      ESPPlayers = Value
      task.spawn(function()
         while ESPPlayers do
            task.wait(1)
            for _, player in ipairs(game.Players:GetPlayers()) do
               if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                  if not player.Character.Head:FindFirstChild("NX_ESP") then
                     local bb = Instance.new("BillboardGui")
                     bb.Name = "NX_ESP"
                     bb.Size = UDim2.new(0, 50, 0, 50)
                     bb.AlwaysOnTop = true
                     bb.StudsOffset = Vector3.new(0, 2.5, 0)
                     
                     local text = Instance.new("TextLabel")
                     text.Size = UDim2.new(1, 0, 1, 0)
                     text.BackgroundTransparency = 1
                     text.Text = player.Name
                     text.TextColor3 = Color3.fromRGB(255, 0, 0)
                     text.TextScaled = true
                     text.Parent = bb
                     bb.Parent = player.Character.Head
                  end
               end
            end
         end
         -- Очистка ESP при выключении
         for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
               local esp = player.Character.Head:FindFirstChild("NX_ESP")
               if esp then esp:Destroy() end
            end
         end
      end)
   end,
})

Rayfield:Notify({
   Title = "Успешно запущен!",
   Content = "Скрипт Violence District загружен.",
   Duration = 6.5,
   Image = 4483362458,
})
