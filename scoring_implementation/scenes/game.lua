-- [scene] in-game
game={
    game_over=false
}

-- primary update loop
function game._update()
    -- game over screen
    if game.game_over then
        -- TODO: restart controls
        return
    end

    -- game loop
    update_stars()
    spawner._update()
    enemy_manager._update()
    timers._update()
    player_ship:update()
	laser_man_obj:update()
end--_update()

-- primary draw loop
function game._draw()
    -- draw loop
    cls()
    draw_stars()
	player_ship:draw()
	laser_man_obj:draw_lasers()
    enemy_manager._draw()
    handle_animations()

    -- draw ui elements
    score.draw_ui()

    -- game over screen
    if game.game_over then
        -- TODO: restart screen
        return
    end
end--_draw()