-------VARIABLES----------------------------------------------------
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local m = require(script:WaitForChild("ModuleScript"))
local clickCount = 1
local lTri = 319692151
local rTri = 319692171

-------FUNCTIONS----------------------------------------------------
function createPos(mPosX, mPosY, iter)
	if plr.PlayerGui:FindFirstChild("TriGen") == nil then
		sGui = Instance.new("ScreenGui", plr.PlayerGui)
		sGui.Name = "TriGen"
	end
	
	if sGui:FindFirstChild("first") ~= nil then
		sGui[1]:Destroy()
		sGui[2]:Destroy()
		sGui[3]:Destroy()
		sGui.first:Destroy()
		sGui.second:Destroy()
	end
	
	local k = Instance.new("ImageLabel", sGui)
	k.Size = UDim2.new(0, 5, 0, 5)
	k.Position = UDim2.new(0, mPosX, 0, mPosY)
	k.Name = tostring(iter)
end

-------EVENTS-------------------------------------------------------
mouse.Button1Down:connect(function()
	
	
	--make positions
	if clickCount == 1 then
		createPos(mouse.X, mouse.Y, clickCount)
		clickCount = clickCount + 1
	elseif clickCount == 2 then
		createPos(mouse.X, mouse.Y, clickCount)
		clickCount = clickCount + 1
	elseif clickCount == 3 then
		createPos(mouse.X, mouse.Y, clickCount)
		m.triGen(lTri, rTri, plr)
		clickCount = 1
	end
	
		
	
end)