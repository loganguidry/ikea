
-- Variables:
WallKindIndex = 1
WallKinds = {"single", "double", "corner", "l-shape", "l-shape reverse", "u-shape", "zigzag", "zigzag reverse"}

function PlaceNewWall(kind, x, y, rot)
	if kind == "single" then
		if rot == 0 then
			if CanPlaceWallAt(x, y, "horizontal") then
				PutDownNewWall(x, y, "horizontal")
				return true
			end
		elseif rot == 90 then
			if CanPlaceWallAt(x, y, "vertical") then
				PutDownNewWall(x, y, "vertical")
				return true
			end
		elseif rot == 180 then
			if CanPlaceWallAt(x, y - 1, "horizontal") then
				PutDownNewWall(x, y - 1, "horizontal")
				return true
			end
		elseif rot == 270 then
			if CanPlaceWallAt(x - 1, y, "vertical") then
				PutDownNewWall(x - 1, y, "vertical")
				return true
			end
		end

	elseif kind == "double" then
		if rot == 0 then
			if CanPlaceWallAt(x, y, "horizontal") and CanPlaceWallAt(x + 1, y, "horizontal") then
				PutDownNewWall(x, y, "horizontal")
				PutDownNewWall(x + 1, y, "horizontal")
				return true
			end
		elseif rot == 90 then
			if CanPlaceWallAt(x, y, "vertical") and CanPlaceWallAt(x, y + 1, "vertical") then
				PutDownNewWall(x, y, "vertical")
				PutDownNewWall(x, y + 1, "vertical")
				return true
			end
		elseif rot == 180 then
			if CanPlaceWallAt(x, y - 1, "horizontal") and CanPlaceWallAt(x - 1, y - 1, "horizontal") then
				PutDownNewWall(x, y - 1, "horizontal")
				PutDownNewWall(x - 1, y - 1, "horizontal")
				return true
			end
		elseif rot == 270 then
			if CanPlaceWallAt(x - 1, y, "vertical") and CanPlaceWallAt(x - 1, y - 1, "vertical") then
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x - 1, y - 1, "vertical")
				return true
			end
		end

	elseif kind == "corner" then
		if rot == 0 then
			if CanPlaceWallAt(x, y, "horizontal") and CanPlaceWallAt(x - 1, y, "vertical") then
				PutDownNewWall(x, y, "horizontal")
				PutDownNewWall(x - 1, y, "vertical")
				return true
			end
		elseif rot == 90 then
			if CanPlaceWallAt(x + 1, y - 1, "horizontal") and CanPlaceWallAt(x, y, "vertical") then
				PutDownNewWall(x + 1, y - 1, "horizontal")
				PutDownNewWall(x, y, "vertical")
				return true
			end
		elseif rot == 180 then
			if CanPlaceWallAt(x, y - 1, "horizontal") and CanPlaceWallAt(x, y, "vertical") then
				PutDownNewWall(x, y - 1, "horizontal")
				PutDownNewWall(x, y, "vertical")
				return true
			end
		elseif rot == 270 then
			if CanPlaceWallAt(x - 1, y, "horizontal") and CanPlaceWallAt(x - 1, y, "vertical") then
				PutDownNewWall(x - 1, y, "horizontal")
				PutDownNewWall(x - 1, y, "vertical")
				return true
			end
		end

	elseif kind == "l-shape" then
		if rot == 0 then
			if CanPlaceWallAt(x, y, "horizontal") and CanPlaceWallAt(x + 1, y, "horizontal") and CanPlaceWallAt(x - 1, y, "vertical") then
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x, y, "horizontal")
				PutDownNewWall(x + 1, y, "horizontal")
				return true
			end
		elseif rot == 90 then
			if CanPlaceWallAt(x, y, "vertical") and CanPlaceWallAt(x, y + 1, "vertical") and CanPlaceWallAt(x + 1, y - 1, "horizontal") then
				PutDownNewWall(x, y, "vertical")
				PutDownNewWall(x, y + 1, "vertical")
				PutDownNewWall(x + 1, y - 1, "horizontal")
				return true
			end
		elseif rot == 180 then
			if CanPlaceWallAt(x, y, "vertical") and CanPlaceWallAt(x, y - 1, "horizontal") and CanPlaceWallAt(x - 1, y - 1, "horizontal") then
				PutDownNewWall(x, y, "vertical")
				PutDownNewWall(x, y - 1, "horizontal")
				PutDownNewWall(x - 1, y - 1, "horizontal")
				return true
			end
		elseif rot == 270 then
			if CanPlaceWallAt(x - 1, y, "horizontal") and CanPlaceWallAt(x - 1, y, "vertical") and CanPlaceWallAt(x - 1, y - 1, "vertical") then
				PutDownNewWall(x - 1, y, "horizontal")
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x - 1, y - 1, "vertical")
				return true
			end
		end

	elseif kind == "l-shape reverse" then
		if rot == 0 then
			if CanPlaceWallAt(x, y, "horizontal") and CanPlaceWallAt(x + 1, y, "horizontal") and CanPlaceWallAt(x - 1, y, "vertical") then
				PutDownNewWall(x - 1, y + 1, "vertical")
				PutDownNewWall(x, y, "horizontal")
				PutDownNewWall(x + 1, y, "horizontal")
				return true
			end
		elseif rot == 90 then
			if CanPlaceWallAt(x, y, "vertical") and CanPlaceWallAt(x, y + 1, "vertical") and CanPlaceWallAt(x + 1, y - 1, "horizontal") then
				PutDownNewWall(x, y, "vertical")
				PutDownNewWall(x, y + 1, "vertical")
				PutDownNewWall(x, y - 1, "horizontal")
				return true
			end
		elseif rot == 180 then
			if CanPlaceWallAt(x, y - 1, "vertical") and CanPlaceWallAt(x, y - 1, "horizontal") and CanPlaceWallAt(x - 1, y - 1, "horizontal") then
				PutDownNewWall(x, y - 1, "vertical")
				PutDownNewWall(x, y - 1, "horizontal")
				PutDownNewWall(x - 1, y - 1, "horizontal")
				return true
			end
		elseif rot == 270 then
			if CanPlaceWallAt(x, y, "horizontal") and CanPlaceWallAt(x - 1, y, "vertical") and CanPlaceWallAt(x - 1, y - 1, "vertical") then
				PutDownNewWall(x, y, "horizontal")
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x - 1, y - 1, "vertical")
				return true
			end
		end

	elseif kind == "u-shape" then
		if rot == 0 then
			if CanPlaceWallAt(x, y, "horizontal") and CanPlaceWallAt(x - 1, y, "vertical") and CanPlaceWallAt(x, y, "vertical") then
				PutDownNewWall(x, y, "horizontal")
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x, y, "vertical")
				return true
			end
		elseif rot == 90 then
			if CanPlaceWallAt(x, y, "vertical") and CanPlaceWallAt(x + 1, y, "horizontal") and CanPlaceWallAt(x + 1, y - 1, "horizontal") then
				PutDownNewWall(x, y, "vertical")
				PutDownNewWall(x + 1, y, "horizontal")
				PutDownNewWall(x + 1, y - 1, "horizontal")
				return true
			end
		elseif rot == 180 then
			if CanPlaceWallAt(x, y, "horizontal") and CanPlaceWallAt(x - 1, y, "vertical") and CanPlaceWallAt(x, y, "vertical") then
				PutDownNewWall(x, y - 1, "horizontal")
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x, y, "vertical")
				return true
			end
		elseif rot == 270 then
			if CanPlaceWallAt(x - 1, y, "vertical") and CanPlaceWallAt(x - 1, y, "horizontal") and CanPlaceWallAt(x - 1, y - 1, "horizontal") then
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x - 1, y, "horizontal")
				PutDownNewWall(x - 1, y - 1, "horizontal")
				return true
			end
		end

	elseif kind == "zigzag" then
		if rot == 0 then
			if CanPlaceWallAt(x, y, "horizontal") and CanPlaceWallAt(x, y, "vertical") and CanPlaceWallAt(x + 1, y - 1, "horizontal") then
				PutDownNewWall(x, y, "horizontal")
				PutDownNewWall(x, y, "vertical")
				PutDownNewWall(x + 1, y - 1, "horizontal")
				return true
			end
		elseif rot == 90 then
			if CanPlaceWallAt(x, y, "vertical") and CanPlaceWallAt(x + 1, y, "horizontal") and CanPlaceWallAt(x + 1, y + 1, "vertical") then
				PutDownNewWall(x, y, "vertical")
				PutDownNewWall(x + 1, y, "horizontal")
				PutDownNewWall(x + 1, y + 1, "vertical")
				return true
			end
		elseif rot == 180 then
			if CanPlaceWallAt(x - 1, y, "vertical") and CanPlaceWallAt(x, y - 1, "horizontal") and CanPlaceWallAt(x - 1, y, "horizontal") then
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x, y - 1, "horizontal")
				PutDownNewWall(x - 1, y, "horizontal")
				return true
			end
		elseif rot == 270 then
			if CanPlaceWallAt(x - 1, y, "vertical") and CanPlaceWallAt(x - 1, y - 1, "horizontal") and CanPlaceWallAt(x - 2, y - 1, "vertical") then
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x - 1, y - 1, "horizontal")
				PutDownNewWall(x - 2, y - 1, "vertical")
				return true
			end
		end

	elseif kind == "zigzag reverse" then
		if rot == 0 then
			if CanPlaceWallAt(x, y, "vertical") and CanPlaceWallAt(x, y - 1, "horizontal") and CanPlaceWallAt(x + 1, y, "horizontal") then
				PutDownNewWall(x, y, "vertical")
				PutDownNewWall(x, y - 1, "horizontal")
				PutDownNewWall(x + 1, y, "horizontal")
				return true
			end
		elseif rot == 90 then
			if CanPlaceWallAt(x + 1, y, "vertical") and CanPlaceWallAt(x + 1, y, "horizontal") and CanPlaceWallAt(x, y + 1, "vertical") then
				PutDownNewWall(x + 1, y, "vertical")
				PutDownNewWall(x + 1, y, "horizontal")
				PutDownNewWall(x, y + 1, "vertical")
				return true
			end
		elseif rot == 180 then
			if CanPlaceWallAt(x, y, "vertical") and CanPlaceWallAt(x - 1, y, "vertical") and CanPlaceWallAt(x - 1, y - 1, "horizontal") then
				PutDownNewWall(x, y, "horizontal")
				PutDownNewWall(x - 1, y, "vertical")
				PutDownNewWall(x - 1, y - 1, "horizontal")
				return true
			end
		elseif rot == 270 then
			if CanPlaceWallAt(x - 2, y, "vertical") and CanPlaceWallAt(x - 1, y - 1, "horizontal") and CanPlaceWallAt(x - 1, y - 1, "vertical") then
				PutDownNewWall(x - 2, y, "vertical")
				PutDownNewWall(x - 1, y - 1, "horizontal")
				PutDownNewWall(x - 1, y - 1, "vertical")
				return true
			end
		end

	else
		print("[ERROR in placingWalls.lua PlaceNewWall()] " .. tostring(kind) .. " isn't a valid wall type!")
	end

	-- Couldn't place wall
	return false
end

function CanPlaceWallAt(x, y, rot)
	-- Set wall position
	if rot == "vertical" then x = x + 0.5
	else y = y + 0.5 end

	-- Check if there is already a wall in this spot
	for i, wall in ipairs(Walls) do
		if x == wall.x and y == wall.y and rot == wall.direction then
			return false
		end
	end

	-- Check if the wall blocks off the fire
	local tempWall = Wall:new(x, y, rot)
	table.insert(Walls, tempWall)
	local accessible = CheckWallsForBlockage()
	tempWall.Object:removeSelf()
	table.remove(Walls)
	if not accessible then
		native.showAlert("Can't do that!", "You can't completely block off the fire", {"Ok"})
		return false
	end

	-- The wall passed all the tests, so it can be placed in this spot
	return true
end

function PutDownNewWall(x, y, rot)
	-- Set wall position
	if rot == "vertical" then x = x + 0.5
	else y = y + 0.5 end

	-- Create wall
	table.insert(Walls, Wall:new(x, y, rot))
end