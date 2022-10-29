asteroid={}
asteroid.__index = asteroid

local config={
    max_velocity=80,
    max_acceleration=50,
    wiggle_x=50,
    wiggle_y=0
}

-- create a new asteroid enemy variant
function asteroid:new(o)
    local t_f = {true,false}

    -- set asteroid properties
    o.sprite = 1 -- asteroid sprite
    o.vel_max = config.max_velocity

    -- pseudo-random sprite drawing
    o.flip_x = t_f[flr(rnd(2))+1]
    o.flip_y = t_f[flr(rnd(2))+1]
    o.wiggle_x = config.wiggle_x
    o.wiggle_y = config.wiggle_y

    -- create enemy object and apply asteroid properties
    local en = enemy:new(o)
    en:set_acceleration(0, rnd(config.max_acceleration))

    return en
end