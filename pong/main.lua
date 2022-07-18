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

require "ball"
require "paddle"

GAME_WIDTH, GAME_HEIGHT = 432, 243
GAME_TOP_MARGIN, GAME_RIGHT_MARGIN, GAME_BOTTOM_MARGIN, GAME_LEFT_MARGIN = 20, 10, 20, 10

-- Gets the width and height of the desktop.
local WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()

local BALL_SIZE = 4

local PADDLE_WIDTH, PADDLE_HEIGHT = 5, 20
local PADDLE_SPEED = 200

--[[
    This function is called exactly once at the beginning of the game.
]]
function love.load(arg, unfilteredArg)
    -- Initializes pseudo-random generator
    math.randomseed(os.time())

    -- Sets the default scaling filters used with Images, Canvases, and Fonts.
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- Creates a new Font from a TrueType Font or BMFont file.
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- Setup the game screen
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, -- turns fullscreen mode on or off
        resizable = false   -- allows resizing the window
    })

    -- Initializes game state
    gameState = 'start'

    -- Initializes players' score
    player1Score = 0
    player2Score = 0

    -- Initializes the ball
    ball = Ball(GAME_WIDTH / 2 - BALL_SIZE / 2, GAME_HEIGHT / 2 - BALL_SIZE / 2, BALL_SIZE)

    -- Initializes paddles
    player1Paddle = Paddle(GAME_LEFT_MARGIN, GAME_TOP_MARGIN, PADDLE_WIDTH, PADDLE_HEIGHT)
    player2Paddle = Paddle(GAME_WIDTH - GAME_RIGHT_MARGIN - PADDLE_WIDTH, GAME_HEIGHT - GAME_BOTTOM_MARGIN - PADDLE_HEIGHT, PADDLE_WIDTH, PADDLE_HEIGHT)
end

--[[
    Callback function used to update the state of the game every frame.
]]
function love.update(dt)
    -- Ball movement
    if gameState == 'play' then
        ball:update(dt)
    end

    -- Player 1 paddle movement (left side)
    player1Paddle.dy = 0
    if love.keyboard.isDown('w') then
        player1Paddle.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1Paddle.dy = PADDLE_SPEED
    end
    player1Paddle:update(dt)

    -- Player 2 paddle movement (right side)
    player2Paddle.dy = 0
    if love.keyboard.isDown('up') then
        player2Paddle.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2Paddle.dy = PADDLE_SPEED
    end
    player2Paddle:update(dt)
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
    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 10, GAME_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 10, GAME_WIDTH, 'center')
    end

    -- Draws players' score
    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, GAME_WIDTH / 2 - 50, GAME_HEIGHT / 3)
    love.graphics.print(player2Score, GAME_WIDTH / 2 + 30, GAME_HEIGHT / 3)

    -- Draws the ball
    ball:draw()

    -- Draws paddles
    player1Paddle:draw()
    player2Paddle:draw()

    push:finish()
end

--[[
    Callback function triggered when a key is pressed.
]]
function love.keypressed(key, scancode, isrepeat)
    if key == 'escape' then
        love.event.quit()   -- Exits the LÖVE program.
    end
    if key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ball:reset()
        end
    end
end
