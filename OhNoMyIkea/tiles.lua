
tileGroup = display.newGroup()

-- Settings and Variables
Tiles = {}
wallPlaceTimeStart = 0

-- Tile class
Tile = {}
Tile.__index = Tile
function Tile.new(mt, x, y, altColor, delay)
	local self = setmetatable({}, Tile)

	-- Attributes
	self.x = x
	self.y = y
	self.onFire = false
	self.furniture = ""
	self.furniturePlayer = 0
	self.reached = false

	-- Main Object
	self.Object = display.newRect(tileGroup, (x + 0.5) * tileSize, (y + 0.5) * tileSize, tileSize - 1, tileSize - 1)
	self.Object.strokeWidth = 2
	self.Object:setStrokeColor(0, 0, 0, 0)
	self.Object:setFillColor(0.35, 0.35, 0.35, 0.25)
	if altColor then
		self.Object:setFillColor(0.45, 0.45, 0.45, 0.2)
	end
	RotateIn(self.Object, delay)

	-- Sprite
	self.Sprite = nil

	-- Fire Object
	self.Fire = display.newImageRect(tileGroup, "images/fire.png", tileSize, tileSize)
	self.Fire.x = self.Object.x
	self.Fire.y = self.Object.y
	self.Fire.isVisible = false

	-- On tap
	self.Object:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end
		if outOfTimeGroup.isVisible then return end

		-- Place furniture
		if State == "Placing Furniture" then
			if SelectedFurniture ~= "" then
				PlaceFurniture(SelectedFurniture, x, y, self)
			end

		elseif State == "Gameplay" then
			placingWallGroup.isVisible = true
			placingWallGroup:toFront()
			timer.performWithDelay(20, function()
			successfullyPlacedWall = PlaceWall(x, y, CurrentWallDirection)

			-- Check if multi-tile wall blocked off fire
			local notBlocked = CheckWallsForBlockage()
			if not notBlocked then
				successfullyPlacedWall = false
				for i, wallIndex in ipairs(TryingToPlaceWallsIndexes) do
					Walls[#Walls].Object:removeSelf()
					table.remove(Walls)
				end
				native.showAlert("Can't do that!", "You can't completely block off the fire", {"Ok"})
			end
			TryingToPlaceWalls = false
			TryingToPlaceWallsIndexes = {}

			if successfullyPlacedWall then
				-- Next player
				CurrentPlayer = CurrentPlayer + 1
				currentPlayer.text = "Player " .. tostring(CurrentPlayer)
				currentPlayerShadow.text = currentPlayer.text

				-- Loop around to first player
				if CurrentPlayer > Players then
					CurrentPlayer = 1
					currentPlayer.text = "Player " .. tostring(CurrentPlayer)
					currentPlayerShadow.text = currentPlayer.text
					SpreadFire()
					CurrentRound = CurrentRound + 1
					roundDisplay.width = (Width - 100) / 15.0 * CurrentRound
					roundDisplayFiretruck.x = roundDisplay.width + roundDisplay.x

					if CurrentRound >= MaxRounds and State ~= "Game Over" then
						print("Game Over")
						ChangeState("Game Over")
					end

					-- Check if all furniture is burnt
					local allOnFire = true
					for i, furnIndex in ipairs(FurnitureTileIndexes) do
						local ran, err = pcall(function()
							if Tiles[furnIndex].furniture ~= "" and not Tiles[furnIndex].onFire then
								allOnFire = false
							end
						end)
						if not ran then print(err) end
					end
					if allOnFire then
						LoseGame = true
						ChangeState("Game Over")
					end
				end
				while PlayerEliminated[CurrentPlayer] do
					if State == "Game Over" then break end
					CurrentPlayer = CurrentPlayer + 1
					if CurrentPlayer > Players then
						CurrentPlayer = 1
						SpreadFire()
						CurrentRound = CurrentRound + 1
						roundDisplay.width = (Width - 100) / 15.0 * CurrentRound
						roundDisplayFiretruck.x = roundDisplay.width + roundDisplay.x

						if CurrentRound >= MaxRounds and State ~= "Game Over" then
							print("Game Over")
							ChangeState("Game Over")
						end

						-- Check if all furniture is burnt
						local allOnFire = true
						for i, furnIndex in ipairs(FurnitureTileIndexes) do
							if State == "Game Over" then break end
							if Tiles[furnIndex].furniture ~= "" and not Tiles[furnIndex].onFire then
								allOnFire = false
							end
						end
						if allOnFire then
							LoseGame = true
							ChangeState("Game Over")
						end
					end
					currentPlayer.text = "Player " .. tostring(CurrentPlayer)
					currentPlayerShadow.text = currentPlayer.text
				end

				-- Start timer
				wallPlaceTimeStart = system.getTimer()

				-- Change player display
				local c = PlayerColors[CurrentPlayer]
				currentPlayer:setFillColor(c.r, c.g, c.b)
			end
			placingWallGroup.isVisible = false
			end)
		end
	end)

	return self
end

-- Functions
function CreateGrid()
	gridSize = Players * 2 + 8
	tileSize = (Width - 65) / gridSize
	local isAltColor = true
	for i = 1, gridSize do
		isAltColor = not isAltColor
		for j = 1, gridSize do
			isAltColor = not isAltColor
			table.insert(Tiles, Tile:new(i, j, isAltColor, i * j * 3))
		end
	end
end

function GetTileAt(x, y)
	for i, tile in ipairs(Tiles) do
		if tile.x == x and tile.y == y then
			return tile
		end
	end
end

function PlaceFurniture(furniture, x, y, tile)
	if furniture == "Couch" then
		--[[local deltaX = 1
		if x == gridSize then deltaX = -1 end
		if tile.furniture ~= "" then return end
		if GetTileAt(x + deltaX, y).furniture ~= "" then return end
		tile.furniture = "Couch"
		tile.furniturePlayer = CurrentPlayer
		GetTileAt(x + deltaX, y).furniture = "Couch"
		GetTileAt(x + deltaX, y).furniturePlayer = CurrentPlayer
		tile.Object:setFillColor(0.5, 0.2, 0.05)
		GetTileAt(x + deltaX, y).Object:setFillColor(0.5, 0.2, 0.05)]]

	elseif furniture == "Side Table" then
		if tile.furniture ~= "" then return end
		tile.furniture = "Side Table"
		tile.furniturePlayer = CurrentPlayer

		tile.Sprite = display.newImageRect(tileGroup, "images/sidetable.png", tileSize, tileSize)
		tile.Sprite.x = tile.Object.x
		tile.Sprite.y = tile.Object.y
		tile.Sprite.alpha = 0
		tile.Sprite.xScale = 2
		tile.Sprite.yScale = 2
		transition.to(tile.Sprite, {
			time = 250,
			transition = easing.inOutSine,
			alpha = 1,
			xScale = 1,
			yScale = 1
		})

		local c = PlayerColors[CurrentPlayer]
		tile.Object:setFillColor(c.r, c.g, c.b, 0.3)
		tile.Fire:toFront()

	elseif furniture == "Coffee Table" then
		--print("placing coffee table at tile (" .. tostring(x) .. ", " .. tostring(y) .. ")")
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
