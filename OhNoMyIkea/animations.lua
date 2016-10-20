
function RotateIn(obj, del, dir)
	if obj == nil then return end
	if del == nil then del = 0 end
	if dir == nil then
		obj.rotation = -360
		if math.random(2) == 1 then
			obj.rotation = 360
		end
	else
		if dir == "right" then
			obj.rotation = -360
		else
			obj.rotation = 360
		end
	end

	-- Set to starting position:
	obj.xScale = 0.01
	obj.yScale = 0.01
	obj.alpha = 0

	-- Animate:
	transition.to(obj, {
		delay = del,
		time = 700,
		rotation = 0,
		xScale = 1,
		yScale = 1,
		alpha = 1,
		transition = easing.outBack
	})
end

function RotateOut(obj, del)
	if obj == nil then return end
	if del == nil then del = 0 end

	-- Set to starting position:
	obj.rotation = 0
	local targetRotation = 360
	if math.random(2) == 2 then targetRotation = -360 end
	obj.xScale = 1
	obj.yScale = 1
	obj.alpha = 1

	-- Animate:
	transition.to(obj, {
		delay = del,
		time = 700,
		rotation = targetRotation,
		xScale = 0.01,
		yScale = 0.01,
		alpha = 0,
		transition = easing.inBack
	})
end

function FallIn(obj, yPos, del)
	if obj == nil then return end
	if yPos == nil then yPos = Height / 2 end
	if del == nil then del = 0 end

	-- Set to starting position:
	obj.y = -obj.height / 2

	-- Animate:
	transition.to(obj, {
		delay = del,
		time = 500,
		y = yPos,
		transition = easing.outBack
	})
end

function InLeft(obj, xPos, del)
	if obj == nil then return end
	if xPos == nil then xPos = Width / 2 end
	if del == nil then del = 0 end

	-- Set to starting position:
	obj.x = -obj.width / 2

	-- Animate:
	transition.to(obj, {
		delay = del,
		time = 500,
		x = xPos,
		transition = easing.outBack
	})
end
