-- score
--[[
    score-manager for player
]]

score={
    amount=0
}

-- get player score
function score.get()
    return score.amount
end

-- get max score
function score.get_max()
    return gamestate_manager.max_score + (main_menu.diff() - 1) * 20
end

-- reset score
function score.reset()
    score.amount = 0
    return score.amount
end

-- add to player score
function score.inc(points)
    score.amount += points
    return score.amount
end

-- draw loop
function score.draw_ui()
    -- print('needed to win: '..gamestate_manager.max_score,2,2,7)
    print('⧗ sCORE: '..score.amount..'/'..score.get_max(),2,128-8-2,7)
    print('♥ '..player_ship.health..'/'..player_ship.max_health,2,128-8-8,7)
end