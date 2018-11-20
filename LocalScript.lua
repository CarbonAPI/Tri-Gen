local mouse = game:GetService("Players").LocalPlayer:GetMouse();
local sg = script.Parent:WaitForChild("ScreenGui");
local NODE_SIZE = 6;
local ORIG_SIZE = 800;
local poses = {};


mouse.Button1Down:connect(function(a)
	if #poses == 3 then
		poses = {};
	end
	
	table.insert(poses, Vector2.new(mouse.X, mouse.Y));
	
	local square = Instance.new("TextLabel", sg);
	square.Text = "";
	square.Size = UDim2.new(0, NODE_SIZE, 0, NODE_SIZE);
	square.Position = UDim2.new(0, mouse.X - NODE_SIZE / 2, 0, mouse.Y - NODE_SIZE / 2);
	square.BorderSizePixel = 3;
	square.BorderColor3 = Color3.fromRGB(106, 183, 130);
	square.BackgroundColor3 = Color3.fromRGB(99, 249, 147);
	
	if #poses == 3 then draw(); end
end)


function getVectorProjection(projOn, other)
	local num = other:Dot(projOn);
	local denom = math.pow(projOn.Magnitude, 2);
	return num / denom * projOn;
end


function draw()
	-- create triangles
	local lt = Instance.new("ImageLabel");
	lt.Image = "rbxassetid://319692151";
	lt.BackgroundTransparency = 1;
	lt.BorderSizePixel = 0;
	local rt = lt:Clone();
	rt.Parent = sg;
	rt.Image = "rbxassetid://319692171";
	
	-- find which is left, right, and middle node	
	-- find longest edge, endpoints of which are the left and right node.
	local endpoints = {poses[1], poses[2]};
	for _, p1 in pairs(poses) do
		for _, p2 in pairs(poses) do
			local epDist = (endpoints[1] - endpoints[2]).Magnitude;
			local cDist = (p1 - p2).Magnitude;
			if cDist > epDist then
				endpoints = {p1, p2};
			end
		end
	end
	local left = endpoints[1].X < endpoints[2].X and endpoints[1] or endpoints[2];
	local right = endpoints[1].X < endpoints[2].X and endpoints[2] or endpoints[1];
	local middle = nil;
	for _, v in pairs(poses) do if v ~= left and v ~= right then middle = v; end end
	
	-- get vector projection point
	local proj = left - getVectorProjection(left - right, left - middle);
	
	-- draw left triangle
	local lframe = Instance.new("Frame", sg);
	lframe.Size = UDim2.new(0, 1, 0, 1);
	lframe.Position = UDim2.new(0, left.X, 0, left.Y);
	lframe.BackgroundTransparency = 1;
	lt.Parent = lframe;
	lt.Size = UDim2.new(0, (left - proj).Magnitude, 0, -(middle - proj).Magnitude);
	lframe.Rotation = math.deg(math.atan((proj - left).Y / (proj - left).X));
	
	-- draw right triangle
	local rframe = Instance.new("Frame", sg);
	rframe.Size = UDim2.new(0, 1, 0, 1);
	rframe.Position = UDim2.new(0, right.X, 0, right.Y);
	rframe.BackgroundTransparency = 1;
	rt.Parent = rframe;
	rt.Size = UDim2.new(0, -(right - proj).Magnitude, 0, -(middle - proj).Magnitude);
	rframe.Rotation = math.deg(math.atan((proj - right).Y / (proj - right).X));
	
	-- flip triangles if upside-down
	if middle.Y > proj.Y then
		lt.ImageRectSize = Vector2.new(ORIG_SIZE, -ORIG_SIZE);
		lt.ImageRectOffset = Vector2.new(0, ORIG_SIZE);
		lt.Size = UDim2.new(0, lt.Size.X.Offset, 0, -lt.Size.Y.Offset);
		
		rt.ImageRectSize = lt.ImageRectSize;
		rt.ImageRectOffset = lt.ImageRectOffset;
		rt.Size = UDim2.new(0, rt.Size.X.Offset, 0, -rt.Size.Y.Offset);
	end
end