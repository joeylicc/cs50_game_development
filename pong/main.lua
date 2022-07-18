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

local GAME_TOP_MARGIN, GAME_RIGHT_MARGIN, GAME_BOTTOM_MARGIN, GAME_LEFT_MARGIN = 20, 10, 20, 10

-- Gets the width and height of the desktop.
local WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()

local PADDLE_WIDTH, PADDLE_HEIGHT = 20, 5

local BALL_SIZE = 4

--[[
    This function is called exactly once at the beginning of the game.
]]
function love.load(arg, unfilteredArg)
    -- Sets the default scaling filters used with Images, Canvases, and Fonts.
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- Creates a new Font from a TrueType Font or BMFont file.
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- Set an already-loaded Font as the current font.
    love.graphics.setFont(smallFont)

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
    
    -- Clears the game screen to the specified color.
    love.graphics.clear(45/255, 45/255, 52/255, 255/255)

    -- Draws welcome text at the top of the game screen.
    love.graphics.printf('Hello Pong!', -- A text string.
        0,                  -- The position on the x-axis. (0 since we're going to center it based on width)
        10,                  -- The position on the y-axis. (halfway down the window)
        GAME_WIDTH,         -- Wrap the line after this many horizontal pixels. (the entire window width here)
        'center'            -- The alignment, can be 'center', 'left', or 'right'
    )

    -- Draw Player 1 paddle (left side)
    love.graphics.rectangle('fill', GAME_LEFT_MARGIN, GAME_TOP_MARGIN, PADDLE_HEIGHT, PADDLE_WIDTH)

    -- Draw Player 2 paddle (right side)
    love.graphics.rectangle('fill', GAME_WIDTH - GAME_RIGHT_MARGIN - PADDLE_HEIGHT, GAME_HEIGHT - GAME_BOTTOM_MARGIN - PADDLE_WIDTH, PADDLE_HEIGHT, PADDLE_WIDTH)

    -- Draw the ball
    love.graphics.rectangle('fill', GAME_WIDTH / 2 - BALL_SIZE / 2, GAME_HEIGHT / 2 - BALL_SIZE / 2, BALL_SIZE, BALL_SIZE)

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
