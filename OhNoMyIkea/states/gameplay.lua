
-- OBJECTS
GameplayGroup = display.newGroup()
GameplayGroup.isVisible = false

placeWallInstructions = display.newText({
	parent = GameplayGroup,
	text = "Place a wall to protect your furniture.\nPress R to rotate wall.",
	x = Width / 2,
	y = Height - 85,
	width = Width,
	height = 50,
	font = "Arial",
	fontSize = 26,
	align = "center"
})
placeWallInstructionsShadow = display.newText({
	parent = GameplayGroup,
	text = placeWallInstructions.text,
	x = placeWallInstructions.x + 1,
	y = placeWallInstructions.y + 1,
	width = placeWallInstructions.width,
	height = placeWallInstructions.height,
	font = "Arial",
	fontSize = 26,
	align = "center"
})
placeWallInstructionsShadow:setFillColor(0)
placeWallInstructions:toFront()

roundDisplay = display.newText({
	parent = GameplayGroup,
	text = "Round 1",
	x = Width / 2,
	y = 22,
	width = Width,
	height = 28,
	font = "Arial",
	fontSize = 20,
	align = "center"
})

HoverWallDisplay = display.newLine(MousePosition.x - tileSize, MousePosition.y + tileSize / 2, MousePosition.x + 5, MousePosition.y + tileSize / 2)
HoverWallDisplay.strokeWidth = 4
GameplayGroup:insert(HoverWallDisplay)
HoverWallDisplay:toFront()

-- Start fire
function StartFire()
	local newX = math.random(1, gridSize)
	local newY = math.random(1, gridSize)
	local thisTile = GetTileAt(newX, newY)
	if thisTile.furniture ~= "" or thisTile.onFire then
		StartFire()
		return
	end
	thisTile.onFire = true
	thisTile.Fire.isVisible = true
end

-- Spread fire
function SpreadFire()
	local catchFireTo = {}
	for i, tile in ipairs(Tiles) do
		if tile.onFire then
			if tile.x > 1 then
				if not GetTileAt(tile.x - 1, tile.y).onFire then
					wallInBetween = false
					for j, wall in ipairs(Walls) do
						if wall.direction == "vertical" then
							if math.floor(wall.x) == tile.x - 1 and math.floor(wall.y) == tile.y then
								wallInBetween = true
							end
						end
					end
					if not wallInBetween then
						table.insert(catchFireTo, GetTileAt(tile.x - 1, tile.y))
					end
				end
			end
			if tile.x < gridSize then
				if not GetTileAt(tile.x + 1, tile.y).onFire then
					wallInBetween = false
					for j, wall in ipairs(Walls) do
						if wall.direction == "vertical" then
							if math.floor(wall.x) == tile.x and math.floor(wall.y) == tile.y then
								wallInBetween = true
							end
						end
					end
					if not wallInBetween then
						table.insert(catchFireTo, GetTileAt(tile.x + 1, tile.y))
					end
				end
			end
			if tile.y < gridSize then
				if not GetTileAt(tile.x, tile.y + 1).onFire then
					wallInBetween = false
					for j, wall in ipairs(Walls) do
						if wall.direction == "horizontal" then
							if math.floor(wall.x) == tile.x and math.floor(wall.y) == tile.y then
								wallInBetween = true
							end
						end
					end
					if not wallInBetween then
						table.insert(catchFireTo, GetTileAt(tile.x, tile.y + 1))
					end
				end
			end
			if tile.y > 1 then
				if not GetTileAt(tile.x, tile.y - 1).onFire then
					wallInBetween = false
					for j, wall in ipairs(Walls) do
						if wall.direction == "horizontal" then
							if math.floor(wall.x) == tile.x and math.floor(wall.y) == tile.y - 1 then
								wallInBetween = true
							end
						end
					end
					if not wallInBetween then
						table.insert(catchFireTo, GetTileAt(tile.x, tile.y - 1))
					end
				end
			end
		end
	end
	for i, tile in ipairs(catchFireTo) do
		if not tile.onFire then
			tile.onFire = true
			tile.Fire.isVisible = true
			tile.Fire:toFront()
			if tile.furniture ~= "" then
				print("Player " .. tostring(tile.furniturePlayer) .. "'s " .. tile.furniture .. " burst into flames!")
				PlayerEliminated[tile.furniturePlayer] = true
			end
		end
	end
end
