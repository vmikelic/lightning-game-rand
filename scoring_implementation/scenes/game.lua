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
    score.reset()
    player_ship:reset()
    laser_man_obj:reset()
end--_init()

-- primary update loop
function game._update()
    -- game over state
    if player_ship.health <= 0
    or score.get() >= gamestate_manager.max_score then
        gamestate_manager.game_over = true
    end

    if gamestate_manager.game_over then
        if btnp(⬆️) then
            game.game_over_option -= 1
            if game.game_over_option < 1 then
                game.game_over_option = #game.game_over_options end
        end
        if btnp(⬇️) then
            game.game_over_option += 1
            if game.game_over_option > #game.game_over_options then
                game.game_over_option = 1 end
        end
        if btnp(🅾️) then
            if game.game_over_option == 1 then
                -- restart game
                gamestate_manager.reset()
                scene_manager.swap(1)
            else
                -- go to the main menu
                scene_manager.swap(0)
            end
            -- reset
            game.game_over_option = 1
        end
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

local blinking = 0
local blinking_cycle = 80 -- does a full blink each frame amount
local function draw_choices()
    local offset = 10
    local start_y = 57
    for i,sel in ipairs(game.game_over_options) do
        local x0 = 64 - (#sel * 2)
        local x1 = x0 + #sel * 4 - 2
        local y = start_y + offset * i
        local clr = 7

        -- check if option is the currently selected
        if i == game.game_over_option then
            -- swap to green
            clr = 3

            -- draw line with blinking effect
            if blinking < blinking_cycle / 2 then
                line(x0,y+6,x1,y+6,3)
            end
        end

        -- finally, print
        print(sel,x0,y,clr)

    end

    -- draw confirmation
    local msg = 'press 🅾️ to confirm'
    print(msg,64-(#msg*2),start_y + #game.game_over_options * offset + offset, 13)

    -- update blinker
    blinking += 1
    if blinking > blinking_cycle then
        blinking = 1
    end

end

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
        local start_y = 40

        -- print game over
        local msg = 'gAME oVER'
        print(msg,(64-#msg*2),start_y-16,7)

        -- print win/lose
        local subtitle = 'yOU lOSE'
        local clr = 8
        if player_ship.health > 0 then
            subtitle = 'yOU wIN'
            clr = 11
        end
        print(subtitle,(64-#subtitle*2),start_y-6,clr)

        -- print final score
        local fs = 'final score: '..score.get()
        print(fs,64-#fs*2,start_y+4,7)
        return

        -- print out options to proceed
        draw_choices()
    end

    --[[
        after game over interrupt- game is still active
    ]]

    -- draw ui elements
    score.draw_ui()

end--_draw()