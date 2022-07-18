--[[
    https://github.com/vrld/hump
    Lightweight object orientation (class or prototype based).
]]
class = require "class"

Paddle = class {}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = 0
end

function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(GAME_TOP_MARGIN, self.y + self.dy * dt)
    else
        self.y = math.min(GAME_HEIGHT - GAME_BOTTOM_MARGIN - self.height, self.y + self.dy * dt)
    end
end

function Paddle:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
