
-- Attributes
Walls = {}

-- Place a wall
function PlaceWall(x, y, direction)
	local placed = PlaceNewWall(WallKinds[WallKindIndex], x, y, direction)
	if placed then audio.play(Sounds["Place Wall"]) end
	return placed

	--[[
	-- Place wall with position locked in-between grid
	local newX
	local newY
	for i, wall in ipairs(Walls) do
		if x == math.floor(wall.x) and y == math.floor(wall.y) and rightOrBottomString == wall.direction then
			return false
		end
	end
	if rightOrBottomString == "vertical" then
		newX = x + 0.5
		newY = y
	else
		newX = x
		newY = y + 0.5
	end

	local newWall = Wall:new(newX, newY, rightOrBottomString)

	-- Create wall
	table.insert(Walls, newWall)

	-- Check if this wall blocks off the fire and the furniture
	local accessible = CheckWallsForBlockage()
	if not accessible then
		print("Can't place furniture here - No completely blocking off furniture from the fire")
		newWall.Object:removeSelf()
		table.remove(Walls)
		native.showAlert("Can't do that!", "You can't completely block off the fire", {"Ok"})
		return false
	end

	-- Play sound effect
	audio.play(Sounds["Place Wall"])

	-- Successfully placed wall
	return true
	]]
end

-- Wall class
Wall = {}
Wall.__index = Wall
function Wall.new(mt, x, y, dir)
	local self = setmetatable({}, Wall)

	if dir == nil then dir = "horizontal" end

	-- Attributes
	self.x = x
	self.y = y
	self.direction = dir

	-- Main Object
	self.Object = display.newGroup()
	self.Object.x = x * tileSize
	self.Object.y = (y + 0.5) * tileSize
	local top = display.newLine(self.Object, 0, 0, tileSize, 0)
	top.strokeWidth = 3
	local shadow = display.newLine(self.Object, 0, 0, tileSize, 0)
	shadow.strokeWidth = 5
	shadow:setStrokeColor(0)
	top:toFront()
	if dir == "vertical" then
		self.Object.rotation = 90
		self.Object.x = self.Object.x + tileSize / 2
		self.Object.y = self.Object.y - tileSize / 2
	end

	return self
end
