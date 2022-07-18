--[[
    Pong is a table tennis–themed twitch arcade sports video game, featuring
    simple two-dimensional graphics, manufactured by Atari and originally
    released in 1972.
]]

--[[
    https://github.com/Ulydev/push
    push is a simple resolution-handling library that allows you to focus on
    making your game with a fixed resolution.
]]
local push = require "push"

local GAME_WIDTH, GAME_HEIGHT = 432, 243

-- Gets the width and height of the desktop.
local WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()

--[[
    This function is called exactly once at the beginning of the game.
]]
function love.load(arg, unfilteredArg)
    -- Sets the default scaling filters used with Images, Canvases, and Fonts.
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- Setup game screen
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, -- turns fullscreen mode on or off
        resizable = false   -- allows resizing the window
    })
end

--[[
    Callback function used to draw on the screen every frame.
]]
function love.draw()
    push:start()
    
    -- Draws formatted text, with word wrap and alignment.
    love.graphics.printf('Hello Pong!', -- A text string.
        0,                              -- The position on the x-axis. (0 since we're going to center it based on width)
        GAME_HEIGHT / 2 - 6,            -- The position on the y-axis. (halfway down the window)
        GAME_WIDTH,                     -- Wrap the line after this many horizontal pixels. (the entire window width here)
        'center'                        -- The alignment, can be 'center', 'left', or 'right'
    )

    push:finish()
end

--[[
    Callback function triggered when a key is pressed.
]]
function love.keypressed(key, scancode, isrepeat)
    if key == 'escape' then
        love.event.quit()   -- Exits the LÖVE program.
    end
end
