//Laser manager class
laser_manager = {}

laser_manager.__index = laser_manager

function laser_manager:new(init_accel)
	o = {
		lasers = {},
		accel  = init_accel or 0.02
	}
	setmetatable(o, laser_manager)
	return o
end

function laser_manager:fire_laser(local_x, local_y)
	add(self.lasers, laser:new(local_x-1, local_y))
	sfx(2)
	animate_once(local_x-3,local_y-4,{0,1,2},1,1,1,1)
end

-- fully reset manager
function laser_manager:reset()
	for las in all(self.lasers) do
		del(self.lasers, las)
	end
end

function laser_manager:update()
	for i = 1, #self.lasers do
		if (self.lasers[i] != nil) then
			local new_vel = self.lasers[i].dy - self.accel
			if (new_vel > 1) then 
				new_vel = 1
			end
			
			self.lasers[i].dy = new_vel
			
			if (self.lasers[i]:is_hit()) then
				del(self.lasers, self.lasers[i])
			else
				self.lasers[i].y  += self.lasers[i].dy
			end
		end
	end
end

function laser_manager:draw_lasers()
	for i = 1, #self.lasers do
		animate(self.lasers[i], self.lasers[i].x, self.lasers[i].y,{10,11}, 1, 1,3) --animated
		--spr(self.lasers[i].spr, self.lasers[i].x, self.lasers[i].y, 1, 1) --static
	end
end

