local S={
    P=game:GetService("Players"),
    TS=game:GetService("TweenService"),
    UIS=game:GetService("UserInputService"),
    RS=game:GetService("RunService")
}

local Player=S.P.LocalPlayer
local Gui=Player:WaitForChild("PlayerGui")

local C={
    Bg=Color3.fromRGB(22,22,28),
    Side=Color3.fromRGB(27,27,34),
    White=Color3.fromRGB(235,235,240),
    Gray=Color3.fromRGB(145,145,155),
    Accent=Color3.fromRGB(90,120,255),
    Off=Color3.fromRGB(55,55,65)
}

local function new(class,props,parent)
    local x=Instance.new(class)
    for k,v in pairs(props) do x[k]=v end
    x.Parent=parent
    return x
end

local function corner(x,r)
    new("UICorner",{CornerRadius=UDim.new(0,r)},x)
end
