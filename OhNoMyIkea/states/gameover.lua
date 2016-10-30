
-- OBJECTS
GameoverGroup = display.newGroup()
GameoverGroup.isVisible = false

gameOverHeadline = display.newText({
	parent = GameoverGroup,
	text = "The firetruck is here!",
	x = Width / 2,
	y = Height - 570,
	width = Width,
	height = 35,
	font = "Arial",
	fontSize = 40,
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
	fontSize = 40,
	align = "center"
})
gameOverHeadlineShadow:setFillColor(0)
gameOverHeadline:toFront()

playerOne = display.newText({
	parent = GameoverGroup,
	text = "Player 1 Saved: $",
	x = 280,
	y = Height - 470,
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
	y = Height - 440,
	width = Width,
	height = 25,
	font = "Arial",
	fontSize = 20,
})
playerTwo:setFillColor(0)
playerTwo:toFront()


print(Player == 3)

if Players == 3 then
	playerThree = display.newText({
	parent = GameoverGroup,
	text = "Player 3 Saved: $",
	x = 280,
	y = Height - 410,
	width = Width,
	height = 25,
	font = "Arial",
	fontSize = 20,
})
playerThree:setFillColor(0)
playerThree:toFront()
end


if Players == 4 then
	playerThree = display.newText({
	parent = GameoverGroup,
	text = "Player 3 Saved: $",
	x = 280,
	y = Height - 410,
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
	y = Height - 380,
	width = Width,
	height = 25,
	font = "Arial",
	fontSize = 20,
	align = "left"
})
playerFour:setFillColor(0)
playerFour:toFront()
end

