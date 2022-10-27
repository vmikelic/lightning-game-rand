//Laser Class
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

function laser:is_hit()
	if(self.y <= 0) then
		return true
	end
	for en in all(enemy_manager.enemies) do
		if(self.y+7 > en.y) then
			if(self.x+3 > en.x) then
				if(self.y < en.y+8) then
					if(self.x < en.x+8) then
						animate_once(en.x-4,en.y-4,{43,45,64,66,68},2,2,3,1)
						enemy_manager.remove(en)
						return true
					end
				end
			end
		end
    end
	
	return false
end
