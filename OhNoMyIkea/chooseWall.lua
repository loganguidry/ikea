
function SelectNewWall(kind)
	-- Find index
	WallKindIndex = -1
	for i, wallKind in ipairs(WallKinds) do
		if wallKind == kind then
			WallKindIndex = i
			break
		end
	end
	if WallKindIndex == -1 then
		print("[ERROR] " .. tostring(kind) .. " isn't a valid wall type")
		return
	end

	-- Update wall display
	HoverWallDisplay:removeSelf()
	HoverWallDisplay = display.newGroup()
	HoverWallDisplay.anchorX = 0
	HoverWallDisplay.anchorY = 0
	HoverWallDisplay.x = MousePosition.x
	HoverWallDisplay.y = MousePosition.y

	if WallKinds[WallKindIndex] == "single" then
		local HoverWallDisplayLine = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
		HoverWallDisplayLine.strokeWidth = 4
		HoverWallDisplayLine:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
	elseif WallKinds[WallKindIndex] == "double" then
		local HoverWallDisplayLine = display.newLine(HoverWallDisplay, 0, 0, tileSize * 2, 0)
		HoverWallDisplayLine.strokeWidth = 4
		HoverWallDisplayLine:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
	elseif WallKinds[WallKindIndex] == "corner" then
		local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
		HoverWallDisplayLine1.strokeWidth = 4
		HoverWallDisplayLine1:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, 0, -tileSize, 0, 0)
		HoverWallDisplayLine2.strokeWidth = 4
		HoverWallDisplayLine2:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
	elseif WallKinds[WallKindIndex] == "l-shape" then
		local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
		HoverWallDisplayLine1.strokeWidth = 4
		HoverWallDisplayLine1:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, 0, tileSize * 2, 0)
		HoverWallDisplayLine2.strokeWidth = 4
		HoverWallDisplayLine2:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, 0, -tileSize, 0, 0)
		HoverWallDisplayLine3.strokeWidth = 4
		HoverWallDisplayLine3:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
	elseif WallKinds[WallKindIndex] == "l-shape reverse" then
		local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
		HoverWallDisplayLine1.strokeWidth = 4
		HoverWallDisplayLine1:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, 0, tileSize * 2, 0)
		HoverWallDisplayLine2.strokeWidth = 4
		HoverWallDisplayLine2:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, 0, 0, 0, tileSize)
		HoverWallDisplayLine3.strokeWidth = 4
		HoverWallDisplayLine3:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
	elseif WallKinds[WallKindIndex] == "u-shape" then
		local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
		HoverWallDisplayLine1.strokeWidth = 4
		HoverWallDisplayLine1:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, -tileSize, tileSize, 0)
		HoverWallDisplayLine2.strokeWidth = 4
		HoverWallDisplayLine2:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, 0, -tileSize, 0, 0)
		HoverWallDisplayLine3.strokeWidth = 4
		HoverWallDisplayLine3:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
	elseif WallKinds[WallKindIndex] == "zigzag" then
		local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, 0, tileSize, 0)
		HoverWallDisplayLine1.strokeWidth = 4
		HoverWallDisplayLine1:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, -tileSize, tileSize, 0)
		HoverWallDisplayLine2.strokeWidth = 4
		HoverWallDisplayLine2:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, tileSize, -tileSize, tileSize * 2, -tileSize)
		HoverWallDisplayLine3.strokeWidth = 4
		HoverWallDisplayLine3:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
	elseif WallKinds[WallKindIndex] == "zigzag reverse" then
		local HoverWallDisplayLine1 = display.newLine(HoverWallDisplay, 0, -tileSize, tileSize, -tileSize)
		HoverWallDisplayLine1.strokeWidth = 4
		HoverWallDisplayLine1:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine2 = display.newLine(HoverWallDisplay, tileSize, -tileSize, tileSize, 0)
		HoverWallDisplayLine2.strokeWidth = 4
		HoverWallDisplayLine2:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
		local HoverWallDisplayLine3 = display.newLine(HoverWallDisplay, tileSize, 0, tileSize * 2, 0)
		HoverWallDisplayLine3.strokeWidth = 4
		HoverWallDisplayLine3:setStrokeColor(62.0 / 255, 124.0 / 255, 247.0 / 255)
	end
	HoverWallDisplay:toFront()

	-- Rotate wall display
	CurrentWallDirection = 0
	RotateHoverWallDisplay()
end