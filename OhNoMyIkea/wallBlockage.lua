
-- Start ant
local function StartAnt(coord)
	for i, tile in ipairs(Tiles) do
		tile.reached = tile.x == coord.x and tile.y == coord.y
	end
end

-- Spread ant
local function SpreadAnt()
	local reachTiles = {}
	for i, tile in ipairs(Tiles) do
		if tile.reached then
			if tile.x > 1 then
				if not GetTileAt(tile.x - 1, tile.y).reached then
					wallInBetween = false
					for j, wall in ipairs(Walls) do
						if wall.direction == "vertical" then
							if math.floor(wall.x) == tile.x - 1 and math.floor(wall.y) == tile.y then
								wallInBetween = true
							end
						end
					end
					if not wallInBetween then
						table.insert(reachTiles, GetTileAt(tile.x - 1, tile.y))
					end
				end
			end
			if tile.x < gridSize then
				if not GetTileAt(tile.x + 1, tile.y).reached then
					wallInBetween = false
					for j, wall in ipairs(Walls) do
						if wall.direction == "vertical" then
							if math.floor(wall.x) == tile.x and math.floor(wall.y) == tile.y then
								wallInBetween = true
							end
						end
					end
					if not wallInBetween then
						table.insert(reachTiles, GetTileAt(tile.x + 1, tile.y))
					end
				end
			end
			if tile.y < gridSize then
				if not GetTileAt(tile.x, tile.y + 1).reached then
					wallInBetween = false
					for j, wall in ipairs(Walls) do
						if wall.direction == "horizontal" then
							if math.floor(wall.x) == tile.x and math.floor(wall.y) == tile.y then
								wallInBetween = true
							end
						end
					end
					if not wallInBetween then
						table.insert(reachTiles, GetTileAt(tile.x, tile.y + 1))
					end
				end
			end
			if tile.y > 1 then
				if not GetTileAt(tile.x, tile.y - 1).reached then
					wallInBetween = false
					for j, wall in ipairs(Walls) do
						if wall.direction == "horizontal" then
							if math.floor(wall.x) == tile.x and math.floor(wall.y) == tile.y - 1 then
								wallInBetween = true
							end
						end
					end
					if not wallInBetween then
						table.insert(reachTiles, GetTileAt(tile.x, tile.y - 1))
					end
				end
			end
		end
	end

	for i, tile in ipairs(reachTiles) do
		if not tile.reached then
			tile.reached = true
		end
		if tile.onFire then
			return true
		end
	end

	-- Didn't reach fire...
	return false
end

function CheckWallsForBlockage()
	furnitureTileCoordinates = {}

	for i, tile in ipairs(Tiles) do
		if tile.furniture ~= "" then
			table.insert(furnitureTileCoordinates, {x = tile.x, y = tile.y})
		end
	end

	for i, coord in ipairs(furnitureTileCoordinates) do
		thisTileCanReachFire = false
		StartAnt(coord)
		for i = 1, gridSize * gridSize do
			local reachedFire = SpreadAnt()
			if reachedFire then
				thisTileCanReachFire = true
				break
			end
		end
		if not thisTileCanReachFire then
			return false
		end
	end

	return true
end
