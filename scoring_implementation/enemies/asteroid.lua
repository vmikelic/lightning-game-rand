asteroid={}
asteroid.__index = asteroid

local config={
    max_velocity=80,
    min_acceleration=20,
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

    -- for combat
    o.damage = 25
    o.score = 10

    -- create enemy object and apply asteroid properties

    local bonus = main_menu.diff() * 2 + score.get() * 1.5
    local en = enemy:new(o)
    en:set_acceleration(0, rnd(config.max_acceleration) + config.min_acceleration + bonus / (4-main_menu.diff()))
    en:add_acceleration(0, rnd(bonus) + bonus / (4-main_menu.diff()))

    en.vel_max += bonus

    return en
end