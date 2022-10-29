-- [scene] in-game
game={
    game_over_option=1,
    game_over_options={
        'restart',
        'main menu'
    }
}

-- primary init
function game._init()
    -- reset game state
    gamestate_manager.reset()
    enemy_manager.reset()
end--_init()

-- primary update loop
function game._update()
    -- game over state
    if player_ship.health <= 0
    or score.get() >= gamestate_manager.max_score then
        gamestate_manager.game_over = true
    end
    if gamestate_manager.game_over then
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
    if player_ship.health > 0 then
	    player_ship:draw() end
	laser_man_obj:draw_lasers()
    enemy_manager._draw()
    handle_animations()

    -- game over interrupt
    if gamestate_manager.game_over then
        -- TODO: restart screen
        local msg = 'gAME oVER'
        print(msg,(64-#msg*2),44,7)

        -- print win/lose
        local subtitle = 'yOU lOSE'
        local clr = 8
        if player_ship.health > 0 then
            subtitle = 'yOU wIN'
            clr = 11
        end
        print(subtitle,(64-#subtitle*2),54,clr)

        -- print final score
        local fs = 'final score: '..score.get()
        print(fs,64-#fs*2,64,7)
        return
    end

    --[[
        after game over interrupt- game is still active
    ]]

    -- draw ui elements
    score.draw_ui()

end--_draw()