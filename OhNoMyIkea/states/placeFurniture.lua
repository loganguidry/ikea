
-- FUNCTIONS
local function SelectFurniture(furniture)
	if furniture == SelectedFurniture then
		SelectedFurniture = ""
		sidetableButtonSelected.isVisible = false
		if currentFurnitureHover ~= nil then
			currentFurnitureHover:removeSelf()
			currentFurnitureHover = nil
		end
	else
		if currentFurnitureHover ~= nil then
			currentFurnitureHover:removeSelf()
			currentFurnitureHover = nil
		end
		SelectedFurniture = furniture
		sidetableButtonSelected.isVisible = false
		tvstandButtonSelected.isVisible = false
		sectionalButtonSelected.isVisible = false
		bedButtonSelected.isVisible = false
		islandButtonSelected.isVisible = false
		if furniture == "Side Table" then
			sidetableButtonSelected.isVisible = true
			currentFurnitureHover = display.newImageRect("images/sidetable.png", tileSize, tileSize)
			currentFurnitureHover.x = MousePosition.x
			currentFurnitureHover.y = MousePosition.y
			currentFurnitureHover.anchorX = 0.5
			currentFurnitureHover.anchorY = 0.5
		elseif furniture == "TV Stand" then
			tvstandButtonSelected.isVisible = true
			currentFurnitureHover = display.newImageRect("images/tv.png", tileSize, tileSize * 2)
			currentFurnitureHover.x = MousePosition.x
			currentFurnitureHover.y = MousePosition.y
			currentFurnitureHover.anchorX = 0.5
			currentFurnitureHover.anchorY = 0.75
		elseif furniture == "Bed" then
			bedButtonSelected.isVisible = true
			currentFurnitureHover = display.newImageRect("images/bed.png", tileSize * 2, tileSize * 2)
			currentFurnitureHover.x = MousePosition.x
			currentFurnitureHover.y = MousePosition.y
			currentFurnitureHover.anchorX = 0.75
			currentFurnitureHover.anchorY = 0.75
		elseif furniture == "Kitchen Island" then
			islandButtonSelected.isVisible = true
			currentFurnitureHover = display.newImageRect("images/island.png", tileSize, tileSize * 3)
			currentFurnitureHover.x = MousePosition.x
			currentFurnitureHover.y = MousePosition.y
			currentFurnitureHover.anchorX = 0.5
			currentFurnitureHover.anchorY = 0.5
		elseif furniture == "Couch" then
			sectionalButtonSelected.isVisible = true
			currentFurnitureHover = display.newImageRect("images/couch.png", tileSize * 2, tileSize * 3)
			currentFurnitureHover.x = MousePosition.x
			currentFurnitureHover.y = MousePosition.y
			currentFurnitureHover.anchorX = 0.75
			currentFurnitureHover.anchorY = 0.83333
		end
		furnitureRotation = 0
	end
end

-- OBJECTS
PlaceFurnitureGroup = display.newGroup()
PlaceFurnitureGroup.isVisible = false

placeFurnitureInstructions = display.newText({
	parent = PlaceFurnitureGroup,
	text = "Place Furniture",
	x = Width / 2,
	y = Height - 116,
	width = Width,
	height = 28,
	font = "Arial",
	fontSize = 20,
	align = "center"
})
placeFurnitureInstructionsShadow = display.newText({
	parent = PlaceFurnitureGroup,
	text = placeFurnitureInstructions.text,
	x = placeFurnitureInstructions.x + 1,
	y = placeFurnitureInstructions.y + 1,
	width = placeFurnitureInstructions.width,
	height = placeFurnitureInstructions.height,
	font = "Arial",
	fontSize = 20,
	align = "center"
})
placeFurnitureInstructionsShadow:setFillColor(0)
placeFurnitureInstructions:toFront()

sidetableButton = display.newRoundedRect(PlaceFurnitureGroup, Width / 2 - 140, Height - 70, 60, 60, 5)
sidetableButtonText = display.newText({
	parent = PlaceFurnitureGroup,
	text = "Side Table",
	x = sidetableButton.x,
	y = sidetableButton.y + 10,
	width = sidetableButton.width,
	height = 58,
	font = "Arial",
	fontSize = 18,
	align = "center"
})
sidetableButtonText:setFillColor(0, 0, 0)
sidetableButtonSelected = display.newRoundedRect(PlaceFurnitureGroup, sidetableButton.x, sidetableButton.y, sidetableButton.width, sidetableButton.height, 5)
sidetableButtonSelected:setFillColor(0, 0.5, 0, 0.4)
sidetableButtonSelected.isVisible = false

tvstandButton = display.newRoundedRect(PlaceFurnitureGroup, Width / 2 - 70, Height - 70, 60, 60, 5)
tvstandButtonText = display.newText({
	parent = PlaceFurnitureGroup,
	text = "TV Stand",
	x = tvstandButton.x,
	y = tvstandButton.y + 10,
	width = tvstandButton.width,
	height = 58,
	font = "Arial",
	fontSize = 18,
	align = "center"
})
tvstandButtonText:setFillColor(0, 0, 0)
tvstandButtonSelected = display.newRoundedRect(PlaceFurnitureGroup, tvstandButton.x, tvstandButton.y, tvstandButton.width, tvstandButton.height, 5)
tvstandButtonSelected:setFillColor(0, 0.5, 0, 0.4)
tvstandButtonSelected.isVisible = false

sectionalButton = display.newRoundedRect(PlaceFurnitureGroup, Width / 2, Height - 70, 60, 60, 5)
sectionalButtonText = display.newText({
	parent = PlaceFurnitureGroup,
	text = "Couch",
	x = sectionalButton.x,
	y = sectionalButton.y + 18,
	width = sectionalButton.width,
	height = 58,
	font = "Arial",
	fontSize = 18,
	align = "center"
})
sectionalButtonText:setFillColor(0, 0, 0)
sectionalButtonSelected = display.newRoundedRect(PlaceFurnitureGroup, sectionalButton.x, sectionalButton.y, sectionalButton.width, sectionalButton.height, 5)
sectionalButtonSelected:setFillColor(0, 0.5, 0, 0.4)
sectionalButtonSelected.isVisible = false

bedButton = display.newRoundedRect(PlaceFurnitureGroup, Width / 2 + 70, Height - 70, 60, 60, 5)
bedButtonText = display.newText({
	parent = PlaceFurnitureGroup,
	text = "Bed",
	x = bedButton.x,
	y = bedButton.y + 18,
	width = bedButton.width,
	height = 58,
	font = "Arial",
	fontSize = 18,
	align = "center"
})
bedButtonText:setFillColor(0, 0, 0)
bedButtonSelected = display.newRoundedRect(PlaceFurnitureGroup, bedButton.x, bedButton.y, bedButton.width, bedButton.height, 5)
bedButtonSelected:setFillColor(0, 0.5, 0, 0.4)
bedButtonSelected.isVisible = false

islandButton = display.newRoundedRect(PlaceFurnitureGroup, Width / 2 + 140, Height - 70, 60, 60, 5)
islandButtonText = display.newText({
	parent = PlaceFurnitureGroup,
	text = "Kitchen Island",
	x = islandButton.x,
	y = islandButton.y + 10,
	width = islandButton.width,
	height = 58,
	font = "Arial",
	fontSize = 17,
	align = "center"
})
islandButtonText:setFillColor(0, 0, 0)
islandButtonSelected = display.newRoundedRect(PlaceFurnitureGroup, islandButton.x, islandButton.y, islandButton.width, islandButton.height, 5)
islandButtonSelected:setFillColor(0, 0.5, 0, 0.4)
islandButtonSelected.isVisible = false

doneButton = display.newRoundedRect(PlaceFurnitureGroup, Width - 25, Height - 25, 40, 30, 5)
doneButton:setFillColor(0, 0.5, 0, 0.4)
doneButtonText = display.newText({
	parent = PlaceFurnitureGroup,
	text = "Done",
	x = doneButton.x,
	y = doneButton.y + 2,
	width = doneButton.width,
	height = 18,
	font = "Arial",
	fontSize = 14,
	align = "center"
})
doneButtonText:setFillColor(0)

currentFurnitureHover = nil

-- EVENT LISTENERS
tvstandButton:addEventListener("touch", function(e)
	if e.phase ~= "began" then return end
	SelectFurniture("TV Stand")
end)
sidetableButton:addEventListener("touch", function(e)
	if e.phase ~= "began" then return end
	SelectFurniture("Side Table")
end)
sectionalButton:addEventListener("touch", function(e)
	if e.phase ~= "began" then return end
	SelectFurniture("Couch")
end)
bedButton:addEventListener("touch", function(e)
	if e.phase ~= "began" then return end
	SelectFurniture("Bed")
end)
islandButton:addEventListener("touch", function(e)
	if e.phase ~= "began" then return end
	SelectFurniture("Kitchen Island")
end)
doneButton:addEventListener("touch", function(e)
	if e.phase ~= "began" then return end
	if PlayerFurnitures[CurrentPlayer] == 0 then print ("Player has 0 furniture");return end

	CurrentPlayer = CurrentPlayer + 1
	currentPlayer.text = "Player " .. tostring(CurrentPlayer)
	currentPlayerShadow.text = currentPlayer.text
	if CurrentPlayer > Players then
		CurrentPlayer = 1
		currentPlayer.text = "Player " .. tostring(CurrentPlayer)
		currentPlayerShadow.text = currentPlayer.text
		ChangeState("Gameplay")
	end
	local c = PlayerColors[CurrentPlayer]
	currentPlayer:setFillColor(c.r, c.g, c.b)
end)
