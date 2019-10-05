local keyTip = {
  tips = {
    w = {
      active = false,
      complete = false,
      deactivateKey = {w = true},
      image = love.graphics.newImage('assets/game/graphics/UI/wTip.png')
    },
    wasd = {
      active = false,
      complete = false,
      deactivateKey = {w = true, a = true, s = true, d = true},
      image = love.graphics.newImage('assets/game/graphics/UI/wasdTip.png')
    }
  },
  tipPositionX = 40,
  tipPositionY = love.graphics.getHeight() - 40,
  tipColor = {1, 1, 1, 1},
  tipSatisfiedColor = {0, 0.4, 0, 1},
  tipSatisfyTime = 0.2,
  tipFadeColor = {0, 0.4, 0, 0},
  tipFadeTime = 0.2,
  tipType = nil,
  tipSound = love.audio.newSource('assets/game/audio/effects/UIEvent.wav', 'static')
}

function keyTip:start(tipType)
  keyTip.tipType = tipType
  keyTip.tips[tipType].active = true
  keyTip.tipOriginY = keyTip.tips[keyTip.tipType].image:getHeight()
  print("started with tipType: ", tipType)
end

function keyTip:draw()
  if (keyTip.tipType) then
    if (keyTip.tips[keyTip.tipType].active) then
      love.graphics.setColor(keyTip.tipColor)
      love.graphics.draw(keyTip.tips[keyTip.tipType].image, keyTip.tipPositionX, keyTip.tipPositionY, 0, 1, 1, 0, keyTip.tipOriginY)
    end
  end
end

function keyTip:keypressed(key)
  if (keyTip.tipType) then
    if (keyTip.tips[keyTip.tipType].active and not keyTip.tips[keyTip.tipType].complete) then
      if (keyTip.tips[keyTip.tipType].deactivateKey[key] == true) then
        keyTip.tips[keyTip.tipType].complete = true
        keyTip.tipSound:play()
        Timer.tween(keyTip.tipSatisfyTime, keyTip.tipColor, keyTip.tipSatisfiedColor, 'in-quint')
        Timer.after(keyTip.tipSatisfyTime + 1, keyTip.complete)
      end
    end
  end
end

function keyTip:keyreleased(key)
end

function keyTip:update(dt)
end

function keyTip:complete()
  Timer.tween(keyTip.tipFadeTime, keyTip.tipColor, keyTip.tipFadeColor, 'in-quint')
  Timer.after(keyTip.tipFadeTime + 0.2, keyTip.cleanup)
end

function keyTip:cleanup()
  if (keyTip.tipType) then
    keyTip.tips[keyTip.tipType].active = false
    keyTip.tips[keyTip.tipType].completed = false
    keyTip.tipType = nil
    keyTip.tipColor = {1, 1, 1, 1}
  end
end

return keyTip