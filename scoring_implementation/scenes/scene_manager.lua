-- scene_manager
scene_manager={
    current=0 -- 0: main menu | 1: in-game
}

-- scene changer
function scene_manager.swap(scene)
    scene_manager.current = scene
    return scene_manager.current
end

-- primary update loop
function scene_manager._update()
    local s = scene_manager.current

    -- route to scene update
    if s == 0 then return main_menu._update() end
    if s == 1 then return game._update() end

end--_update()

-- primary draw loop
function scene_manager._draw()
    local s = scene_manager.current

    -- route to scene update
    if s == 0 then return main_menu._draw() end
    if s == 1 then return game._draw() end

end--_draw()