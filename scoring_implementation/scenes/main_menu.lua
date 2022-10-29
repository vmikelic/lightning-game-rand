-- [scene] main menu
main_menu={
    selected=0,
    selections={
        'easy',
        'medium',
        'hard'
    },
    asteroid=nil,
    bullet=nil,

    -- title
    title='space invaders',
    title_x=-1,

    -- subtitle
    subtitle='phys-x',
    subtitle_x=-1,
    subtitle_x1=-1
}

-- primary init
function main_menu._init()

    -- title
    main_menu.title_x = 64-(#main_menu.title*2)

    -- subtitle
    main_menu.subtitle_x = 64 - (#main_menu.subtitle * 2)
    main_menu.subtitle_x1 = main_menu.subtitle_x + #main_menu.subtitle * 4

    -- cosmetics
    main_menu.asteroid = animation:new(
        17,
        20,
        {32,33,34,35,36,37,38,39},1,1,30)
    main_menu.bullet = animation:new(
        main_menu.title_x+#main_menu.title*4+15,
        31,
        {13,14},1,1,3)

end--_init()


-- primary update loop
function main_menu._update()

end--_update()

local function draw_title()
    local title = main_menu.title
    local title_x = main_menu.title_x
    print(title,title_x,20,12)
    line(title_x,27,title_x+#title*4-2,27,1)
end

local function draw_subtitle()
    local title = main_menu.title
    local title_x = main_menu.title_x
    local subtitle = 'phys'
    local subtitle_x = 64 - (#subtitle * 2)
    local subtitle_x1 = subtitle_x + #subtitle * 4

    -- subtitle "bullet"
    local skip = 1
    local start = title_x - 2
    local stop = start+#title*4+14
    for i=start,stop,1 do
        local skipping = false

        -- if time to skip add skip effect
        if i==title_x+skip then
            skip = skip + skip
            skipping = true
        end
        -- if inside the phys text skip
        if i>=subtitle_x-5 and i<=subtitle_x1+3 then
            skipping = true
        end

        -- draw line pixel
        if not skipping then
            pset(i,32,8)
        end
    end
end

-- primary draw loop
function main_menu._draw()
    cls()
    draw_stars()

    -- draw title
    draw_title()

    -- draw subtitle
    draw_subtitle()
    
    -- animate consmetics
    main_menu.bullet:animate()
    main_menu.asteroid:animate()
    print(main_menu.subtitle,main_menu.subtitle_x,30,10)

end--_draw()