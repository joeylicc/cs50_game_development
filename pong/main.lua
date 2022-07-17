--[[
    Pong is a table tennis–themed twitch arcade sports video game, featuring 
    simple two-dimensional graphics, manufactured by Atari and originally 
    released in 1972.
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
    This function is called exactly once at the beginning of the game.
]]
function love.load(arg, unfilteredArg)
    -- Sets the display mode and properties of the window.
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT,    -- Display width & height.
        {  
            fullscreen = false, -- Fullscreen (true), or windowed (false).
            resizable = false,  -- True if the window should be resizable in windowed mode, false otherwise.
            vsync = 1           -- Enables or disables vertical synchronisation ('vsync'): 1 to enable vsync, 0 to disable it, and -1 to use adaptive vsync (where supported).
        }
    )
end

--[[
    Callback function used to draw on the screen every frame.
]]
function love.draw()
    -- Draws formatted text, with word wrap and alignment.
    love.graphics.printf(
        'Hello Pong!',          -- A text string.
        0,                      -- The position on the x-axis. (0 since we're going to center it based on width)
        WINDOW_HEIGHT / 2 - 6,  -- The position on the y-axis. (halfway down the window)
        WINDOW_WIDTH,           -- Wrap the line after this many horizontal pixels. (the entire window width here)
        'center'                -- The alignment, can be 'center', 'left', or 'right'
    )               
end
