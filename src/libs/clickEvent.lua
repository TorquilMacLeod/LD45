local clickEvent = {
  active = false,
  currentValue = 0,
  completed = false,
  completeFunc = function () end,
  difficulty = 1
}

local clickEventHelper = love.graphics.newImage('assets/game/graphics/UI/clickEventHelper.png')
local clickEventHelperWidth, clickEventHelperHeight = clickEventHelper:getWidth(), clickEventHelper:getHeight()
local clickEventHelperColor = { 1, 1, 1, 1}
local clickEventHelperFadeColor = { 1, 1, 1, 0}

local clickEventColor = { 0.8, 0.8, 0.8, 1}
local clickEventFadeColor = { 0.8, 0.8, 0.8, 0}
local clickEventFadeTime = 0.4

local outerRadius = 60
local arcRadius = 55
local innerRadius = 46

local startAngle = (-0.5 * math.pi)
local centerX, centerY = (love.graphics.getWidth()/2), (love.graphics.getHeight() - (outerRadius * 2))

local arcColor = {0.3, 0.3, 0.3, 1}
local arcFadeColor = {0.3, 0.3, 0.3, 0}
local arcFadeTime = 0.3

local completeSound = love.audio.newSource('assets/game/audio/effects/UIEvent.wav', 'static')

function clickEvent:start(completeFunc, difficulty)
  self.difficulty = difficulty or 1
  self.completed = false
  self.active = true
  self.completeFunc = completeFunc
end

function clickEvent:draw()
  if (self.active) then
    love.graphics.setColor(clickEventColor)
    love.graphics.circle('fill', centerX, centerY, outerRadius)
    love.graphics.setColor(arcColor)
    love.graphics.arc('fill', centerX, centerY, arcRadius, startAngle, (startAngle + (2 * math.pi * self.currentValue)))
    love.graphics.setColor(clickEventColor)
    love.graphics.circle('fill', centerX, centerY, innerRadius)
    love.graphics.setColor(clickEventHelperColor)
    love.graphics.draw(clickEventHelper, centerX - clickEventHelperWidth/2, centerY - 10 - clickEventHelperHeight/2)
  end
end

function clickEvent:mousepressed(x, y, button)
  if (not self.completed and self.active) then
    self.currentValue = self.currentValue + (0.2 * self.difficulty)
    if (self.currentValue > 1) then
      self.completed = true
      Timer.tween(arcFadeTime, arcColor, {0.4, 0.4, 0.8}, 'in-quint', clickEvent.complete)
    end
  end
end

function clickEvent:update(dt)
  if (not self.completed and self.active) then
    self.currentValue = lume.clamp(self.currentValue - (0.7 * dt), 0, 1)
  end
end

function clickEvent:complete()
  completeSound:play()
  Timer.tween(clickEventFadeTime, clickEventColor, clickEventFadeColor, 'in-quint')
  Timer.tween(clickEventFadeTime, arcColor, arcFadeColor, 'in-quint')
  Timer.tween(clickEventFadeTime, clickEventHelperColor, clickEventHelperFadeColor, 'in-quint')
  Timer.after(clickEventFadeTime + 0.2, clickEvent.cleanup)
end

function clickEvent:cleanup()
  clickEvent.active = false
  clickEvent.completeFunc()
  clickEvent.completeFunc = nil
  clickEvent.currentValue = 0
  clickEventHelperColor = { 1, 1, 1, 1}
  clickEventColor = { 0.8, 0.8, 0.8, 1}
  arcColor = {0.3, 0.3, 0.3, 1}
end

return clickEvent