-- enemy_manager
--[[
    singleton that handles all enemies in the scene
]]

enemy_manager={
    enemies={}
}

-- add enemy
function enemy_manager.append(en)
    add(enemy_manager.enemies, en)
end

-- remove enemy from the manager
function enemy_manager.remove(en)
    del(enemy_manager.enemies, en)
end

-- update loop
function enemy_manager._update()
    -- run update loop for all enemies
    for en in all(enemy_manager.enemies) do
        en:_update()
        en:_player_collision()
        if(en.y > 127+8) then
            enemy_manager.remove(en)
        end
    end
end--_update()

-- draw loop
function enemy_manager._draw()
    -- run draw loop for all enemies
    for en in all(enemy_manager.enemies) do
        en:_draw()
        --animate_once(en.x,en.y,{40},1,1,1,1) hitbox debug
    end
end--_draw()