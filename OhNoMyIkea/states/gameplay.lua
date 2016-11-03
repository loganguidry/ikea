
-- OBJECTS
GameplayGroup = display.newGroup()
GameplayGroup.isVisible = false
GameplayGroup:toFront()

enabledButtonsGroup = {}
disabledButtonsGroup = {}
local wallBtn_single_buttonDisabled
local wallBtn_double_buttonDisabled
local wallBtn_corner_buttonDisabled
local wallBtn_lshape_buttonDisabled
local wallBtn_lshapereverse_buttonDisabled
local wallBtn_ushape_buttonDisabled
local wallBtn_zigzag_buttonDisabled
local wallBtn_zigzagreverse_buttonDisabled
function disableWallButtons()
	wallBtn_double_buttonDisabled.isVisible = PlayerPlacedWall[CurrentPlayer]["double"]
	wallBtn_corner_buttonDisabled.isVisible = PlayerPlacedWall[CurrentPlayer]["corner"]
	wallBtn_lshape_buttonDisabled.isVisible = PlayerPlacedWall[CurrentPlayer]["l-shape"]
	wallBtn_lshapereverse_buttonDisabled.isVisible =  PlayerPlacedWall[CurrentPlayer]["l-shape reverse"]
	wallBtn_ushape_buttonDisabled.isVisible =  PlayerPlacedWall[CurrentPlayer]["u-shape"]
	wallBtn_zigzag_buttonDisabled.isVisible = PlayerPlacedWall[CurrentPlayer]["zigzag"]
	wallBtn_zigzagreverse_buttonDisabled.isVisible = PlayerPlacedWall[CurrentPlayer]["zigzag reverse"]
end

placeWallInstructions = display.newText({
	parent = GameplayGroup,
	text = "Place a wall to protect your furniture.\nPress R to rotate wall.",
	x = Width / 2,
	y = Height - 30,
	width = Width,
	height = 50,
	font = "Arial",
	fontSize = 18,
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
	fontSize = 18,
	align = "center"
})
placeWallInstructionsShadow:setFillColor(0)
placeWallInstructions:toFront()

roundDisplayGroup = display.newGroup()
GameplayGroup:insert(roundDisplayGroup)
roundDisplayBackground = display.newRect(roundDisplayGroup, Width / 2, 25, Width - 100, 10)
roundDisplayBackground:setFillColor(0.5, 0, 0, 0.5)
roundDisplay = display.newRect(roundDisplayGroup, 50, 25, (Width - 100) / 15.0, 10)
roundDisplay.anchorX = 0
roundDisplay:setFillColor(0, 1, 0)
roundDisplayFiretruck = display.newImageRect(roundDisplayGroup, "images/firetruck.png", 40, 20)
roundDisplayFiretruck.x = (Width - 100) / 15.0 + 50
roundDisplayFiretruck.y = 12

chessTimerDisplay = display.newText({
	parent = GameplayGroup,
	text = "15s",
	x = Width - 30,
	y = Height - 20,
	w = 50,
	h = 50,
	font = "Arial",
	fontSize = 32,
	align = "left"
})
chessTimerDisplayShadow = display.newText({
	parent = GameplayGroup,
	text = chessTimerDisplay.text,
	x = chessTimerDisplay.x + 1,
	y = chessTimerDisplay.y + 1,
	w = chessTimerDisplay.width,
	h = chessTimerDisplay.height,
	font = "Arial",
	fontSize = 32,
	align = "left"
})
chessTimerDisplayShadow:setFillColor(0)
chessTimerDisplay:toFront()

HoverWallDisplay = display.newGroup()
HoverWallDisplay.anchorX = 0
HoverWallDisplay.anchorY = 0
HoverWallDisplay.x = MousePosition.x
HoverWallDisplay.y = MousePosition.y
GameplayGroup:insert(HoverWallDisplay)
local HoverWallDisplayLine = display.newLine(HoverWallDisplay, 0, 0, tileSize + 5, 0)
HoverWallDisplayLine.strokeWidth = 4
HoverWallDisplay:toFront()

--------- START WALL BUTTONS ---------
function CreateWallButtons()
	WallButtonGroup = display.newGroup()
	WallButtonGroup.x = Width / 2 - 3
	WallButtonGroup.y = Height - 95

	local wallBtn_single = display.newGroup()
	wallBtn_single.x = -Width / 2 + 50
	WallButtonGroup:insert(wallBtn_single)
	local wallBtn_single_buttonTop = display.newRoundedRect(wallBtn_single, 0, 0, 50, 50, 5)
	local wallBtn_single_buttonText = display.newText({
		parent = wallBtn_single,
		text = "Single",
		x = wallBtn_single_buttonTop.x,
		y = wallBtn_single_buttonTop.y + 22,
		width = wallBtn_single_buttonTop.width,
		height = 58,
		font = "Arial",
		fontSize = 14,
		align = "center"
	})
	wallBtn_single_buttonText:setFillColor(0, 0, 0)
	wallBtn_single_buttonEnabled = display.newRoundedRect(wallBtn_single, wallBtn_single_buttonTop.x, wallBtn_single_buttonTop.y, wallBtn_single_buttonTop.width, wallBtn_single_buttonTop.height, 5)
	wallBtn_single_buttonEnabled:setFillColor(0, 0.5, 0, 0.4)
	wallBtn_single_buttonEnabled.isVisible = true
	table.insert(enabledButtonsGroup, wallBtn_single_buttonEnabled)
	wallBtn_single_buttonDisabled = display.newRoundedRect(wallBtn_single, wallBtn_single_buttonTop.x, wallBtn_single_buttonTop.y, wallBtn_single_buttonTop.width, wallBtn_single_buttonTop.height, 5)
	wallBtn_single_buttonDisabled:setFillColor(0, 0, 0, 0.4)
	wallBtn_single_buttonDisabled.isVisible = false
	table.insert(disabledButtonsGroup, wallBtn_single_buttonDisabled)
	RotateIn(wallBtn_single, 0, "right")
	wallBtn_single_buttonTop:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end
		SelectNewWall("single")
		for i, btn in ipairs(enabledButtonsGroup) do
			btn.isVisible = false
		end
		wallBtn_single_buttonEnabled.isVisible = true
	end)

	local wallBtn_double = display.newGroup()
	wallBtn_double.x = -Width / 2 + 105
	WallButtonGroup:insert(wallBtn_double)
	local wallBtn_double_buttonTop = display.newRoundedRect(wallBtn_double, 0, 0, 50, 50, 5)
	local wallBtn_double_buttonText = display.newText({
		parent = wallBtn_double,
		text = "Double",
		x = wallBtn_double_buttonTop.x,
		y = wallBtn_double_buttonTop.y + 22,
		width = wallBtn_double_buttonTop.width,
		height = 58,
		font = "Arial",
		fontSize = 14,
		align = "center"
	})
	wallBtn_double_buttonText:setFillColor(0, 0, 0)
	wallBtn_double_buttonEnabled = display.newRoundedRect(wallBtn_double, wallBtn_double_buttonTop.x, wallBtn_double_buttonTop.y, wallBtn_double_buttonTop.width, wallBtn_double_buttonTop.height, 5)
	wallBtn_double_buttonEnabled:setFillColor(0, 0.5, 0, 0.4)
	wallBtn_double_buttonEnabled.isVisible = false
	table.insert(enabledButtonsGroup, wallBtn_double_buttonEnabled)
	wallBtn_double_buttonDisabled = display.newRoundedRect(wallBtn_double, wallBtn_double_buttonTop.x, wallBtn_double_buttonTop.y, wallBtn_double_buttonTop.width, wallBtn_double_buttonTop.height, 5)
	wallBtn_double_buttonDisabled:setFillColor(0, 0, 0, 0.4)
	wallBtn_double_buttonDisabled.isVisible = false
	table.insert(disabledButtonsGroup, wallBtn_double_buttonDisabled)
	RotateIn(wallBtn_double, 100, "right")
	wallBtn_double_buttonTop:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end
		SelectNewWall("double")
		for i, btn in ipairs(enabledButtonsGroup) do
			btn.isVisible = false
		end
		wallBtn_double_buttonEnabled.isVisible = true
	end)

	local wallBtn_corner = display.newGroup()
	wallBtn_corner.x = -Width / 2 + 160
	WallButtonGroup:insert(wallBtn_corner)
	local wallBtn_corner_buttonTop = display.newRoundedRect(wallBtn_corner, 0, 0, 50, 50, 5)
	local wallBtn_corner_buttonText = display.newText({
		parent = wallBtn_corner,
		text = "Corner",
		x = wallBtn_corner_buttonTop.x,
		y = wallBtn_corner_buttonTop.y + 22,
		width = wallBtn_corner_buttonTop.width,
		height = 58,
		font = "Arial",
		fontSize = 14,
		align = "center"
	})
	wallBtn_corner_buttonText:setFillColor(0, 0, 0)
	wallBtn_corner_buttonEnabled = display.newRoundedRect(wallBtn_corner, wallBtn_corner_buttonTop.x, wallBtn_corner_buttonTop.y, wallBtn_corner_buttonTop.width, wallBtn_corner_buttonTop.height, 5)
	wallBtn_corner_buttonEnabled:setFillColor(0, 0.5, 0, 0.4)
	wallBtn_corner_buttonEnabled.isVisible = false
	table.insert(enabledButtonsGroup, wallBtn_corner_buttonEnabled)
	wallBtn_corner_buttonDisabled = display.newRoundedRect(wallBtn_corner, wallBtn_corner_buttonTop.x, wallBtn_corner_buttonTop.y, wallBtn_corner_buttonTop.width, wallBtn_corner_buttonTop.height, 5)
	wallBtn_corner_buttonDisabled:setFillColor(0, 0, 0, 0.4)
	wallBtn_corner_buttonDisabled.isVisible = false
	table.insert(disabledButtonsGroup, wallBtn_corner_buttonDisabled)
	RotateIn(wallBtn_corner, 200, "right")
	wallBtn_corner_buttonTop:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end
		SelectNewWall("corner")
		for i, btn in ipairs(enabledButtonsGroup) do
			btn.isVisible = false
		end
		wallBtn_corner_buttonEnabled.isVisible = true
	end)

	local wallBtn_lshape = display.newGroup()
	wallBtn_lshape.x = -Width / 2 + 215
	WallButtonGroup:insert(wallBtn_lshape)
	local wallBtn_lshape_buttonTop = display.newRoundedRect(wallBtn_lshape, 0, 0, 50, 50, 5)
	local wallBtn_lshape_buttonText = display.newText({
		parent = wallBtn_lshape,
		text = "L-Shape",
		x = wallBtn_lshape_buttonTop.x,
		y = wallBtn_lshape_buttonTop.y + 14,
		width = wallBtn_lshape_buttonTop.width,
		height = 58,
		font = "Arial",
		fontSize = 14,
		align = "center"
	})
	wallBtn_lshape_buttonText:setFillColor(0, 0, 0)
	wallBtn_lshape_buttonEnabled = display.newRoundedRect(wallBtn_lshape, wallBtn_lshape_buttonTop.x, wallBtn_lshape_buttonTop.y, wallBtn_lshape_buttonTop.width, wallBtn_lshape_buttonTop.height, 5)
	wallBtn_lshape_buttonEnabled:setFillColor(0, 0.5, 0, 0.4)
	wallBtn_lshape_buttonEnabled.isVisible = false
	table.insert(enabledButtonsGroup, wallBtn_lshape_buttonEnabled)
	wallBtn_lshape_buttonDisabled = display.newRoundedRect(wallBtn_lshape, wallBtn_lshape_buttonTop.x, wallBtn_lshape_buttonTop.y, wallBtn_lshape_buttonTop.width, wallBtn_lshape_buttonTop.height, 5)
	wallBtn_lshape_buttonDisabled:setFillColor(0, 0, 0, 0.4)
	wallBtn_lshape_buttonDisabled.isVisible = false
	table.insert(disabledButtonsGroup, wallBtn_lshape_buttonDisabled)
	RotateIn(wallBtn_lshape, 300, "right")
	wallBtn_lshape_buttonTop:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end
		SelectNewWall("l-shape")
		for i, btn in ipairs(enabledButtonsGroup) do
			btn.isVisible = false
		end
		wallBtn_lshape_buttonEnabled.isVisible = true
	end)

	local wallBtn_lshapereverse = display.newGroup()
	wallBtn_lshapereverse.x = -Width / 2 + 270
	WallButtonGroup:insert(wallBtn_lshapereverse)
	local wallBtn_lshapereverse_buttonTop = display.newRoundedRect(wallBtn_lshapereverse, 0, 0, 50, 50, 5)
	local wallBtn_lshapereverse_buttonText = display.newText({
		parent = wallBtn_lshapereverse,
		text = "L-Shape Flipped",
		x = wallBtn_lshapereverse_buttonTop.x,
		y = wallBtn_lshapereverse_buttonTop.y + 5,
		width = wallBtn_lshapereverse_buttonTop.width,
		height = 58,
		font = "Arial",
		fontSize = 14,
		align = "center"
	})
	wallBtn_lshapereverse_buttonText:setFillColor(0, 0, 0)
	wallBtn_lshapereverse_buttonEnabled = display.newRoundedRect(wallBtn_lshapereverse, wallBtn_lshapereverse_buttonTop.x, wallBtn_lshapereverse_buttonTop.y, wallBtn_lshapereverse_buttonTop.width, wallBtn_lshapereverse_buttonTop.height, 5)
	wallBtn_lshapereverse_buttonEnabled:setFillColor(0, 0.5, 0, 0.4)
	wallBtn_lshapereverse_buttonEnabled.isVisible = false
	table.insert(enabledButtonsGroup, wallBtn_lshapereverse_buttonEnabled)
	wallBtn_lshapereverse_buttonDisabled = display.newRoundedRect(wallBtn_lshapereverse, wallBtn_lshapereverse_buttonTop.x, wallBtn_lshapereverse_buttonTop.y, wallBtn_lshapereverse_buttonTop.width, wallBtn_lshapereverse_buttonTop.height, 5)
	wallBtn_lshapereverse_buttonDisabled:setFillColor(0, 0, 0, 0.4)
	wallBtn_lshapereverse_buttonDisabled.isVisible = false
	table.insert(disabledButtonsGroup, wallBtn_lshapereverse_buttonDisabled)
	RotateIn(wallBtn_lshapereverse, 400, "right")
	wallBtn_lshapereverse_buttonTop:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end
		SelectNewWall("l-shape reverse")
		for i, btn in ipairs(enabledButtonsGroup) do
			btn.isVisible = false
		end
		wallBtn_lshapereverse_buttonEnabled.isVisible = true
	end)

	local wallBtn_ushape = display.newGroup()
	wallBtn_ushape.x = -Width / 2 + 325
	WallButtonGroup:insert(wallBtn_ushape)
	local wallBtn_ushape_buttonTop = display.newRoundedRect(wallBtn_ushape, 0, 0, 50, 50, 5)
	local wallBtn_ushape_buttonText = display.newText({
		parent = wallBtn_ushape,
		text = "U-Shape",
		x = wallBtn_ushape_buttonTop.x,
		y = wallBtn_ushape_buttonTop.y + 14,
		width = wallBtn_ushape_buttonTop.width,
		height = 58,
		font = "Arial",
		fontSize = 14,
		align = "center"
	})
	wallBtn_ushape_buttonText:setFillColor(0, 0, 0)
	wallBtn_ushape_buttonTop_buttonEnabled = display.newRoundedRect(wallBtn_ushape, wallBtn_ushape_buttonTop.x, wallBtn_ushape_buttonTop.y, wallBtn_ushape_buttonTop.width, wallBtn_ushape_buttonTop.height, 5)
	wallBtn_ushape_buttonTop_buttonEnabled:setFillColor(0, 0.5, 0, 0.4)
	wallBtn_ushape_buttonTop_buttonEnabled.isVisible = false
	table.insert(enabledButtonsGroup, wallBtn_ushape_buttonTop_buttonEnabled)
	wallBtn_ushape_buttonDisabled = display.newRoundedRect(wallBtn_ushape, wallBtn_ushape_buttonTop.x, wallBtn_ushape_buttonTop.y, wallBtn_ushape_buttonTop.width, wallBtn_ushape_buttonTop.height, 5)
	wallBtn_ushape_buttonDisabled:setFillColor(0, 0, 0, 0.4)
	wallBtn_ushape_buttonDisabled.isVisible = false
	table.insert(disabledButtonsGroup, wallBtn_ushape_buttonDisabled)
	RotateIn(wallBtn_ushape, 500, "right")
	wallBtn_ushape_buttonTop:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end
		SelectNewWall("u-shape")
		for i, btn in ipairs(enabledButtonsGroup) do
			btn.isVisible = false
		end
		wallBtn_ushape_buttonTop_buttonEnabled.isVisible = true
	end)

	local wallBtn_zigzag = display.newGroup()
	wallBtn_zigzag.x = -Width / 2 + 380
	WallButtonGroup:insert(wallBtn_zigzag)
	local wallBtn_zigzag_buttonTop = display.newRoundedRect(wallBtn_zigzag, 0, 0, 50, 50, 5)
	local wallBtn_zigzag_buttonText = display.newText({
		parent = wallBtn_zigzag,
		text = "Zigzag",
		x = wallBtn_zigzag_buttonTop.x,
		y = wallBtn_zigzag_buttonTop.y + 22,
		width = wallBtn_zigzag_buttonTop.width,
		height = 58,
		font = "Arial",
		fontSize = 14,
		align = "center"
	})
	wallBtn_zigzag_buttonText:setFillColor(0, 0, 0)
	wallBtn_zigzag_buttonTop_buttonEnabled = display.newRoundedRect(wallBtn_zigzag, wallBtn_zigzag_buttonTop.x, wallBtn_zigzag_buttonTop.y, wallBtn_zigzag_buttonTop.width, wallBtn_zigzag_buttonTop.height, 5)
	wallBtn_zigzag_buttonTop_buttonEnabled:setFillColor(0, 0.5, 0, 0.4)
	wallBtn_zigzag_buttonTop_buttonEnabled.isVisible = false
	table.insert(enabledButtonsGroup, wallBtn_zigzag_buttonTop_buttonEnabled)
	wallBtn_zigzag_buttonDisabled = display.newRoundedRect(wallBtn_zigzag, wallBtn_zigzag_buttonTop.x, wallBtn_zigzag_buttonTop.y, wallBtn_zigzag_buttonTop.width, wallBtn_zigzag_buttonTop.height, 5)
	wallBtn_zigzag_buttonDisabled:setFillColor(0, 0, 0, 0.4)
	wallBtn_zigzag_buttonDisabled.isVisible = false
	table.insert(disabledButtonsGroup, wallBtn_zigzag_buttonDisabled)
	RotateIn(wallBtn_zigzag, 500, "right")
	wallBtn_zigzag_buttonTop:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end
		SelectNewWall("zigzag")
		for i, btn in ipairs(enabledButtonsGroup) do
			btn.isVisible = false
		end
		wallBtn_zigzag_buttonTop_buttonEnabled.isVisible = true
	end)

	local wallBtn_zigzagreverse = display.newGroup()
	wallBtn_zigzagreverse.x = -Width / 2 + 435
	WallButtonGroup:insert(wallBtn_zigzagreverse)
	local wallBtn_zigzagreverse_buttonTop = display.newRoundedRect(wallBtn_zigzagreverse, 0, 0, 50, 50, 5)
	local wallBtn_zigzagreverse_buttonText = display.newText({
		parent = wallBtn_zigzagreverse,
		text = "Zigzag Flipped",
		x = wallBtn_zigzagreverse_buttonTop.x,
		y = wallBtn_zigzagreverse_buttonTop.y + 14,
		width = wallBtn_zigzagreverse_buttonTop.width,
		height = 58,
		font = "Arial",
		fontSize = 14,
		align = "center"
	})
	wallBtn_zigzagreverse_buttonText:setFillColor(0, 0, 0)
	wallBtn_zigzagreverse_buttonTop_buttonEnabled = display.newRoundedRect(wallBtn_zigzagreverse, wallBtn_zigzagreverse_buttonTop.x, wallBtn_zigzagreverse_buttonTop.y, wallBtn_zigzagreverse_buttonTop.width, wallBtn_zigzagreverse_buttonTop.height, 5)
	wallBtn_zigzagreverse_buttonTop_buttonEnabled:setFillColor(0, 0.5, 0, 0.4)
	wallBtn_zigzagreverse_buttonTop_buttonEnabled.isVisible = false
	table.insert(enabledButtonsGroup, wallBtn_zigzagreverse_buttonTop_buttonEnabled)
	wallBtn_zigzagreverse_buttonDisabled = display.newRoundedRect(wallBtn_zigzagreverse, wallBtn_zigzagreverse_buttonTop.x, wallBtn_zigzagreverse_buttonTop.y, wallBtn_zigzagreverse_buttonTop.width, wallBtn_zigzagreverse_buttonTop.height, 5)
	wallBtn_zigzagreverse_buttonDisabled:setFillColor(0, 0, 0, 0.4)
	wallBtn_zigzagreverse_buttonDisabled.isVisible = false
	table.insert(disabledButtonsGroup, wallBtn_zigzagreverse_buttonDisabled)
	RotateIn(wallBtn_zigzagreverse, 500, "right")
	wallBtn_zigzagreverse_buttonTop:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end
		SelectNewWall("zigzag reverse")
		for i, btn in ipairs(enabledButtonsGroup) do
			btn.isVisible = false
		end
		wallBtn_zigzagreverse_buttonTop_buttonEnabled.isVisible = true
	end)
end
--------- END WALL BUTTONS ---------

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
				--PlayerEliminated[tile.furniturePlayer] = true
			end
		end
	end

	for thisPlayer = 1, Players do
		if not PlayerEliminated[thisPlayer] then
			local thisPlayerAllFurnBurnt = true
			for i, tile in ipairs(Tiles) do
				if tile.furniturePlayer == thisPlayer and not tile.onFire then
					thisPlayerAllFurnBurnt = false
				end
			end
			if thisPlayerAllFurnBurnt then
				PlayerEliminated[thisPlayer] = true
			end
		end
	end

	local allEliminated = true
	for i, elim in ipairs(PlayerEliminated) do
		if not elim then
			allEliminated = false
		end
	end
	if allEliminated then
		ChangeState("Game Over")
	end
end
