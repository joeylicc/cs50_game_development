--[[
    https://github.com/vrld/hump
    Lightweight object orientation (class or prototype based).
]]
class = require "class"

Ball = class {}

function Ball:init(x, y, size)
    self.initX = x
    self.initY = y

    self.x = x
    self.y = y
    self.size = size

    self.dx = (math.random(2) == 1 and 1 or -1) * math.random(50, 200)
    self.dy = math.random(-1, 1) * math.random(50, 200)
end

function Ball:reset()
    self.x = self.initX
    self.y = self.initY

    self.dx = (math.random(2) == 1 and 1 or -1) * math.random(50, 200)
    self.dy = math.random(-1, 1) * math.random(50, 200)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end
