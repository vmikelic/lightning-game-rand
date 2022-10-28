-- Laser Class
laser = {}

laser.__index = laser

function laser:new(init_x, init_y)
	o = {
		x   = init_x or 0,
		y   = init_y or 0,
		dy  = 0,
		spr = 6
	}
	setmetatable(o, laser)
	return o
end

function laser:is_hit(color)
	if (pget(self.x, self.y+self.dy) == color or self.y <= 0) then
		return true
	else
		return false
	end
end
