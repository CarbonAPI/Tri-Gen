local m = {}

--VARIABLES
local assetPrefix = "http://www.roblox.com/asset/?id="

--FUNCTIONS
function UDim2ToVec(p1, p2)
	return (Vector3.new(p1.X.Offset - p2.X.Offset, p1.Y.Offset - p2.Y.Offset, 0))
end

function dot(a, b)
    return a.x * b.x + a.y * b.y + a.z * b.z
end

--MODULE FUNCTIONS
function m.triGen(left, right, plr)
	
	--[[clean]]--
	if plr.PlayerGui:FindFirstChild("TriGen") == nil then
		sGui = Instance.new("ScreenGui", plr.PlayerGui)
		sGui.Name = "TriGen"
	else
		sGui = plr.PlayerGui.TriGen
	end
	
	--[[Give Positions]]--
	local one = sGui[tostring(1)].Position
	local two = sGui[tostring(2)].Position
	local three = sGui[tostring(3)].Position
	
	--[[solve the triangle]]--
	--Find the longest side & top of triangle
	if UDim2ToVec(one, two).magnitude > UDim2ToVec(one, three).magnitude then
		if UDim2ToVec(three, one).magnitude > UDim2ToVec(one, two).magnitude then
			longestSide = UDim2ToVec(three, one)
			top = two
		else
			longestSide = UDim2ToVec(one, two)
			top = three
		end
	else
		if UDim2ToVec(two, three).magnitude > UDim2ToVec(one, three).magnitude then
			longestSide = UDim2ToVec(two, three)
			top = one
		else
			longestSide = UDim2ToVec(one, three)
			top = two
		end
	end
	
	--find which point of the long side is closest to top	
	if longestSide.magnitude == UDim2ToVec(one, two).magnitude then
		if UDim2ToVec(one, top).magnitude > UDim2ToVec(two, top).magnitude then
			nearestPoint = one
		else
			nearestPoint = two
		end
	elseif longestSide.magnitude == UDim2ToVec(two, three).magnitude then
		if UDim2ToVec(two, top).magnitude > UDim2ToVec(three, top).magnitude then
			nearestPoint = two
		else
			nearestPoint = three
		end
	elseif longestSide.magnitude == UDim2ToVec(three, one).magnitude then
		if UDim2ToVec(three, top).magnitude > UDim2ToVec(one, top).magnitude then
			nearestPoint = three
		else
			nearestPoint = one
		end
	end
	
	--find the first hypotenuse
	firstHypot = UDim2ToVec(nearestPoint, top)

	--find the first width
	firstWidth = dot(firstHypot, longestSide) / longestSide.magnitude
	
	--find height
	height = math.sqrt(firstHypot.magnitude ^ 2 - firstWidth ^ 2)
	
	--find second width
	secondWidth = longestSide.magnitude - firstWidth
	
	--find the second hypotenuse
	secondHypot = math.sqrt(secondWidth ^ 2 + height ^ 2)
	
	--[[create triangles]]--
	--check if on left or right
	
	local triF, triL = (Instance.new("ImageLabel", sGui)), (Instance.new("ImageLabel", sGui))
	triF.Size = UDim2.new(0, firstWidth, 0, height)
	triF.Image = assetPrefix .. left
	triF.BackgroundTransparency = 1
	triF.Name = "first"	
	
	triL.Name = "second"
	triL.Size = UDim2.new(0, secondWidth, 0, height)
	triL.Image = assetPrefix .. right
	triL.BackgroundTransparency = 1
	
end



return m
