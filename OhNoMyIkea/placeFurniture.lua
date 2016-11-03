function PlaceFurniture(furniture, x, y, tile)
	if tile.furniture ~= "" then return end

	local placeTiles = {}
	if furniture == "Side Table" then
		placeTiles = { {x = x, y = y, image = "images/sidetable.png"} }

	elseif furniture == "TV Stand" then
		if furnitureRotation == 0 then
			placeTiles = {
				{x = x, y = y, image = "images/tv/2.png"},
				{x = x, y = y - 1, image = "images/tv/1.png"}
			}
		elseif furnitureRotation == 90 then
			placeTiles = {
				{x = x, y = y, image = "images/tv/2.png"},
				{x = x + 1, y = y, image = "images/tv/1.png"}
			}
		elseif furnitureRotation == 180 then
			placeTiles = {
				{x = x, y = y, image = "images/tv/2.png"},
				{x = x, y = y + 1, image = "images/tv/1.png"}
			}
		elseif furnitureRotation == 270 then
			placeTiles = {
				{x = x, y = y, image = "images/tv/2.png"},
				{x = x - 1, y = y, image = "images/tv/1.png"}
			}
		end

	elseif furniture == "Bed" then
		if furnitureRotation == 0 then
			placeTiles = {
				{x = x, y = y, image = "images/bed/3.png"},
				{x = x, y = y - 1, image = "images/bed/2.png"},
				{x = x - 1, y = y - 1, image = "images/bed/1.png"},
				{x = x - 1, y = y, image = "images/bed/4.png"}
			}
		elseif furnitureRotation == 90 then
			placeTiles = {
				{x = x, y = y, image = "images/bed/3.png"},
				{x = x + 1, y = y, image = "images/bed/2.png"},
				{x = x, y = y - 1, image = "images/bed/4.png"},
				{x = x + 1, y = y - 1, image = "images/bed/1.png"}
			}
		elseif furnitureRotation == 180 then
			placeTiles = {
				{x = x, y = y, image = "images/bed/3.png"},
				{x = x + 1, y = y, image = "images/bed/4.png"},
				{x = x, y = y + 1, image = "images/bed/2.png"},
				{x = x + 1, y = y + 1, image = "images/bed/1.png"}
			}
		elseif furnitureRotation == 270 then
			placeTiles = {
				{x = x, y = y, image = "images/bed/3.png"},
				{x = x - 1, y = y + 1, image = "images/bed/1.png"},
				{x = x, y = y + 1, image = "images/bed/4.png"},
				{x = x - 1, y = y, image = "images/bed/2.png"}
			}
		end

	elseif furniture == "Kitchen Island" then
		if furnitureRotation == 0 then
			placeTiles = {
				{x = x, y = y - 1, image = "images/island/1.png"},
				{x = x, y = y, image = "images/island/2.png"},
				{x = x, y = y + 1, image = "images/island/3.png"}
			}
		elseif furnitureRotation == 90 then
			placeTiles = {
				{x = x + 1, y = y, image = "images/island/1.png"},
				{x = x, y = y, image = "images/island/2.png"},
				{x = x - 1, y = y, image = "images/island/3.png"}
			}
		elseif furnitureRotation == 180 then
			placeTiles = {
				{x = x, y = y - 1, image = "images/island/3.png"},
				{x = x, y = y, image = "images/island/2.png"},
				{x = x, y = y + 1, image = "images/island/1.png"}
			}
		elseif furnitureRotation == 270 then
			placeTiles = {
				{x = x + 1, y = y, image = "images/island/3.png"},
				{x = x, y = y, image = "images/island/2.png"},
				{x = x - 1, y = y, image = "images/island/1.png"}
			}
		end

	elseif furniture == "Couch" then
		if furnitureRotation == 0 then
			placeTiles = {
				{x = x - 1, y = y - 2, image = "images/couch/1.png"},
				{x = x - 1, y = y - 1, image = "images/couch/2.png"},
				{x = x - 1, y = y, image = "images/couch/3.png"},
				{x = x, y = y, image = "images/couch/4.png"},
				{x = x, y = y - 1, image = "images/couch/5.png"},
				{x = x, y = y - 2, image = "images/couch/6.png"}
			}
		elseif furnitureRotation == 90 then
			placeTiles = {
				{x = x + 2, y = y - 1, image = "images/couch/1.png"},
				{x = x + 1, y = y - 1, image = "images/couch/2.png"},
				{x = x, y = y - 1, image = "images/couch/3.png"},
				{x = x, y = y, image = "images/couch/4.png"},
				{x = x + 1, y = y, image = "images/couch/5.png"},
				{x = x + 2, y = y, image = "images/couch/6.png"}
			}
		elseif furnitureRotation == 180 then
			placeTiles = {
				{x = x + 1, y = y + 2, image = "images/couch/1.png"},
				{x = x + 1, y = y + 1, image = "images/couch/2.png"},
				{x = x + 1, y = y, image = "images/couch/3.png"},
				{x = x, y = y, image = "images/couch/4.png"},
				{x = x, y = y + 1, image = "images/couch/5.png"},
				{x = x, y = y + 2, image = "images/couch/6.png"}
			}
		elseif furnitureRotation == 270 then
			placeTiles = {
				{x = x - 2, y = y + 1, image = "images/couch/1.png"},
				{x = x - 1, y = y + 1, image = "images/couch/2.png"},
				{x = x, y = y + 1, image = "images/couch/3.png"},
				{x = x, y = y, image = "images/couch/4.png"},
				{x = x - 1, y = y, image = "images/couch/5.png"},
				{x = x - 2, y = y, image = "images/couch/6.png"}
			}
		end
	end

	-- Check if this can be placed here
	local canPlace = true
	for i, tileInfo in ipairs(placeTiles) do
		local thisTile = GetTileAt(tileInfo.x, tileInfo.y)
		if thisTile == nil then
			canPlace = false
		elseif thisTile.furniture ~= "" then
			canPlace = false
		end
	end
	if not canPlace then return end

	-- Place furniture here
	for i, tileInfo in ipairs(placeTiles) do
		-- Get the tile at this location
		local thisTile = GetTileAt(tileInfo.x, tileInfo.y)

		-- Set the furniture info
		thisTile.furniture = furniture
		thisTile.furniturePlayer = CurrentPlayer

		-- Add sprite
		thisTile.Sprite = display.newImageRect(tileGroup, tileInfo.image, tileSize, tileSize)
		thisTile.Sprite.x = thisTile.Object.x
		thisTile.Sprite.y = thisTile.Object.y
		thisTile.Sprite.alpha = 0
		thisTile.Sprite.xScale = 2
		thisTile.Sprite.yScale = 2
		transition.to(thisTile.Sprite, {
			time = 250,
			transition = easing.inOutSine,
			alpha = 1,
			xScale = 1,
			yScale = 1
		})
		thisTile.Sprite.rotation = furnitureRotation

		-- Connect to all the tiles this furniture is placed on
		thisTile.allFurniturePositions = {}
		for j, tileInfo2 in ipairs(placeTiles) do
			table.insert(thisTile.allFurniturePositions, {x = tileInfo2.x, y = tileInfo2.y})
		end

		-- Set the tile color
		local c = PlayerColors[CurrentPlayer]
		thisTile.Object:setFillColor(c.r, c.g, c.b, 0.3)
		thisTile.Sprite:setFillColor(c.r + 0.9, c.g + 0.9, c.b + 0.9)
		thisTile.Fire:toFront()
	end

	-- Move on to next player
	PlayerFurnitures[CurrentPlayer] = PlayerFurnitures[CurrentPlayer] + 1
	if PlayerFurnitures[CurrentPlayer] >= 3 then
		CurrentPlayer = CurrentPlayer + 1
		currentPlayer.text = "Player " .. tostring(CurrentPlayer)
		currentPlayerShadow.text = currentPlayer.text
		if CurrentPlayer > Players then
			CurrentPlayer = 1
			currentPlayer.text = "Player " .. tostring(CurrentPlayer)
			currentPlayerShadow.text = currentPlayer.text
			ChangeState("Gameplay")
		end
		local c = PlayerColors[CurrentPlayer]
		currentPlayer:setFillColor(c.r, c.g, c.b)
	end

	-- Add to furniture list
	local tileIndex = -1
	for i, tile in ipairs(Tiles) do
		if tile.x == x and tile.y == y then
			tileIndex = i
		end
	end
	table.insert(FurnitureTileIndexes, tileIndex)

	-- Play sound effect
	audio.play(Sounds["Place Furniture"])
end