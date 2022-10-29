//player class

player = {
	max_health=100
}
player.__index = player

function player:new(new_laser_man)
	o = {}
	setmetatable(o, player)
	o.thrust_anim = {3,4,5} -- allows multiple animations per object
	o.ship_anim = {6,8}
	o.x      = 64
	o.y		    = 100
	o.width  = 16
	o.dx 	   = 0
	o.dy     = 0
	o.accel  = 0.05
	o.decel  = 1.05
	o.ssize  = 2
	o.health = self.max_health
	o.laser_t = 0//seconds
	o.laser_man_ref = new_laser_man
	return o
end

function player:control()
	self:move ()
	self:shoot()
end

function player:shoot()
	
	if(btn(5) and self.laser_man_ref != nil and time() - self.laser_t >= 0.2) then
		self.laser_man_ref:fire_laser(self.x + 8, self.y - 3)
		self.laser_t = time()
	end
end

function player:move()

	if(btn(0)) then 
		self.dx = self.dx - self.accel 
	end
	 
	if(	btn (1)) then
		self.dx = self.dx + self.accel
	end
	
	if (not btn(0) and not btn(1)) then
		self.dx /= self.decel
	end

	if ( abs(self.dx) < 0.01) then
		self.dx = 0
	end
	
	local new_x_pos = self.x + self.dx
	
	if( new_x_pos >= 0 and new_x_pos <= 127 - self.width) then 
		self.x += self.dx
	else 
		if (new_x_pos < 0) then
			self.x  = 0
			self.dx = 0
		end
		if (new_x_pos > 127 - self.width) then
			self.x = 127 - self.width
			self.dx= 0
		end
	end
end

function player:update()
	self:control()
	sfx(1)
end

function player:draw()
	animate(self.thrust_anim,self.x+5,self.y+10,self.thrust_anim,1,2,3)
	animate(self.ship_anim,self.x,self.y,self.ship_anim,2,2,30)
end
