local lib = {}

local themes = {
    ['default'] = {
        ['dark'] = Color3.fromRGB(25,25,25),
        ['base'] = Color3.fromRGB(35,35,35),
        ['med'] = Color3.fromRGB(45,45,45),
        ['light'] = Color3.fromRGB(75,75,75),
    },
}
local HttpService = game:GetService('HttpService')

lib.libVersion = '1.00.3'

local TweenService = game:GetService('TweenService')
local UIS = game:GetService('UserInputService')

local dragging = false

local function makeDraggable(obj, objToMove)

	objToMove = objToMove or obj

	local dragger = obj
	local dragging = false
	local dragStart, startPos

	-- Function to update the object's position
	local function updateInput(input)
		local offset = input.Position - dragStart
		local newPosition = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + offset.X,
			startPos.Y.Scale,
			startPos.Y.Offset + offset.Y
		)
		TweenService:Create(objToMove, TweenInfo.new(0.25), {Position = newPosition}):Play()
	end

	-- InputBegan event for starting drag
	dragger.InputBegan:Connect(function(input)
		if current_drag == nil and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) 
			and not UIS:GetFocusedTextBox() then
			dragging = true
			dragStart = input.Position
			startPos = objToMove.Position
			current_drag = dragger

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					current_drag = nil
				end
			end)
		end
	end)

	-- InputChanged event to track dragging
	dragger.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	-- Global InputChanged event for updating position
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			updateInput(input)
		end
	end)
end

function lib.new(theme)
    theme = themes[theme or ''] or themes['default']

    local g = Instance.new('ScreenGui')
    g.Name = HttpService:GenerateGUID(false)
    g.Parent = game:GetService('CoreGui')

    local f = Instance.new('Frame')
    f.Size = UDim2.new(0,500,0,300)
    f.Position = UDim2.new(.25,0,.25,0)
    f.BackgroundColor3 = theme.base
    
    local uic = Instance.new('UICorner')
    uic.Parent = f

    local sels = Instance.new('Frame')
    sels.Size = UDim2.new(0,90,0,280)
    sels.AnchorPoint = Vector2.new(1,0)
    sels.Position = UDim2.new(1,-10,0,10)
    sels.BackgroundColor3 = theme.light
    sels.Name = 'Selections'

    local uic = Instance.new('UICorner')
    uic.Parent = sels

    local container = Instance.new('Frame')
    container.Size = UDim2.new(0,330,0,280)
    container.Position = UDim2.new(0,10,0,10)
    container.BackgroundColor3 = theme.med
    container.Name = 'Container'

    local containerScrl = Instance.new('ScrollingFrame')
    containerScrl.Size = UDim2.new(1,-10,1,-10)
    containerScrl.Position = UDim2.new(0,5,0,5)
    containerScrl.BackgroundTransparency = 1
    containerScrl.Name = 'containerScrl'
    containerScrl.ScrollBarThickness = 5
    containerScrl.CanvasSize = UDim2.new(0,0,0,0)
    containerScrl.AutomaticCanvasSize = Enum.AutomaticCanvasSize.Y

    local uic = Instance.new('UICorner')
    uic.Parent = container

    local top = Instance.new('Frame')
    top.Size = UDim2.new(1,0,0,25)
    top.AnchorPoint = Vector2.new(0,1)
    top.Position = UDim2.new(0,0,0,0)
    top.BackgroundColor3 = theme.dark
    top.Name = 'Top'

    local title = Instance.new('TextLabel')
    title.Size = UDim2.new(1,-10,1,0)
    title.Position = UDim2.new(0,10,0,0)
    title.AnchorPoint = Vector2.new(0,1)
    title.Text = 'Project UNKNOWN - v'..lib.libVersion
    title.BackgroundTransparency = 1
    title.TextTransparency = 0
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.FontFace.Bold = true
    title.TextXAlignment = Enum.TextXAlignment.Left

    local uic = Instance.new('UIStroke')
    uic.Parent = title
    
    top.Parent = f
    title.Parent = top
    container.Parent = f
    containerScrl.Parent = container
    sels.Parent = f
    f.Parent = g

    makeDraggable(f)

    return f
end

function lib.newSection(library, conf)
    if typeof(conf) == 'table' then
        local name = conf.name or 'No name.'

    end
end

function lib.newButton(section, conf, callback)
    if typeof(conf) == 'table' then
        local callback = callback or function() end
        local title = conf.title or 'No title.'

    end
end

return lib
