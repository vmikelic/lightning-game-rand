-- gamestate manager
--[[
    handles the current state of the game
]]
gamestate_manager={
    game_over=false,
    max_score=10
}

-- reset to defaults
function gamestate_manager.reset()
    gamestate_manager.game_over = false
end