local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local PANEL_SIZE = UDim2.fromOffset(560, 350)

local COLORS = {
	Background = Color3.fromRGB(22, 22, 28),
	Sidebar = Color3.fromRGB(27, 27, 34),
	Content = Color3.fromRGB(22, 22, 28),

	White = Color3.fromRGB(235, 235, 240),
	Gray = Color3.fromRGB(145, 145, 155),

	Accent = Color3.fromRGB(90, 120, 255),
	Off = Color3.fromRGB(55, 55, 65),
	On = Color3.fromRGB(90, 120, 255),
}

--==================================================
-- HELPERS
--==================================================

local function create(className, properties, parent)
	local object = Instance.new(className)

	for property, value in pairs(properties) do
		object[property] = value
	end

	object.Parent = parent
	return object
end

local function addCorner(object, radius)
	return create("UICorner", {
		CornerRadius = UDim.new(0, radius)
	}, object)
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = create("ScreenGui", {
	Name = "MiniExploitPanel",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, PlayerGui)

--==================================================
-- PANEL
--==================================================

local Panel = create("Frame", {
	Name = "Panel",
	Size = PANEL_SIZE,
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = COLORS.Background,
	BorderSizePixel = 0,
}, ScreenGui)

addCorner(Panel, 12)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = create("Frame", {
	Name = "Sidebar",
	Size = UDim2.new(0, 145, 1, 0),
	BackgroundColor3 = COLORS.Sidebar,
	BorderSizePixel = 0,
}, Panel)

addCorner(Sidebar, 12)

create("Frame", {
	Size = UDim2.new(0, 12, 1, 0),
	Position = UDim2.new(1, -12, 0, 0),
	BackgroundColor3 = COLORS.Sidebar,
	BorderSizePixel = 0,
}, Sidebar)

create("TextLabel", {
	Name = "Title",
	Size = UDim2.new(1, -30, 0, 45),
	Position = UDim2.fromOffset(15, 15),
	BackgroundTransparency = 1,
	Text = "Mini Panel",
	TextColor3 = COLORS.White,
	Font = Enum.Font.GothamBold,
	TextSize = 20,
	TextXAlignment = Enum.TextXAlignment.Left,
}, Sidebar)

--==================================================
-- TABS
--==================================================

local TabContainer = create("Frame", {
	Name = "Tabs",
	Size = UDim2.new(1, -20, 0, 180),
	Position = UDim2.fromOffset(10, 75),
	BackgroundTransparency = 1,
}, Sidebar)

create("UIListLayout", {
	FillDirection = Enum.FillDirection.Vertical,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	Padding = UDim.new(0, 8),
}, TabContainer)

--==================================================
-- CONTENT
--==================================================

local Content = create("Frame", {
	Name = "Content",
	Size = UDim2.new(1, -145, 1, 0),
	Position = UDim2.new(0, 145, 0, 0),
	BackgroundColor3 = COLORS.Content,
	BorderSizePixel = 0,
}, Panel)

addCorner(Content, 12)

--==================================================
-- PAGES
--==================================================

local Pages = {}

local function createPage(name)

	local Page = create("Frame", {
		Name = name,
		Size = UDim2.new(1, -40, 1, -40),
		Position = UDim2.fromOffset(20, 20),
		BackgroundTransparency = 1,
		Visible = false,
	}, Content)

	Pages[name] = Page

	return Page
end

--==================================================
-- MAIN PAGE
--==================================================

local MainPage = createPage("MainPage")

create("TextLabel", {
	Name = "PageTitle",
	Size = UDim2.new(1, 0, 0, 35),
	BackgroundTransparency = 1,
	Text = "Main",
	TextColor3 = COLORS.White,
	Font = Enum.Font.GothamBold,
	TextSize = 24,
	TextXAlignment = Enum.TextXAlignment.Left,
}, MainPage)

--==================================================
-- FLY CARD
--==================================================

local FlyCard = create("Frame", {
	Name = "Fly",
	Size = UDim2.new(1, 0, 0, 150),
	Position = UDim2.fromOffset(0, 50),
	BackgroundColor3 = Color3.fromRGB(29, 29, 37),
	BorderSizePixel = 0,
}, MainPage)

addCorner(FlyCard, 10)

create("TextLabel", {
	Name = "FlyTitle",
	Size = UDim2.new(1, -30, 0, 30),
	Position = UDim2.fromOffset(15, 12),
	BackgroundTransparency = 1,
	Text = "Fly",
	TextColor3 = COLORS.White,
	Font = Enum.Font.GothamSemibold,
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
}, FlyCard)

--==================================================
-- FLY ENABLE
--==================================================

create("TextLabel", {
	Name = "EnableLabel",
	Size = UDim2.fromOffset(100, 30),
	Position = UDim2.fromOffset(15, 55),
	BackgroundTransparency = 1,
	Text = "Enable",
	TextColor3 = COLORS.Gray,
	Font = Enum.Font.Gotham,
	TextSize = 15,
	TextXAlignment = Enum.TextXAlignment.Left,
}, FlyCard)

local Toggle = create("TextButton", {
	Name = "EnableToggle",
	Size = UDim2.fromOffset(55, 28),
	Position = UDim2.new(1, -75, 0, 55),
	BackgroundColor3 = COLORS.Off,
	BorderSizePixel = 0,
	Text = "",
	AutoButtonColor = false,
}, FlyCard)

addCorner(Toggle, 14)

local ToggleCircle = create("Frame", {
	Name = "Circle",
	Size = UDim2.fromOffset(22, 22),
	Position = UDim2.fromOffset(3, 3),
	BackgroundColor3 = COLORS.White,
	BorderSizePixel = 0,
}, Toggle)

addCorner(ToggleCircle, 50)

--==================================================
-- SPEED
--==================================================

create("TextLabel", {
	Name = "SpeedLabel",
	Size = UDim2.fromOffset(100, 30),
	Position = UDim2.fromOffset(15, 98),
	BackgroundTransparency = 1,
	Text = "Speed",
	TextColor3 = COLORS.Gray,
	Font = Enum.Font.Gotham,
	TextSize = 15,
	TextXAlignment = Enum.TextXAlignment.Left,
}, FlyCard)

local SpeedBox = create("TextBox", {
	Name = "SpeedInput",
	Size = UDim2.fromOffset(100, 30),
	Position = UDim2.new(1, -120, 0, 98),
	BackgroundColor3 = Color3.fromRGB(42, 42, 52),
	BorderSizePixel = 0,
	Text = "50",
	PlaceholderText = "Speed",
	TextColor3 = COLORS.White,
	PlaceholderColor3 = COLORS.Gray,
	Font = Enum.Font.Gotham,
	TextSize = 14,
	ClearTextOnFocus = false,
	TextXAlignment = Enum.TextXAlignment.Center,
}, FlyCard)

addCorner(SpeedBox, 7)

--==================================================
-- FLY SYSTEM
--==================================================

local FlyEnabled = false
local FlySpeed = 50

local FlyConnection = nil
local FlyVelocity = nil
local FlyOrientation = nil
local FlyAttachment = nil

local function getCharacter()

	local Character = Player.Character

	if not Character then
		return nil
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local Root = Character:FindFirstChild("HumanoidRootPart")

	if not Humanoid or not Root then
		return nil
	end

	return Character, Humanoid, Root
end

--==================================================
-- START FLY
--==================================================

local function startFly()

	local Character, Humanoid, Root = getCharacter()

	if not Character then
		return
	end

	-- Evita criar duas vezes
	if FlyConnection then
		return
	end

	-- Attachment
	FlyAttachment = Instance.new("Attachment")
	FlyAttachment.Name = "FlyAttachment"
	FlyAttachment.Parent = Root

	-- Velocidade
	FlyVelocity = Instance.new("LinearVelocity")
	FlyVelocity.Name = "FlyVelocity"

	FlyVelocity.Attachment0 = FlyAttachment
	FlyVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
	FlyVelocity.MaxForce = math.huge
	FlyVelocity.VectorVelocity = Vector3.zero

	FlyVelocity.Parent = Root

	-- Rotação
	FlyOrientation = Instance.new("AlignOrientation")
	FlyOrientation.Name = "FlyOrientation"

	FlyOrientation.Attachment0 = FlyAttachment
	FlyOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	FlyOrientation.MaxTorque = math.huge
	FlyOrientation.Responsiveness = 15

	FlyOrientation.Parent = Root

	Humanoid.AutoRotate = false

	-- Loop do Fly
	FlyConnection = RunService.RenderStepped:Connect(function()

		if not FlyEnabled then
			return
		end

		if not Character.Parent then
			return
		end

		local Camera = workspace.CurrentCamera

		if not Camera then
			return
		end

		--==========================================
		-- INPUT
		--==========================================

		local MoveDirection = Vector3.zero

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			MoveDirection += Camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			MoveDirection -= Camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			MoveDirection += Camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			MoveDirection -= Camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			MoveDirection += Vector3.yAxis
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			MoveDirection -= Vector3.yAxis
		end

		-- Normaliza para não ficar mais rápido na diagonal
		if MoveDirection.Magnitude > 0 then
			MoveDirection = MoveDirection.Unit
		end

		--==========================================
		-- VELOCIDADE
		--==========================================

		FlyVelocity.VectorVelocity = MoveDirection * FlySpeed

		--==========================================
		-- ROTAÇÃO
		--==========================================

		local LookVector = Camera.CFrame.LookVector

		FlyOrientation.CFrame = CFrame.lookAt(
			Vector3.zero,
			Vector3.new(
				LookVector.X,
				0,
				LookVector.Z
			)
		)

	end)
end

--==================================================
-- STOP FLY
--==================================================

local function stopFly()

	if FlyConnection then
		FlyConnection:Disconnect()
		FlyConnection = nil
	end

	if FlyVelocity then
		FlyVelocity:Destroy()
		FlyVelocity = nil
	end

	if FlyOrientation then
		FlyOrientation:Destroy()
		FlyOrientation = nil
	end

	if FlyAttachment then
		FlyAttachment:Destroy()
		FlyAttachment = nil
	end

	local Character, Humanoid = getCharacter()

	if Humanoid then
		Humanoid.AutoRotate = true
	end
end

--==================================================
-- TOGGLE VISUAL
--==================================================

local function updateToggle()

	local targetPosition
	local targetColor

	if FlyEnabled then

		targetPosition = UDim2.new(1, -25, 0, 3)
		targetColor = COLORS.On

	else

		targetPosition = UDim2.fromOffset(3, 3)
		targetColor = COLORS.Off

	end

	TweenService:Create(
		ToggleCircle,
		TweenInfo.new(0.15, Enum.EasingStyle.Quad),
		{Position = targetPosition}
	):Play()

	TweenService:Create(
		Toggle,
		TweenInfo.new(0.15, Enum.EasingStyle.Quad),
		{BackgroundColor3 = targetColor}
	):Play()
end

--==================================================
-- TOGGLE EVENT
--==================================================

Toggle.MouseButton1Click:Connect(function()

	FlyEnabled = not FlyEnabled

	updateToggle()

	if FlyEnabled then
		startFly()
	else
		stopFly()
	end

end)

--==================================================
-- SPEED EVENT
--==================================================

SpeedBox.FocusLost:Connect(function()

	local Number = tonumber(SpeedBox.Text)

	if Number then

		FlySpeed = math.clamp(Number, 1, 500)

		SpeedBox.Text = tostring(FlySpeed)

	else

		SpeedBox.Text = tostring(FlySpeed)

	end

end)

--==================================================
-- CHARACTER RESPAWN
--==================================================

Player.CharacterAdded:Connect(function()

	-- Limpa o Fly antigo
	stopFly()

	-- Se estava ativado, liga novamente
	if FlyEnabled then
		task.wait(1)
		startFly()
	end

end)

--==================================================
-- PLAYER PAGE
--==================================================

local PlayerPage = createPage("PlayerPage")

create("TextLabel", {
	Name = "PageTitle",
	Size = UDim2.new(1, 0, 0, 35),
	BackgroundTransparency = 1,
	Text = "Player",
	TextColor3 = COLORS.White,
	Font = Enum.Font.GothamBold,
	TextSize = 24,
	TextXAlignment = Enum.TextXAlignment.Left,
}, PlayerPage)

create("TextLabel", {
	Name = "ComingSoon",
	Size = UDim2.new(1, 0, 0, 30),
	Position = UDim2.fromOffset(0, 50),
	BackgroundTransparency = 1,
	Text = "Player features coming soon...",
	TextColor3 = COLORS.Gray,
	Font = Enum.Font.Gotham,
	TextSize = 15,
	TextXAlignment = Enum.TextXAlignment.Left,
}, PlayerPage)

--==================================================
-- FUN PAGE
--==================================================

local FunPage = createPage("FunPage")

create("TextLabel", {
	Name = "PageTitle",
	Size = UDim2.new(1, 0, 0, 35),
	BackgroundTransparency = 1,
	Text = "Fun",
	TextColor3 = COLORS.White,
	Font = Enum.Font.GothamBold,
	TextSize = 24,
	TextXAlignment = Enum.TextXAlignment.Left,
}, FunPage)

create("TextLabel", {
	Name = "ComingSoon",
	Size = UDim2.new(1, 0, 0, 30),
	Position = UDim2.fromOffset(0, 50),
	BackgroundTransparency = 1,
	Text = "Fun features coming soon...",
	TextColor3 = COLORS.Gray,
	Font = Enum.Font.Gotham,
	TextSize = 15,
	TextXAlignment = Enum.TextXAlignment.Left,
}, FunPage)

--==================================================
-- TABS
--==================================================

local CurrentPage = nil

local function createTab(Text, Page)

	local Button = create("TextButton", {
		Name = Text .. "Button",
		Size = UDim2.new(1, 0, 0, 42),
		BackgroundColor3 = COLORS.Sidebar,
		BorderSizePixel = 0,
		Text = Text,
		TextColor3 = COLORS.Gray,
		Font = Enum.Font.GothamSemibold,
		TextSize = 15,
		AutoButtonColor = false,
	}, TabContainer)

	addCorner(Button, 7)

	Button.MouseEnter:Connect(function()

		if CurrentPage ~= Page then
			Button.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
		end

	end)

	Button.MouseLeave:Connect(function()

		if CurrentPage ~= Page then
			Button.BackgroundColor3 = COLORS.Sidebar
		end

	end)

	Button.MouseButton1Click:Connect(function()

		for _, OtherPage in pairs(Pages) do
			OtherPage.Visible = false
		end

		for _, OtherButton in ipairs(TabContainer:GetChildren()) do

			if OtherButton:IsA("TextButton") then
				OtherButton.BackgroundColor3 = COLORS.Sidebar
				OtherButton.TextColor3 = COLORS.Gray
			end

		end

		Page.Visible = true

		Button.BackgroundColor3 = COLORS.Accent
		Button.TextColor3 = COLORS.White

		CurrentPage = Page

	end)

	return Button
end

local MainButton = createTab("Main", MainPage)
createTab("Player", PlayerPage)
createTab("Fun", FunPage)

MainPage.Visible = true
MainButton.BackgroundColor3 = COLORS.Accent
MainButton.TextColor3 = COLORS.White
CurrentPage = MainPage

--==================================================
-- DRAG
--==================================================

local Dragging = false
local DragStart
local StartPosition

Panel.InputBegan:Connect(function(Input)

	if Input.UserInputType == Enum.UserInputType.MouseButton1 then

		Dragging = true
		DragStart = Input.Position
		StartPosition = Panel.Position

		Input.Changed:Connect(function()

			if Input.UserInputState == Enum.UserInputState.End then
				Dragging = false
			end

		end)

	end

end)

UserInputService.InputChanged:Connect(function(Input)

	if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then

		local Delta = Input.Position - DragStart

		Panel.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,

			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)

	end

end)

--==================================================
-- OPEN ANIMATION
--==================================================

Panel.Size = UDim2.fromOffset(0, 0)

TweenService:Create(
	Panel,
	TweenInfo.new(
		0.3,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	),
	{
		Size = PANEL_SIZE
	}
):Play()

print("Mini Panel + Fly carregados!")
