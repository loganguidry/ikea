
placingWallGroup = display.newGroup()
placingWallGroup.x = Width / 2
placingWallGroup.y = Height / 2
placingWallGroup.isVisible = false
GameplayGroup:insert(placingWallGroup)
local placingWallBG = display.newRect(placingWallGroup, 0, 0, Width, Height)
placingWallBG:setFillColor(0, 0, 0, 0.15)
local placingWallText = display.newText({
	parent = placingWallGroup,
	text = "Placing wall, please wait...",
	x = 0,
	y = 0,
	width = Width - 24,
	height = 40,
	font = "Arial",
	fontSize = 32,
	align = "center"
})
local placingWallTextShadow = display.newText({
	parent = placingWallGroup,
	text = placingWallText.text,
	x = placingWallText.x + 1,
	y = placingWallText.y + 1,
	width = placingWallText.width,
	height = placingWallText.height,
	font = "Arial",
	fontSize = 32,
	align = "center"
})
placingWallTextShadow:setFillColor(0)
placingWallText:toFront()