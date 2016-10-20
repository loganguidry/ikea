
HoverTooltip = {}

HoverTooltip.Group = display.newGroup()
HoverTooltip.Group.anchorX = 0
HoverTooltip.Group.anchorY = 0
HoverTooltip.Group.isVisible = false

HoverTooltip.HeaderShadow = display.newText({
	parent = HoverTooltip.Group,
	text = "Testing tooltip",
	x = 20,
	y = -20,
	width = Width,
	height = Height,
	font = "Arial",
	fontSize = 20,
	align = "left"
})
HoverTooltip.HeaderShadow.anchorX = 0
HoverTooltip.HeaderShadow.anchorY = 0
HoverTooltip.HeaderShadow:setFillColor(0)
HoverTooltip.Header = display.newText({
	parent = HoverTooltip.Group,
	text = HoverTooltip.HeaderShadow.text,
	x = HoverTooltip.HeaderShadow.x - 1,
	y = HoverTooltip.HeaderShadow.y - 1,
	width = HoverTooltip.HeaderShadow.width,
	height = HoverTooltip.HeaderShadow.height,
	font = "Arial",
	fontSize = 20,
	align = "left"
})
HoverTooltip.Header.anchorX = 0
HoverTooltip.Header.anchorY = 0
HoverTooltip.Header:toFront()
