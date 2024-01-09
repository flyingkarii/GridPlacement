local Validator = {}

function isInsideBrick(position, hitbox)
	local v3 = hitbox.CFrame:PointToObjectSpace(position)
	return (math.abs(v3.X) <= hitbox.Size.X / 2)
		and (math.abs(v3.Y) <= hitbox.Size.Y / 2)
		and (math.abs(v3.Z) <= hitbox.Size.Z / 2)
end

function isCompletelyInside(model: Model, hitbox)
	local orientation, modelSize = model:GetBoundingBox()
	local size = modelSize / 2
	local corners = {
		orientation * CFrame.new(size.X, size.Y, size.Z),
		orientation * CFrame.new(size.X, size.Y, -size.Z),
		orientation * CFrame.new(size.X, -size.Y, size.Z),
		orientation * CFrame.new(size.X, -size.Y, -size.Z),
		orientation * CFrame.new(-size.X, size.Y, size.Z),
		orientation * CFrame.new(-size.X, size.Y, -size.Z),
		orientation * CFrame.new(-size.X, -size.Y, size.Z),
		orientation * CFrame.new(-size.X, -size.Y, -size.Z)
	}

	for _, cf in ipairs(corners) do
		if not isInsideBrick(cf.Position, hitbox) then
			return false
		end
	end

	return true
end


function Validator.Test(model: Model, hitbox: Part)
	print(isCompletelyInside(model, hitbox))
end

return Validator