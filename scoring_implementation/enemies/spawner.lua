-- spawner
--[[
    handles spawning enemies and asteroids
]]

spawner={
    active=true,
    frame=0,
    spawned_this_second=0
}

local config={
    min_x=0,
    max_x=128,
    y=-8,
    max_per_second=1,--enemies per seconds (max)
    spawn_chance=0.1
}

function spawner._update()

    -- do nothing if not active
    if not spawner.active then
        return
    end

    -- if spawnable, try
    if spawner.spawned_this_second < config.max_per_second + main_menu.diff() - 1 + score.get() / (150-main_menu.diff()*5) then
        -- roll for spawn chance and spawn if eligible
        if rnd(1) >= config.spawn_chance then
            local x = flr(rnd(config.max_x-config.min_x)) + config.min_x
            enemy_manager.append(asteroid:new({x=x,y=config.y}))
            spawner.spawned_this_second += 1
        end
    end

    -- increment frame count
    spawner.frame += 1
    -- reset after second passed
    if spawner.frame >= 30 then
        spawner.frame = 0
        spawner.spawned_this_second = 0
    end

end--_update()