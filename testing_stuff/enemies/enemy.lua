-- enemy
--[[
    enemy base class
]]

enemy={
    rotation_anim = {32,33,34,35,36,37,38,39}, -- allows multiple animations per object
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
    __wiggle_val_x=0,
    __wiggle_val_y=0,
    static=false,
    static_end=0,
    vel_max=30,

    -- for combat
    health=100,
    damage=1
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
        end
        -- move y
        if self.vel_y > 0 then
            self.y += self.vel_y/fps
        end

        -- apply vertical wiggle
        if self.wiggle_y > 0 then
            local wiggle = sin(self.__wiggle_val_y/self.wiggle_y)
            self.__wiggle_val_y += 1 / 2
            if self.flip_y then wiggle = -wiggle end
            self.y += wiggle
        end

        -- apply horizontal wiggle
        if self.wiggle_x > 0 then
            local wiggle = sin(self.__wiggle_val_x/self.wiggle_x)
            self.__wiggle_val_x += 1 / 2
            if self.flip_x then wiggle = -wiggle end
            self.x += wiggle
        end

    end

end--_update()

-- draw loop
-- overridable
function enemy:_draw()

    -- draw sprite or debug circle
    if self.sprite > -1 then
        animate(self, self.x, self.y, self.rotation_anim, 1, 1, 4)
    else
        circfill(self.x,self.y,4,0)
    end

end--_draw()

function enemy:_player_collision()
    if(self.y+8 > player_ship.y) then
        if(self.x+8 > player_ship.x) then
            if(self.y < player_ship.y+16) then
                if(self.x < player_ship.x+16) then
                    for i = 1, 5 do -- explosion
                        animate_once(player_ship.x+(flr(rnd(16))-8),player_ship.y+(flr(rnd(16))-8),{43,45,64,66,68},2,2,flr(rnd(5))+3,flr(rnd(2))+1)
                    end
                    enemy_manager.remove(en) -- remove asteroid
                    sfx(0)
                    --do stuff when player is hit
                end
            end
        end
    end

end--_player_collision()