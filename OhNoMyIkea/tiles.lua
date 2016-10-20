
-- Settings and Variables
Tiles = {}

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
	self.Object = display.newRect((x + 0.5) * tileSize, (y + 0.5) * tileSize, tileSize - 1, tileSize - 1)
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
	self.Fire = display.newImageRect("images/fire.png", tileSize, tileSize)
	self.Fire.x = self.Object.x
	self.Fire.y = self.Object.y
	self.Fire.isVisible = false

	-- On tap
	self.Object:addEventListener("touch", function(e)
		if e.phase ~= "began" then return end

		-- Place furniture
		if State == "Placing Furniture" then
			if SelectedFurniture ~= "" then
				PlaceFurniture(SelectedFurniture, x, y, self)
			end

		elseif State == "Gameplay" then
			successfullyPlacedWall = PlaceWall(x, y, CurrentWallDirection)
			if successfullyPlacedWall then
				CurrentPlayer = CurrentPlayer + 1
				currentPlayer.text = "Player " .. tostring(CurrentPlayer)
				currentPlayerShadow.text = currentPlayer.text
				if CurrentPlayer > Players then
					CurrentPlayer = 1
					currentPlayer.text = "Player " .. tostring(CurrentPlayer)
					currentPlayerShadow.text = currentPlayer.text
					SpreadFire()
					CurrentRound = CurrentRound + 1
					roundDisplay.text = "Round " .. tostring(CurrentRound)
					if CurrentRound >= MaxRounds and State ~= "Game Over" then
						ChangeState("Game Over")
					end
				end
				while PlayerEliminated[CurrentPlayer] do
					local allEliminated = true
					for i, elim in ipairs(PlayerEliminated) do
						if not elim then
							allEliminated = false
						end
					end
					if allEliminated or State == "Game Over" then break end
					CurrentPlayer = CurrentPlayer + 1
					if CurrentPlayer > Players then
						CurrentPlayer = 1
						SpreadFire()
						CurrentRound = CurrentRound + 1
						roundDisplay.text = "Round " .. tostring(CurrentRound)
						if CurrentRound >= MaxRounds and State ~= "Game Over" then
							ChangeState("Game Over")
						end
					end
					currentPlayer.text = "Player " .. tostring(CurrentPlayer)
					currentPlayerShadow.text = currentPlayer.text
				end

				-- Change player display
				local c = PlayerColors[CurrentPlayer]
				currentPlayer:setFillColor(c.r, c.g, c.b)
			end
			
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
		local deltaX = 1
		if x == gridSize then deltaX = -1 end
		if tile.furniture ~= "" then return end
		if GetTileAt(x + deltaX, y).furniture ~= "" then return end
		tile.furniture = "Couch"
		tile.furniturePlayer = CurrentPlayer
		GetTileAt(x + deltaX, y).furniture = "Couch"
		GetTileAt(x + deltaX, y).furniturePlayer = CurrentPlayer
		tile.Object:setFillColor(0.5, 0.2, 0.05)
		GetTileAt(x + deltaX, y).Object:setFillColor(0.5, 0.2, 0.05)

	elseif furniture == "Side Table" then
		if tile.furniture ~= "" then return end
		tile.furniture = "Side Table"
		tile.furniturePlayer = CurrentPlayer

		tile.Sprite = display.newImageRect("images/sidetable.png", tileSize, tileSize)
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

	elseif furniture == "Coffee Table" then
		print("placing coffee table at tile (" .. tostring(x) .. ", " .. tostring(y) .. ")")
	end

	-- Move on to next player
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

	-- Play sound effect
	audio.play(Sounds["Place Furniture"])
end
