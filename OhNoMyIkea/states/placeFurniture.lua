
-- FUNCTIONS
local function SelectFurniture(furniture)
	if furniture == SelectedFurniture then
		SelectedFurniture = ""
		--couchButtonSelected.isVisible = false
		sidetableButtonSelected.isVisible = false
		--tableButtonSelected.isVisible = false
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
		--couchButtonSelected.isVisible = false
		sidetableButtonSelected.isVisible = false
		--tableButtonSelected.isVisible = false
		if furniture == "Couch" then
			--couchButtonSelected.isVisible = true
			--currentFurnitureHover = display.newRect(MousePosition.x, MousePosition.y, tileSize * 2, tileSize)
			--currentFurnitureHover:setFillColor(0.4, 0.1, 0.025)
		elseif furniture == "Side Table" then
			sidetableButtonSelected.isVisible = true
			currentFurnitureHover = display.newImageRect("images/sidetable.png", tileSize, tileSize)
			currentFurnitureHover.x = MousePosition.x
			currentFurnitureHover.y = MousePosition.y
		elseif furniture == "Coffee Table" then
			--tableButtonSelected.isVisible = true
		end
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

--[[couchButton = display.newRoundedRect(PlaceFurnitureGroup, Width / 4 + 50, Height - 70, 60, 60, 5)
couchButton:setFillColor(1, 1, 1, 0.25)
couchButtonText = display.newText({
	parent = PlaceFurnitureGroup,
	text = "Couch [DISABLED]",
	x = couchButton.x,
	y = couchButton.y + 2,
	width = couchButton.width,
	height = 22,
	font = "Arial",
	fontSize = 10,
	align = "center"
})
couchButtonText:setFillColor(0.5, 0, 0, 0.5)
couchButtonSelected = display.newRoundedRect(PlaceFurnitureGroup, couchButton.x, couchButton.y, couchButton.width, couchButton.height, 5)
couchButtonSelected:setFillColor(0, 0.5, 0, 0.4)
couchButtonSelected.isVisible = false]]

sidetableButton = display.newRoundedRect(PlaceFurnitureGroup, Width / 2, Height - 70, 60, 60, 5)
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

--[[tableButton = display.newRoundedRect(PlaceFurnitureGroup, Width / 4 * 3 - 50, Height - 70, 60, 60, 5)
tableButton:setFillColor(1, 1, 1, 0.25)
tableButtonText = display.newText({
	parent = PlaceFurnitureGroup,
	text = "TV [DISABLED]",
	x = tableButton.x,
	y = tableButton.y + 2,
	width = tableButton.width,
	height = 22,
	font = "Arial",
	fontSize = 10,
	align = "center"
})
tableButtonText:setFillColor(0.5, 0, 0, 0.5)
tableButtonSelected = display.newRoundedRect(PlaceFurnitureGroup, tableButton.x, tableButton.y, tableButton.width, tableButton.height, 5)
tableButtonSelected:setFillColor(0, 0.5, 0, 0.4)
tableButtonSelected.isVisible = false]]

currentFurnitureHover = nil

-- EVENT LISTENERS
--couchButton:addEventListener("touch", function(e)
	--if e.phase ~= "began" then return end
	--SelectFurniture("Couch")
--end)
sidetableButton:addEventListener("touch", function(e)
	if e.phase ~= "began" then return end
	SelectFurniture("Side Table")
end)
--tableButton:addEventListener("touch", function(e)
	--if e.phase ~= "began" then return end
	--SelectFurniture("Coffee Table")
--end)
