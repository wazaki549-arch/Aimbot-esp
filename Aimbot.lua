--// THE FLY //--
-- Solo para tu propio juego / testing
-- LocalScript en StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local aimEnabled = false
local espEnabled = false
local aimRadius = 150 -- radio de ayuda de apuntado
local smoothness = 0.15 -- entre más bajo, más rápido

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TheFlyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 170)
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "THE FLY"
Title.TextColor3 = Color3.fromRGB(180, 0, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = Main

local function createButton(text, yPos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.85, 0, 0, 38)
	btn.Position = UDim2.new(0.075, 0, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 18
	btn.Text = text
	btn.Parent = Main
	
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 10)
	
	return btn
end

local AimButton = createButton("Aim Assist: OFF", 50)
local EspButton = createButton("ESP: OFF", 95)
local CloseButton = createButton("Cerrar", 140)

-- FOV Circle
local Circle = Drawing.new("Circle")
Circle.Visible = true
Circle.Radius = aimRadius
Circle.Color = Color3.fromRGB(180, 0, 255)
Circle.Thickness = 2
Circle.Filled = false
Circle.Transparency = 1

-- Crear ESP
local function addESP(player)
	if player == LocalPlayer then return end
	
	local function setupChar(char)
		if not char then return end
		
		if not char:FindFirstChild("FlyHighlight") then
			local highlight = Instance.new("Highlight")
			highlight.Name = "FlyHighlight"
			highlight.FillColor = Color3.fromRGB(180, 
