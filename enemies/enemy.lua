-- enemy
--[[
    enemy base class
]]

enemy={
    sprite=-1,
    flip_x=false,
    flip_y=false,
    x=0,
    y=0,
    vel_x=0,
    vel_y=0,
    acc_x=0,
    acc_y=0,
    wiggle_x=0,
    wiggle_y=0,
    static=false,
    static_end=0,
    vel_max=30
}
enemy.__index = enemy

-- frames for acceleration normalization
local fps = 30

-- enemy base
function enemy:new(o)
    return setmetatable(o or {}, self)
end

-- add to acceleration
function enemy:add_acceleration(x,y)
    self.acc_x += x
    self.acc_y += y
end

-- set acceleration
function enemy:set_acceleration(x,y)
    self.acc_x = x
    self.acc_y = y
end

-- freeze in place
function enemy:freeze(seconds)
    self.static = true
    self.static_end = time() + seconds
end

-- update loop
function enemy:_update()

    -- check if static can be 
    if self.static then
        if time() >= self.static_end then
            self.static = false
        end
    end

    -- apply acceleration
    if self.acc_x > 0 then
        self.vel_x += self.acc_x/fps
        self.vel_x = min(self.vel_max, self.vel_x)
    end
    if self.acc_y > 0 then
        self.vel_y += self.acc_y/fps
        self.vel_y = min(self.vel_max, self.vel_y)
    end

    -- if not frozen in space, apply velocity
    if not self.static then
        -- move x
        if self.vel_x > 0 then
            self.x += self.vel_x/fps
            -- apply vertical wiggle
            if self.wiggle_y > 0 then
                local wiggle = sin(self.x/self.wiggle_y)
                if self.flip_y then wiggle = -wiggle end
                self.y += wiggle
            end
        end
        -- move y
        if self.vel_y > 0 then
            self.y += self.vel_y/fps
            -- apply horizontal wiggle
            if self.wiggle_x > 0 then
                local wiggle = sin(self.y/self.wiggle_x)
                if self.flip_x then wiggle = -wiggle end
                self.x += wiggle
            end
        end
    end

end--_update()

-- draw loop
-- overridable
function enemy:_draw()

    -- draw sprite or debug circle
    if self.sprite > -1 then
        spr(self.sprite,self.x,self.y,1,1,self.flip_x,self.flip_y)
    else
        circfill(self.x,self.y,4,0)
    end

end--_draw()