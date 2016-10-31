
-- OBJECTS
GameoverGroup = display.newGroup()
GameoverGroup.isVisible = false

local lineHeight = Height - 370

local function StartOver(event)
	ChangeState("Player Select")

end

gameOverHeadline = display.newText({
	parent = GameoverGroup,
	text = "The Firetruck Is Here!",
	x = Width / 2,
	y = Height - 570,
	width = Width,
	height = 45,
	font = "Arial",
	fontSize = 45,
	align = "center"
})

gameOverHeadlineShadow = display.newText({
	parent = GameoverGroup,
	text = gameOverHeadline.text,
	x = gameOverHeadline.x + 1,
	y = gameOverHeadline.y + 1,
	width = gameOverHeadline.width,
	height = gameOverHeadline.height,
	font = "Arial",
	fontSize = 45,
	align = "center"
})
gameOverHeadlineShadow:setFillColor(0)
gameOverHeadline:setFillColor(1,0,0)

gameOverHeadline:toFront()


function displayGameOverScreen()
playerOne = display.newText({
	parent = GameoverGroup,
	text = "Player 1 Saved: $",
	x = 280,
	y = Height - 440,
	width = Width,
	height = 25,
	font = "Arial",
	fontSize = 20,
})
playerOne:setFillColor(0)
playerOne:toFront()

playerTwo = display.newText({
	parent = GameoverGroup,
	text = "Player 2 Saved: $",
	x = 280,
	y = Height - 400,
	width = Width,
	height = 25,
	font = "Arial",
	fontSize = 20,
})
playerTwo:setFillColor(0)
playerTwo:toFront()

-----------

if Players == 3 then
	playerThree = display.newText({
	parent = GameoverGroup,
	text = "Player 3 Saved: $",
	x = 280,
	y = Height - 360,
	width = Width,
	height = 25,
	font = "Arial",
	fontSize = 20,
})
playerThree:setFillColor(0)
playerThree:toFront()
lineHeight = Height - 330
end

----------

if Players == 4 then
	playerThree = display.newText({
	parent = GameoverGroup,
	text = "Player 3 Saved: $",
	x = 280,
	y = Height - 360,
	width = Width,
	height = 25,
	font = "Arial",
	fontSize = 20,
})
playerThree:setFillColor(0)
playerThree:toFront()

	playerFour = display.newText({
	parent = GameoverGroup,
	text = "Player 4 Saved: $",
	x = 280,
	y = Height - 320,
	width = Width,
	height = 25,
	font = "Arial",
	fontSize = 20,
})
playerFour:setFillColor(0)
playerFour:toFront()

lineHeight = Height - 290
end

------ LINE TO SEPARATE OVERAL $ SUM AND THE WINNER
	local line = display.newLine(GameoverGroup, 20, lineHeight, 460, lineHeight)
	line:setStrokeColor(0)
	line.strokeWidth = 3

------- TEXT TO CALC AND SHOW THE WINNER 

	winnerPlayerText = display.newText({
	parent = GameoverGroup,
	text = "Winner: Player ",
	x = 280,
	y = lineHeight + 30,
	width = Width,
	height = 25,
	font = "Arial",
	fontSize = 20,
})

winnerPlayerText:setFillColor(0)
winnerPlayerText:toFront()


------ GAME OVER TEXT
gameOverText = display.newText({
	parent = GameoverGroup,
	text = "Time to buy new furniture from \n IKEA and try again!",
	x = Width / 2,
	y = lineHeight + 130,
	width = Width,
	height = 100,
	font = "Arial",
	fontSize = 25,
	align = "center"
})

gameOverTextShadow = display.newText({
	parent = GameoverGroup,
	text = gameOverText.text,
	x = gameOverText.x + 1,
	y = gameOverText.y + 1,
	width = gameOverText.width,
	height = gameOverText.height,
	font = "Arial",
	fontSize = 25,
	align = "center"
})
gameOverTextShadow:setFillColor(0)
gameOverText:toFront()

------------ BUTTON ----------------
startOverButtonGroup = display.newGroup()
startOverButtonGroup.x = Width / 2
startOverButtonGroup.y = 100
GameoverGroup:insert(startOverButtonGroup)
startOverButton = display.newRoundedRect(startOverButtonGroup, 0, 0, 120, 70, 5)
startOverButtonShadow = display.newRoundedRect(startOverButtonGroup, startOverButton.x + 1, startOverButton.y + 1, startOverButton.width, startOverButton.height, 5)
startOverButtonShadow:setFillColor(0, 0, 0)
startOverButtonText = display.newText({
	parent = startOverButtonGroup,
	text = "Start Over",
	x = 0,
	y = 0,
	width = startOverButton.width,
	height = 25,
	font = "Arial",
	fontSize = 20,
	align = "center"
	})
startOverButtonText:setFillColor(0, 0, 0)
FallIn(startOverButtonGroup, lineHeight + 210, 0)

startOverButton:toFront()
startOverButtonText:toFront()

--startOverButton:addEventListener("touch", StartOver)


end

