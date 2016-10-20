-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Create a new scene
local composer = require("composer")
local scene = composer.newScene()

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
CurrentWallDirection = "horizontal"
gridSize = Players * 2 + 10
tileSize = (Width - 65) / gridSize
CurrentRound = 1
MaxRounds = 15
PlayerEliminated = {
	false, false, false, false
}

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
require("audio.audioFiles")
require("tooltip")

-- Tile objects
require("walls")
require("tiles")

-- Changing states
function ChangeState(newState)
	if State == "Player Select" then
		PlayerSelectionGroup.isVisible = false
		currentPlayer.isVisible = true
		currentPlayerShadow.isVisible = true
		CreateGrid()
	elseif State == "Placing Furniture" then
		PlaceFurnitureGroup.isVisible = false
		currentFurnitureHover:removeSelf()
		currentFurnitureHover = nil
	elseif State == "Gameplay" then
		GameplayGroup.isVisible = false
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
		for i, tile in ipairs(Tiles) do
			GameplayGroup:insert(tile.Object)
			tile.Object:toBack()
		end
		HoverWallDisplay:toFront()
	elseif State == "Game Over" then
		native.showAlert("The firefighters have arrived!", "If your furniture was burnt, you lose!", {"Ok"})
	end
end

-- Scene functions
function scene:create(event)
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
	if system.getTimer() - lastShakeLogoTime >= 8000 then
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
	end
end

-- Code to execute when the user presses (or releases) a button on their keyboard
local function KeyPress(event)
	if event.phase == "down" then
		if event.keyName == "space" then
			SpreadFire()
		elseif event.keyName == "r" then
			if CurrentWallDirection == "vertical" then
				CurrentWallDirection = "horizontal"
				HoverWallDisplay.rotation = 0
			else
				CurrentWallDirection = "vertical"
				HoverWallDisplay.rotation = 90
			end
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
	if HoverWallDisplay ~= nil then
		if HoverWallDisplay.rotation % 180 == 0 then
			HoverWallDisplay.x = event.x - tileSize / 2
			HoverWallDisplay.y = event.y
		else
			HoverWallDisplay.x = event.x
			HoverWallDisplay.y = event.y - tileSize / 2
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
