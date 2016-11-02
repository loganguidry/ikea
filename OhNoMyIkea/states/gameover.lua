
GameoverGroup = display.newGroup()

local lineHeight = Height - 370

--[[local function StartOver(event)
	ChangeState("Player Select")
	GameoverGroup:removeSelf()
	GameoverGroup = display.newGroup()
	PlayerScores = {0, 0, 0, 0}
	Players = 2
	CurrentPlayer = 1
	SelectedFurniture = ""
	CurrentWallDirection = 0
	RotateHoverWallDisplay()
	CurrentRound = 1
	roundDisplay.width = (Width - 100) / 15.0 * CurrentRound
	roundDisplayFiretruck.x = roundDisplay.width + roundDisplay.x
	PlayerEliminated = {
		false, false, false, false
	}
	PlayerScores = {0, 0, 0, 0}
	LoseGame = false
end]]


function displayGameOverScreen()

GameoverGroup = display.newGroup()

local gameOverTxt = "The Firetruck is Here!"
if LoseGame then
	gameOverTxt = "All your furniture burnt!"
end

gameOverHeadline = display.newText({
	parent = GameoverGroup,
	text = gameOverTxt,
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

playerOne = display.newText({
	parent = GameoverGroup,
	text = "Player 1 Saved: $" .. tostring(PlayerScores[1]),
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
	text = "Player 2 Saved: $" .. tostring(PlayerScores[2]),
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
	text = "Player 3 Saved: $" .. tostring(PlayerScores[3]),
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
	text = "Player 3 Saved: $" .. tostring(PlayerScores[3]),
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
	text = "Player 4 Saved: $" .. tostring(PlayerScores[4]),
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

-- calculate the winner
local maxScore = 0
local winners = {}
for i, score in ipairs(PlayerScores) do
	if Players >= i then
		if score > maxScore then
			for i = 1, #winners do
				table.remove(winners)
			end
			table.insert(winners, i)
			maxScore = score
		elseif score == maxScore and score > 0 then
			table.insert(winners, i)
		end
	end
end

local winText = "Winner:"
local theresAwinner = false
for i, winner in ipairs(winners) do
	print(winner)
	if winner ~= 0 then
		theresAwinner = true
		winText = winText .. " Player " .. tostring(winner) .. ","
	end
end
if winText == "Winners:" or maxScore == 0 then
	winText = "Nobody Wins!"
	theresAwinner = false
end
if theresAwinner then
	winText = winText:sub(1, -2)
end

winnerPlayerText = display.newText({
	parent = GameoverGroup,
	text = winText,
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

--[[---------- BUTTON ----------------
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

startOverButton:addEventListener("touch", StartOver)]]

startOverText = display.newText({
	parent = GameoverGroup,
	text = "Press CMD+R to Play Again!",
	x = Width / 2,
	y = lineHeight + 280,
	width = Width,
	height = 40,
	font = "Arial",
	fontSize = 28,
	align = "center"
})
startOverText:setFillColor(1, 0.25, 0.25)
startOverTextShadow = display.newText({
	parent = GameoverGroup,
	text = startOverText.text,
	x = startOverText.x + 1,
	y = startOverText.y + 1,
	width = startOverText.width,
	height = startOverText.height,
	font = "Arial",
	fontSize = 28,
	align = "center"
})
startOverTextShadow:setFillColor(0)
startOverText:toFront()
FallIn(startOverText, lineHeight + 200, 0)
FallIn(startOverTextShadow, lineHeight + 201, 0)

end

