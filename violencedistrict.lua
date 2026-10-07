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
local InfoTab = Window:CreateTab("Информация")

-- Быстрый взлом
MainTab:CreateSection("Быстрый взлом")
MainTab:CreateSlider({
    Name = "Скорость бега (Speed Hack)",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
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

-- ESP для игроков и убийцы (Боксы + Подсветка + Ник)
ESPTab:CreateSection("ESP Настройки")
local ESPEnabled = false

ESPTab:CreateToggle({
    Name = "Включить ESP (Игроки / Убийца)",
    CurrentValue = false,
    Callback = function(Value)
        ESPEnabled = Value
        task.spawn(function()
            while ESPEnabled do
                task.wait(0.5)
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character then
                        local char = player.Character
                        local rootPart = char:FindFirstChild("HumanoidRootPart")
                        local head = char:FindFirstChild("Head")
                        
                        if rootPart and head then
                            -- Проверка на убийцу (например, если в руках нож/оружие или по команде/тегу)
                            -- Здесь можно настроить логику под конкретную игру, пока что проверяем наличие любого инструмента
                            local isMurderer = false
                            local humanoid = char:FindFirstChildOfClass("Humanoid")
                            if player.Backpack:FindFirstChild("Knife") or (char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool").Name:lower():find("knife")) then
                                isMurderer = true
                            end

                            local boxColor = isMurderer and Color3.new(1, 0, 0) or Color3.new(0, 1, 0) -- Красный для убийцы, зеленый для остальных
                            local roleText = isMurderer and " [УБИЙЦА]" or " [Игрок]"

                            -- 1. Подсветка персонажа (Highlight)
                            local highlight = char:FindFirstChild("NX_Highlight")
                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.Name = "NX_Highlight"
                                highlight.Adornee = char
                                highlight.Parent = char
                            end
                            highlight.FillColor = boxColor
                            highlight.OutlineColor = Color3.new(1, 1, 1)
                            highlight.FillTransparency = 0.5

                            -- 2. Текст над головой
                            local billboard = head:FindFirstChild("NX_ESPText")
                            if not billboard then
                                billboard = Instance.new("BillboardGui", head)
                                billboard.Name = "NX_ESPText"
                                billboard.Size = UDim2.new(0, 120, 0, 50)
                                billboard.AlwaysOnTop = true
                                billboard.StudsOffset = Vector3.new(0, 2, 0)
                                
                                local textLabel = Instance.new("TextLabel", billboard)
                                textLabel.Name = "Label"
                                textLabel.Size = UDim2.new(1, 0, 1, 0)
                                textLabel.BackgroundTransparency = 1
                                textLabel.TextScaled = true
                                textLabel.TextColor3 = boxColor
                                textLabel.TextStrokeTransparency = 0 -- Обводка текста для читаемости
                            end
                            
                            local label = billboard:FindFirstChild("Label")
                            if label then
                                label.Text = player.Name .. roleText
                                label.TextColor3 = boxColor
                            end
                        end
                    end
                end
            end
            
            -- Очистка ESP при выключении
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Character then
                    local hl = player.Character:FindFirstChild("NX_Highlight")
                    if hl then hl:Destroy() end
                    if player.Character:FindFirstChild("Head") then
                        local esp = player.Character.Head:FindFirstChild("NX_ESPText")
                        if esp then esp:Destroy() end
                    end
                end
            end
        end)
    end,
})

-- Вкладка информации о владельце и ТГК
InfoTab:CreateSection("Создатель и Сообщество")
InfoTab:CreateParagraph({Title = "Владелец скрипта", Content = "Создатель и разработчик: kopylovpavelakk (nexuc)"})
InfoTab:CreateParagraph({Title = "Наш Telegram канал", Content = "Подписывайся на наш ТГК, чтобы не пропускать новые скрипты и обновления!"})

InfoTab:CreateButton({
    Name = "Скопировать ссылку на ТГК (заглушка)",
    Callback = function()
        -- Здесь можно вставить свою ссылку на ТГК, если экзекутор поддерживает буфер обмена
        if setclipboard then
            setclipboard("https://t.me/твой_канал")
            Rayfield:Notify({Title = "Успех", Content = "Ссылка скопирована в буфер обмена!", Duration = 3})
        else
            Rayfield:Notify({Title = "Информация", Content = "Твой ТГК: t.me/твой_канал", Duration = 5})
        end
    end,
})

Rayfield:Notify({
    Title = "Успешный запуск!",
    Content = "Скрипт Violence District загружен.",
    Duration = 6.5,
})
