
outOfTimeGroup = display.newGroup()
outOfTimeGroup.x = Width / 2
outOfTimeGroup.y = Height / 2
outOfTimeGroup.isVisible = false
local outtaTimeBG = display.newRect(outOfTimeGroup, 0, 0, Width, Height)
outtaTimeBG:setFillColor(0, 0, 0, 0.15)
local outtaTimeText = display.newText({
	parent = outOfTimeGroup,
	text = "Out of time! Next player's turn...",
	x = 0,
	y = 0,
	width = Width - 24,
	height = 40,
	font = "Arial",
	fontSize = 32,
	align = "center"
})
local outtaTimeTextShadow = display.newText({
	parent = outOfTimeGroup,
	text = outtaTimeText.text,
	x = outtaTimeText.x + 1,
	y = outtaTimeText.y + 1,
	width = outtaTimeText.width,
	height = outtaTimeText.height,
	font = "Arial",
	fontSize = 32,
	align = "center"
})
outtaTimeTextShadow:setFillColor(0)
outtaTimeText:toFront()