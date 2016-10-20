
-- FUNCTIONS
local function TouchTwoPlayers(event)
	if event.phase ~= "began" then return end
	Players = 2
	print("Set to 2 players")
	ChangeState("Placing Furniture")
	audio.play(Sounds["Start Game"])
end

local function TouchThreePlayers(event)
	if event.phase ~= "began" then return end
	Players = 3
	print("Set to 3 players")
	ChangeState("Placing Furniture")
	audio.play(Sounds["Start Game"])
end

local function TouchFourPlayers(event)
	if event.phase ~= "began" then return end
	Players = 4
	print("Set to 4 players")
	ChangeState("Placing Furniture")
	audio.play(Sounds["Start Game"])
end

-- OBJECTS
PlayerSelectionGroup = display.newGroup()

headerTextGroup = display.newGroup()
headerTextGroup.x = Width / 2
headerTextGroup.y = 200--Height / 2
PlayerSelectionGroup:insert(headerTextGroup)
headerText = display.newText({
	parent = headerTextGroup,
	text = "How many players?",
	x = 0,
	y = Height - 75,
	width = Width,
	height = Height,
	font = "basictitlefont",
	fontSize = 38,
	align = "center"
})
headerText:setFillColor(0, 0.6, 0.9, 1)
headerTextShadow = display.newText({
	parent = headerTextGroup,
	text = headerText.text,
	x = headerText.x + 1,
	y = headerText.y + 1,
	width = headerText.width,
	height = headerText.height,
	font = "basictitlefont",
	fontSize = 38,
	align = "center"
})
headerTextShadow:setFillColor(0, 0, 0, 1)
headerText:toFront()
InLeft(headerTextGroup, Width / 2, 250)

logoTextGroup = display.newGroup()
logoTextGroup.rotation = 10
logoTextGroup.x = Width / 2
logoTextGroup.y = -105
PlayerSelectionGroup:insert(logoTextGroup)
logoText = display.newText({
	parent = logoTextGroup,
	text = "Oh No, My Ikea!",
	x = 0,
	y = 125,
	width = Width,
	height = Height,
	font = "GrutchShaded",
	fontSize = 100,
	align = "center"
})
logoText:setFillColor(1, 0, 1, 1)
logoTextShadow = display.newText({
	parent = logoTextGroup,
	text = logoText.text,
	x = logoText.x + 1,
	y = logoText.y + 1,
	width = logoText.width,
	height = logoText.height,
	font = "GrutchShaded",
	fontSize = 100,
	align = "center"
})
logoTextShadow:setFillColor(0, 0, 0, 1)
logoText:toFront()
FallIn(logoTextGroup, Height / 2 - 40, 500)

twoPlayersButtonGroup = display.newGroup()
twoPlayersButtonGroup.x = Width / 4
twoPlayersButtonGroup.y = Height / 2
PlayerSelectionGroup:insert(twoPlayersButtonGroup)
twoPlayersButton = display.newRoundedRect(twoPlayersButtonGroup, 0, 0, Width / 5, Width / 5, 5)
twoPlayersButtonShadow = display.newRoundedRect(twoPlayersButtonGroup, twoPlayersButton.x + 1, twoPlayersButton.y + 1, twoPlayersButton.width, twoPlayersButton.height, 5)
twoPlayersButtonShadow:setFillColor(0, 0, 0)
twoPlayersButtonText = display.newText({
	parent = twoPlayersButtonGroup,
	text = "2",
	x = 0,
	y = 0,
	width = twoPlayersButton.width,
	height = 34,
	font = "Arial",
	fontSize = 32,
	align = "center"
	})
twoPlayersButtonText:setFillColor(0, 0, 0)
FallIn(twoPlayersButtonGroup, Height - 85, 0)
threePlayersButtonGroup = display.newGroup()
threePlayersButtonGroup.x = Width / 2
threePlayersButtonGroup.y = Height / 2
PlayerSelectionGroup:insert(threePlayersButtonGroup)
threePlayersButton = display.newRoundedRect(threePlayersButtonGroup, 0, 0, Width / 5, Width / 5, 5)
threePlayersButtonShadow = display.newRoundedRect(threePlayersButtonGroup, threePlayersButton.x + 1, threePlayersButton.y + 1, threePlayersButton.width, threePlayersButton.height, 5)
threePlayersButtonShadow:setFillColor(0, 0, 0)
threePlayersButtonText = display.newText({
	parent = threePlayersButtonGroup,
	text = "3",
	x = 0,
	y = 0,
	width = threePlayersButton.width,
	height = 34,
	font = "Arial",
	fontSize = 32,
	align = "center"
	})
threePlayersButtonText:setFillColor(0, 0, 0)
FallIn(threePlayersButtonGroup, Height - 85, 100)
fourPlayersButtonGroup = display.newGroup()
fourPlayersButtonGroup.x = Width / 4 * 3
fourPlayersButtonGroup.y = Height / 2
PlayerSelectionGroup:insert(fourPlayersButtonGroup)
fourPlayersButton = display.newRoundedRect(fourPlayersButtonGroup, 0, 0, Width / 5, Width / 5, 5)
fourPlayersButtonShadow = display.newRoundedRect(fourPlayersButtonGroup, fourPlayersButton.x + 1, fourPlayersButton.y + 1, fourPlayersButton.width, fourPlayersButton.height, 5)
fourPlayersButtonShadow:setFillColor(0, 0, 0)
fourPlayersButtonText = display.newText({
	parent = fourPlayersButtonGroup,
	text = "4",
	x = 0,
	y = 0,
	width = fourPlayersButton.width,
	height = 34,
	font = "Arial",
	fontSize = 32,
	align = "center"
	})
fourPlayersButtonText:setFillColor(0, 0, 0)
FallIn(fourPlayersButtonGroup, Height - 85, 200)
twoPlayersButton:toFront()
threePlayersButton:toFront()
fourPlayersButton:toFront()
twoPlayersButtonText:toFront()
threePlayersButtonText:toFront()
fourPlayersButtonText:toFront()

-- EVENT HANDLERS
twoPlayersButton:addEventListener("touch", TouchTwoPlayers)
threePlayersButton:addEventListener("touch", TouchThreePlayers)
fourPlayersButton:addEventListener("touch", TouchFourPlayers)
