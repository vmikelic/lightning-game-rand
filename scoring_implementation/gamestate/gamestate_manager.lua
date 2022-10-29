-- gamestate manager
--[[
    handles the current state of the game
]]
gamestate_manager={
    gameover=false,
    max_score=100
}

-- reset to defaults
function gamestate_manager.reset()
    gamestate_manager.gameover = false
end