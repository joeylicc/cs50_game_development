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
local PADDLE_SPEED = 200

local BALL_SIZE = 4

--[[
    This function is called exactly once at the beginning of the game.
]]
function love.load(arg, unfilteredArg)
    -- Sets the default scaling filters used with Images, Canvases, and Fonts.
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- Creates a new Font from a TrueType Font or BMFont file.
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- Setup game screen
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, -- turns fullscreen mode on or off
        resizable = false   -- allows resizing the window
    })

    player1Score = 0
    player2Score = 0

    player1PaddleY = GAME_TOP_MARGIN
    player2PaddleY = GAME_HEIGHT - GAME_BOTTOM_MARGIN - PADDLE_WIDTH
end

--[[
    Callback function used to update the state of the game every frame.
]]
function love.update(dt)
    -- Player 1 movement
    if love.keyboard.isDown('w') then
        player1PaddleY = player1PaddleY - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1PaddleY = player1PaddleY + PADDLE_SPEED * dt
    end

    -- Player 2 movement
    if love.keyboard.isDown('up') then
        player2PaddleY = player2PaddleY - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2PaddleY = player2PaddleY + PADDLE_SPEED * dt
    end
end

--[[
    Callback function used to draw on the screen every frame.
]]
function love.draw()
    push:start()
    
    -- Clears the game screen to the specified color.
    love.graphics.clear(45/255, 45/255, 52/255, 255/255)

    -- Draws welcome text at the top of the game screen.
    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 10, GAME_WIDTH, 'center')

    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, GAME_WIDTH / 2 - 50, GAME_HEIGHT / 3)
    love.graphics.print(player2Score, GAME_WIDTH / 2 + 30, GAME_HEIGHT / 3)

    -- Draw Player 1 paddle (left side)
    love.graphics.rectangle('fill', GAME_LEFT_MARGIN, player1PaddleY, PADDLE_HEIGHT, PADDLE_WIDTH)

    -- Draw Player 2 paddle (right side)
    love.graphics.rectangle('fill', GAME_WIDTH - GAME_RIGHT_MARGIN - PADDLE_HEIGHT, player2PaddleY, PADDLE_HEIGHT, PADDLE_WIDTH)

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
