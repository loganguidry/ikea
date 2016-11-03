
-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Create a new scene
local composer = require("composer")
local scene = composer.newScene()
globalSceneGroup = nil

-- Get window size:
Width = display.contentWidth
Height = display.contentHeight

-- Import animations
require("animations")

-- Variables
CurrentPlayer = 1
Players = 2
State = "Player Select" --"Player Select", "Placing Furniture", "Gameplay", "Game Over"
SelectedFurniture = ""
MousePosition = {x = 0, y = 0}
CurrentWallDirection = 0
gridSize = Players * 2 + 10
tileSize = (Width - 65) / gridSize
CurrentRound = 1
MaxRounds = 15
PlayerEliminated = {
	false, false, false, false
}
PlayerScores = {0, 0, 0, 0}
PlayerFurnitures = {0, 0, 0, 0}
LoseGame = false
TryingToPlaceWalls = false
TryingToPlaceWallsIndexes = {}
FurnitureTileIndexes = {}
PlayerPlacedWall = {
	{
		["single"] = false,
		["double"] = false,
		["corner"] = false,
		["l-shape"] = false,
		["l-shape reverse"] = false,
		["u-shape"] = false,
		["zigzag"] = false,
		["zigzag reverse"] = false
	},
	{
		["single"] = false,
		["double"] = false,
		["corner"] = false,
		["l-shape"] = false,
		["l-shape reverse"] = false,
		["u-shape"] = false,
		["zigzag"] = false,
		["zigzag reverse"] = false
	},
	{
		["single"] = false,
		["double"] = false,
		["corner"] = false,
		["l-shape"] = false,
		["l-shape reverse"] = false,
		["u-shape"] = false,
		["zigzag"] = false,
		["zigzag reverse"] = false
	},
	{
		["single"] = false,
		["double"] = false,
		["corner"] = false,
		["l-shape"] = false,
		["l-shape reverse"] = false,
		["u-shape"] = false,
		["zigzag"] = false,
		["zigzag reverse"] = false
	},
}
local hoverTile = {x = 0, y = 0}

-- Background Object
background = display.newRect(Width / 2, Height / 2, Width, Height)
background.fill = {
	type = "gradient",
	color1 = {215 / 255, 185 / 255, 247 / 255, 1},
	color2 = {59 / 255, 247 / 255, 249 / 255, 1},
	direction = "down"
}

require("playerColors")

-- Objects
currentPlayer = display.newText({
	parent = globalSceneGroup,
	text = "Player 1",
	x = Width / 2,
	y = Height - 162,
	width = Width,
	height = 64,
	font = "Arial",
	fontSize = 56,
	align = "center"
})
currentPlayer.isVisible = false
currentPlayerShadow = display.newText({
	parent = globalSceneGroup,
	text = "Player 1",
	x = currentPlayer.x + 1,
	y = currentPlayer.y + 1,
	width = currentPlayer.width,
	height = currentPlayer.height,
	font = "Arial",
	fontSize = 56,
	align = "center"
})
currentPlayerShadow.isVisible = false
currentPlayerShadow:setFillColor(0)
currentPlayer:toFront()

-- Change player display
local c = PlayerColors[CurrentPlayer]
currentPlayer:setFillColor(c.r, c.g, c.b)

require("states.playerSelection")
require("states.placeFurniture")
require("states.gameplay")
require("states.gameover")
require("audio.audioFiles")
require("tooltip")
require("wallBlockage")
require("placingWalls")
require("chooseWall")
require("placingWallPopup")
require("outtaTimePopup")

-- Tile objects
require("walls")
require("tiles")

-- Changing states
function ChangeState(newState)
	print(State .. " --> " .. newState)
	if State == "Player Select" then
		PlayerSelectionGroup.isVisible = false
		currentPlayer.isVisible = true
		currentPlayerShadow.isVisible = true
		CreateGrid()
	elseif State == "Placing Furniture" then
		PlaceFurnitureGroup.isVisible = false
		if currentFurnitureHover ~= nil then
			currentFurnitureHover:removeSelf()
			currentFurnitureHover = nil
		end
	elseif State == "Gameplay" then
		GameplayGroup.isVisible = false
		for i = #Tiles, 1, -1 do
			-- Get player scores
			if not Tiles[i].onFire then
				if Tiles[i].furniture ~= "" then
					PlayerScores[Tiles[i].furniturePlayer] = PlayerScores[Tiles[i].furniturePlayer] + 25
				end
			end

			-- Remove tile
			Tiles[i].Object:removeSelf()
			Tiles[i].Fire:removeSelf()
			if Tiles[i].Sprite ~= nil then
				Tiles[i].Sprite:removeSelf()
			end
			table.remove(Tiles)
		end
		for i = #Walls, 1, -1 do
			Walls[i].Object:removeSelf()
			table.remove(Walls)
		end
	elseif State == "Game Over" then

	end
	State = newState
	if State == "Player Select" then
		PlayerSelectionGroup.isVisible = true
		currentPlayer.isVisible = false
		currentPlayerShadow.isVisible = false
	elseif State == "Placing Furniture" then
		PlaceFurnitureGroup.isVisible = true
		currentPlayer.isVisible = true
		currentPlayerShadow.isVisible = true
	elseif State == "Gameplay" then
		GameplayGroup.isVisible = true
		StartFire()
		StartFire()
		for i, tile in ipairs(Tiles) do
			GameplayGroup:insert(tile.Object)
			tile.Object:toBack()
		end
		HoverWallDisplay:toFront()
		CurrentWallDirection = 0
		RotateHoverWallDisplay()
		wallPlaceTimeStart = system.getTimer()
		CreateWallButtons()
		SelectNewWall("single")
	elseif State == "Game Over" then
		HoverWallDisplay.isVisible = false
		GameplayGroup.isVisible = false
		currentPlayer.isVisible = false
		currentPlayerShadow.isVisible = false
		WallButtonGroup.isVisible = false
		if currentFurnitureHover ~= nil then
			currentFurnitureHover:removeSelf()
			currentFurnitureHover = nil
		end
		HoverTooltip.Group.isVisible = false
		displayGameOverScreen()
	end
end

-- Rotate the hover wall display:
function RotateHoverWallDisplay()
	if HoverWallDisplay ~= nil then
		if HoverWallDisplay.rotation == 0 then
			HoverWallDisplay.x = hoverTile.x - tileSize / 2
			HoverWallDisplay.y = hoverTile.y + tileSize / 2
		elseif HoverWallDisplay.rotation == 90 then
			HoverWallDisplay.x = hoverTile.x + tileSize / 2
			HoverWallDisplay.y = hoverTile.y - tileSize / 2
		elseif HoverWallDisplay.rotation == 180 then
			HoverWallDisplay.x = hoverTile.x + tileSize / 2
			HoverWallDisplay.y = hoverTile.y - tileSize / 2
		elseif HoverWallDisplay.rotation == 270 then
			HoverWallDisplay.x = hoverTile.x - tileSize / 2
			HoverWallDisplay.y = hoverTile.y + tileSize / 2
		end
	end
end

-- Scene functions
function scene:create(event)
	globalSceneGroup = self.view
	globalSceneGroup:insert(GameplayGroup)
	globalSceneGroup:insert(GameoverGroup)
	globalSceneGroup:insert(PlaceFurnitureGroup)
	globalSceneGroup:insert(HoverWallDisplay)
	globalSceneGroup:insert(HoverTooltip)
	globalSceneGroup:insert(outOfTimeGroup)
	globalSceneGroup:insert(placingWallGroup)
end
function scene:show(event)
end
function scene:hide(event)
end
function scene:destroy(event)
end

-- Code to execute every frame (60 times per second)
local lastShakeLogoTime = 0
local function EveryFrame(event)
	if HoverWallDisplay ~= nil then
		HoverWallDisplay:toFront()
	end

	if State == "Player Select" and system.getTimer() - lastShakeLogoTime >= 8000 then
		lastShakeLogoTime = system.getTimer()
		transition.to(logoTextGroup, {
			time = 100,
			delay = 0,
			transition = easing.inOutSine,
			rotation = 30
		})
		transition.to(logoTextGroup, {
			time = 100,
			delay = 200,
			transition = easing.inOutSine,
			rotation = -25
		})
		transition.to(logoTextGroup, {
			time = 100,
			delay = 300,
			transition = easing.inOutSine,
			rotation = 22
		})
		transition.to(logoTextGroup, {
			time = 100,
			delay = 400,
			transition = easing.inOutSine,
			rotation = -15
		})
		transition.to(logoTextGroup, {
			time = 100,
			delay = 500,
			transition = easing.inOutSine,
			rotation = 12
		})
		transition.to(logoTextGroup, {
			time = 100,
			delay = 600,
			transition = easing.inOutSine,
			rotation = -5
		})
		transition.to(logoTextGroup, {
			time = 150,
			delay = 700,
			transition = easing.inOutSine,
			rotation = 10
		})
		transition.to(twoPlayersButtonGroup, {
			time = 150,
			delay = 0,
			transition = easing.inOutSine,
			xScale = 1.1,
			yScale = 1.1,
		})
		transition.to(twoPlayersButtonGroup, {
			time = 150,
			delay = 150,
			transition = easing.inOutSine,
			xScale = 1,
			yScale = 1,
		})
		transition.to(threePlayersButtonGroup, {
			time = 150,
			delay = 150,
			transition = easing.inOutSine,
			xScale = 1.1,
			yScale = 1.1,
		})
		transition.to(threePlayersButtonGroup, {
			time = 150,
			delay = 300,
			transition = easing.inOutSine,
			xScale = 1,
			yScale = 1,
		})
		transition.to(fourPlayersButtonGroup, {
			time = 150,
			delay = 300,
			transition = easing.inOutSine,
			xScale = 1.1,
			yScale = 1.1,
		})
		transition.to(fourPlayersButtonGroup, {
			time = 150,
			delay = 450,
			transition = easing.inOutSine,
			xScale = 1,
			yScale = 1,
		})
	elseif State == "Gameplay" then
		-- Update timer display
		chessTimerDisplay.text = tostring(15 - math.floor((system.getTimer() - wallPlaceTimeStart) / 1000.0)) .. "s"
		chessTimerDisplayShadow.text = chessTimerDisplay.text

		-- Blink timer
		local setChessTimerVisibility = true
		if system.getTimer() - wallPlaceTimeStart >= 10000 then
			setChessTimerVisibility = true
		end
		if system.getTimer() - wallPlaceTimeStart >= 10500 then
			setChessTimerVisibility = false
		end
		if system.getTimer() - wallPlaceTimeStart >= 11000 then
			setChessTimerVisibility = true
		end
		if system.getTimer() - wallPlaceTimeStart >= 11500 then
			setChessTimerVisibility = false
		end
		if system.getTimer() - wallPlaceTimeStart >= 12000 then
			setChessTimerVisibility = true
		end
		if system.getTimer() - wallPlaceTimeStart >= 12500 then
			setChessTimerVisibility = false
		end
		if system.getTimer() - wallPlaceTimeStart >= 13000 then
			setChessTimerVisibility = true
		end
		if system.getTimer() - wallPlaceTimeStart >= 13500 then
			setChessTimerVisibility = false
		end
		if system.getTimer() - wallPlaceTimeStart >= 14000 then
			setChessTimerVisibility = true
		end
		if system.getTimer() - wallPlaceTimeStart >= 14500 then
			setChessTimerVisibility = false
		end
		if outOfTimeGroup.isVisible then
			setChessTimerVisibility = false
		end
		chessTimerDisplay.isVisible = setChessTimerVisibility
		chessTimerDisplayShadow.isVisible = setChessTimerVisibility

		-- Took too long to place a wall
		if system.getTimer() - wallPlaceTimeStart >= 15000 then
			-- Show popup
			outOfTimeGroup:toFront()
			outOfTimeGroup.isVisible = true
			chessTimerDisplay.isVisible = false
			chessTimerDisplayShadow.isVisible = false
			timer.performWithDelay(3000, function()
				outOfTimeGroup.isVisible = false
				chessTimerDisplay.isVisible = true
				chessTimerDisplayShadow.isVisible = true
				wallPlaceTimeStart = system.getTimer()
			end)

			-- Next player
			CurrentPlayer = CurrentPlayer + 1
			currentPlayer.text = "Player " .. tostring(CurrentPlayer)
			currentPlayerShadow.text = currentPlayer.text

			-- Loop around to first player
			if CurrentPlayer > Players then
				CurrentPlayer = 1
				currentPlayer.text = "Player " .. tostring(CurrentPlayer)
				currentPlayerShadow.text = currentPlayer.text
				SpreadFire()
				CurrentRound = CurrentRound + 1
				roundDisplay.width = (Width - 100) / 15.0 * CurrentRound
				roundDisplayFiretruck.x = roundDisplay.width + roundDisplay.x
				if CurrentRound >= MaxRounds and State ~= "Game Over" then
					print("Game Over")
					ChangeState("Game Over")
				end
			end
			disableWallButtons()
			while PlayerEliminated[CurrentPlayer] do
				local allEliminated = true
				for i, elim in ipairs(PlayerEliminated) do
					if not elim then
						allEliminated = false
					end
				end
				if allEliminated or State == "Game Over" then break end
				CurrentPlayer = CurrentPlayer + 1
				if CurrentPlayer > Players then
					CurrentPlayer = 1
					SpreadFire()
					CurrentRound = CurrentRound + 1
					roundDisplay.width = (Width - 100) / 15.0 * CurrentRound
					roundDisplayFiretruck.x = roundDisplay.width + roundDisplay.x
					if CurrentRound >= MaxRounds and State ~= "Game Over" then
						print("Game Over")
						ChangeState("Game Over")
					end
				end
				disableWallButtons()
				currentPlayer.text = "Player " .. tostring(CurrentPlayer)
				currentPlayerShadow.text = currentPlayer.text
			end

			-- Start timer
			wallPlaceTimeStart = system.getTimer()

			-- Change player display
			local c = PlayerColors[CurrentPlayer]
			currentPlayer:setFillColor(c.r, c.g, c.b)
		end
	end
end

-- Code to execute when the user presses (or releases) a button on their keyboard
local function KeyPress(event)
	if event.phase == "down" then
		if event.keyName == "space" then
			-- Spread the fire
			--SpreadFire()
		elseif event.keyName == "r" then
			-- Rotate wall
			CurrentWallDirection = CurrentWallDirection + 90
			if CurrentWallDirection == 360 then
				CurrentWallDirection = 0
			end
			HoverWallDisplay.rotation = CurrentWallDirection
			RotateHoverWallDisplay()
		elseif event.keyName == "m" then
			-- Mute audio
			audio.setVolume(0)
		elseif event.keyName == "w" then
			--[[ Cycle through walls
			WallKindIndex = WallKindIndex + 1
			if WallKindIndex > #WallKinds then
				WallKindIndex = 1
			end
			print(WallKindIndex, WallKinds[WallKindIndex])

			-- Update wall display
			HoverWallDisplay:removeSelf()
			HoverWallDisplay = display.newGroup()
			HoverWallDisplay.anchorX = 0
			HoverWallDisplay.anchorY = 0
			HoverWallDisplay.x = MousePosition.x
			HoverWallDisplay.y = MousePosition.y
			GameplayGroup:insert(HoverWallDisplay)

			if WallKinds[WallKindIndex] == "single" then
				local HoverWallDisplayLine = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
				HoverWallDisplayLine.strokeWidth = 4
			elseif WallKinds[WallKindIndex] == "double" then
				local HoverWallDisplayLine = display.newLine(HoverWallDisplay, 0, 0, tileSize * 2, 0)
				HoverWallDisplayLine.strokeWidth = 4
			elseif WallKinds[WallKindIndex] == "corner" then
				local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
				HoverWallDisplayLine1.strokeWidth = 4
				local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, 0, -tileSize, 0, 0)
				HoverWallDisplayLine2.strokeWidth = 4
			elseif WallKinds[WallKindIndex] == "l-shape" then
				local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
				HoverWallDisplayLine1.strokeWidth = 4
				local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, 0, tileSize * 2, 0)
				HoverWallDisplayLine2.strokeWidth = 4
				local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, 0, -tileSize, 0, 0)
				HoverWallDisplayLine3.strokeWidth = 4
			elseif WallKinds[WallKindIndex] == "l-shape reverse" then
				local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
				HoverWallDisplayLine1.strokeWidth = 4
				local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, 0, tileSize * 2, 0)
				HoverWallDisplayLine2.strokeWidth = 4
				local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, 0, 0, 0, tileSize)
				HoverWallDisplayLine3.strokeWidth = 4
			elseif WallKinds[WallKindIndex] == "u-shape" then
				local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
				HoverWallDisplayLine1.strokeWidth = 4
				local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, -tileSize, tileSize, 0)
				HoverWallDisplayLine2.strokeWidth = 4
				local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, 0, -tileSize, 0, 0)
				HoverWallDisplayLine3.strokeWidth = 4
			elseif WallKinds[WallKindIndex] == "zigzag" then
				local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
				HoverWallDisplayLine1.strokeWidth = 4
				local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, -tileSize, tileSize, 0)
				HoverWallDisplayLine2.strokeWidth = 4
				local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, tileSize, -tileSize, tileSize * 2, -tileSize)
				HoverWallDisplayLine3.strokeWidth = 4
			elseif WallKinds[WallKindIndex] == "zigzag reverse" then
				local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, -tileSize, tileSize, -tileSize)
				HoverWallDisplayLine1.strokeWidth = 4
				local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, -tileSize, tileSize, 0)
				HoverWallDisplayLine2.strokeWidth = 4
				local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, tileSize, 0, tileSize * 2, 0)
				HoverWallDisplayLine3.strokeWidth = 4
			end
			HoverWallDisplay:toFront()

			-- Rotate wall display
			CurrentWallDirection = 0
			RotateHoverWallDisplay()
			]]
		end
	end
end

-- Code to execute when the user touches the screen
local function TouchEvent(event)
	if event.phase == "began" then

	elseif event.phase == "ended" then

	end
end

-- Code to execute for a Mouse event
local function MouseEvent(event)
	MousePosition = {x = event.x, y = event.y}

	if nil == Tiles or #Tiles == 0 then return end
	if nil == HoverTooltip.Group then return end

	-- Hover over furniture
	local tileHover = false
	local tileFurniture
	local tileFurnitureOwner
	for i, tile in ipairs(Tiles) do
		if event.x > tile.Object.x - tileSize / 2 and
		event.x < tile.Object.x + tileSize / 2 and
		event.y > tile.Object.y - tileSize / 2 and
		event.y < tile.Object.y + tileSize / 2 and
		tile.furniture ~= "" then
			tileFurniture = tile.furniture
			tileFurnitureOwner = tile.furniturePlayer
			tileHover = true
			break
		end
	end
	if tileHover then
		HoverTooltip.Header.text = tileFurniture .. "\nPlayer " .. tostring(tileFurnitureOwner)
		HoverTooltip.HeaderShadow.text = HoverTooltip.Header.text
		HoverTooltip.Group.isVisible = true
		HoverTooltip.Group:toFront()
		HoverTooltip.Group.x = event.x
		HoverTooltip.Group.y = event.y
		if event.x >= Width - 120 then
			HoverTooltip.Group.x = Width - 120
		end
	else
		HoverTooltip.Group.isVisible = false
	end

	-- Placing wall
	for i, tile in ipairs(Tiles) do
		if event.x >= tile.Object.x - tileSize / 2 and
			event.x <= tile.Object.x + tileSize / 2 and
			event.y >= tile.Object.y - tileSize / 2 and
			event.y <= tile.Object.y + tileSize / 2 then
			hoverTile = {x = tile.Object.x, y = tile.Object.y}
		end
	end
	if HoverWallDisplay ~= nil then
		if HoverWallDisplay.rotation == 0 then
			HoverWallDisplay.x = hoverTile.x - tileSize / 2
			HoverWallDisplay.y = hoverTile.y + tileSize / 2
		elseif HoverWallDisplay.rotation == 90 then
			HoverWallDisplay.x = hoverTile.x + tileSize / 2
			HoverWallDisplay.y = hoverTile.y - tileSize / 2
		elseif HoverWallDisplay.rotation == 180 then
			HoverWallDisplay.x = hoverTile.x + tileSize / 2
			HoverWallDisplay.y = hoverTile.y - tileSize / 2
		elseif HoverWallDisplay.rotation == 270 then
			HoverWallDisplay.x = hoverTile.x - tileSize / 2
			HoverWallDisplay.y = hoverTile.y + tileSize / 2
		end
	end

	-- Placing furniture
	if currentFurnitureHover ~= nil then
		currentFurnitureHover.x = event.x
		currentFurnitureHover.y = event.y
	end
end

-- Event handlers
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
Runtime:addEventListener("enterFrame", EveryFrame)
Runtime:addEventListener("key", KeyPress)
Runtime:addEventListener("touch", TouchEvent)
Runtime:addEventListener("mouse", MouseEvent)

-- Start background audio/music
audio.play(Music["Gameplay"], {loops = -1})
