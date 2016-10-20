
-- Attributes
Walls = {}

-- Place a wall
function PlaceWall(x, y, rightOrBottomString)
	-- Place wall with position locked in-between grid
	local newX
	local newY
	if rightOrBottomString == "vertical" then
		for i, wall in ipairs(Walls) do
			if x == math.floor(wall.x) and y == math.floor(wall.y) and rightOrBottomString == wall.direction then
				return false
			end
		end
		newX = x + 0.5
		newY = y
	else
		for i, wall in ipairs(Walls) do
			if x == math.floor(wall.x) and y == math.floor(wall.y) and rightOrBottomString == wall.direction then
				return false
			end
		end
		newX = x
		newY = y + 0.5
	end

	local newWall = Wall:new(newX, newY, rightOrBottomString)
	local isBlockedOff = false
	for i, tile in ipairs(tiles) do
		if tile.furniturePlayer == 1 then
			BlockCheck(tile.x, tile.y)
		end
	end
	if isBlockedOff then
		print("blocked off!")
		newWall.Object:removeSelf()
		return false
	end

	-- Create wall
	table.insert(Walls, newWall)

	-- Play sound effect
	audio.play(Sounds["Place Wall"])

	-- Successfully placed wall
	return true
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
	self.Object = display.newLine(x * tileSize, (y + 0.5) * tileSize, (x + 1) * tileSize, (y + 0.5) * tileSize)
	if dir == "vertical" then
		self.Object.rotation = 90
		self.Object.x = self.Object.x + tileSize / 2
		self.Object.y = self.Object.y - tileSize / 2
	end
	self.Object.strokeWidth = 3

	return self
end
