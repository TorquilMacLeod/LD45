local keypad = {
  dialogue = {
    AI_doorReached = {
      source = love.audio.newSource('assets/game/audio/speech/keypad/AI_1.mp3', 'stream'),
    },
    AI_doorOpened = {
      source = love.audio.newSource('assets/game/audio/speech/keypad/AI_2.mp3', 'stream'),
    }
  },
  allowWalking = true,
  walking = false,
  walkedDist = 0,
  walkDist = 8,
  walkSound = love.audio.newSource('assets/game/audio/effects/walking.wav', 'static'),
  keypressSound = love.audio.newSource('assets/game/audio/effects/keypadPress.wav', 'static'),
  incorrectCodeSound = love.audio.newSource('assets/game/audio/effects/keypadIncorrect.wav', 'static'),
  correctCodeSound = love.audio.newSource('assets/game/audio/effects/keypadCorrect.wav', 'static'),
  atKeypad = false,
  currentCode = "",
  code = "1221",
  keypadMouseTip = love.graphics.newImage('assets/game/graphics/UI/clickEventHelper.png')
}

for k, v in pairs(keypad.dialogue) do
  v.delay = v.source:getDuration('seconds') + 0.4
end

function keypad:init()
end

function keypad:draw()
  if (keypad.atKeypad) then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(keypad.keypadMouseTip, love.graphics.getWidth() - 140, love.graphics.getHeight() - 140)
  end
end

function keypad:update(dt)
  if (keypad.walking) then
    keypad.walkedDist = lume.clamp(keypad.walkedDist + dt, 0, keypad.walkDist)
    if (keypad.walkedDist >= keypad.walkDist) then
      keypad.reachedKeypad()
    end
  end
end

function keypad:mousepressed(x, y, button)
  local halfScreenWidth, halfScreenHeight = love.graphics.getWidth()/2, love.graphics.getHeight()/2
  if (keypad.atKeypad) then
    local pressed = false
    if (helperLib.isInside(x, y, halfScreenWidth - 105, halfScreenHeight - 105, halfScreenWidth - 45, halfScreenHeight - 45)) then
      keypad.currentCode = keypad.currentCode .. "1"
      pressed = true
    elseif (helperLib.isInside(x, y, halfScreenWidth - 30, halfScreenHeight - 105, halfScreenWidth + 30, halfScreenHeight - 45)) then
      keypad.currentCode = keypad.currentCode .. "2"
      pressed = true
    elseif (helperLib.isInside(x, y, halfScreenWidth + 45, halfScreenHeight - 105, halfScreenWidth + 105, halfScreenHeight - 45)) then
      keypad.currentCode = keypad.currentCode .. "3"
      pressed = true
    elseif (helperLib.isInside(x, y, halfScreenWidth - 105, halfScreenHeight - 30, halfScreenWidth - 45, halfScreenHeight + 30)) then
      keypad.currentCode = keypad.currentCode .. "4"
      pressed = true
    elseif (helperLib.isInside(x, y, halfScreenWidth - 30, halfScreenHeight - 30, halfScreenWidth + 30, halfScreenHeight + 30)) then
      keypad.currentCode = keypad.currentCode .. "5"
      pressed = true
    elseif (helperLib.isInside(x, y, halfScreenWidth + 45, halfScreenHeight - 30, halfScreenWidth + 105, halfScreenHeight + 30)) then
      keypad.currentCode = keypad.currentCode .. "6"
      pressed = true
    elseif (helperLib.isInside(x, y, halfScreenWidth - 105, halfScreenHeight + 45, halfScreenWidth - 45, halfScreenHeight + 105)) then
      keypad.currentCode = keypad.currentCode .. "7"
      pressed = true
    elseif (helperLib.isInside(x, y, halfScreenWidth - 30, halfScreenHeight + 45, halfScreenWidth + 30, halfScreenHeight + 105)) then
      keypad.currentCode = keypad.currentCode .. "8"
      pressed = true
    elseif (helperLib.isInside(x, y, halfScreenWidth + 45, halfScreenHeight + 45, halfScreenWidth + 105, halfScreenHeight + 105)) then
      keypad.currentCode = keypad.currentCode .. "9"
      pressed = true
    end
    if (pressed) then
      if (keypad.currentCode:len() >= 4) then
        if (keypad.currentCode == keypad.code) then
          keypad.atKeypad = false
          keypad.correctCodeSound:play()
          Timer.after(keypad.correctCodeSound:getDuration('seconds')/2, function () keypad.doorOpened() end)
        else
          keypad.incorrectCodeSound:play()
          keypad.currentCode = ""
        end
      else 
        keypad.keypressSound:play()
      end
    end
  end
end

function keypad:keypressed(key)
  if (keypad.allowWalking and not keypad.walking and key == "w") then
    keypad.walking = true
    keypad.walkSound:play()
  end
end

function keypad:keyreleased(key)
  if (key == "w") then
    keypad.walking = false
    keypad.walkSound:pause()
  end
end

function keypad:complete()
end

function keypad:reachedKeypad()
  keypad.walkSound:stop()
  keypad.allowWalking = false
  keypad.walking = false
  keypad.dialogue.AI_doorReached.source:play()
  Timer.after(keypad.dialogue.AI_doorReached.delay, function ()
    keypad.atKeypad = true
  end)
end

function keypad:doorOpened()
  keypad.dialogue.AI_doorOpened.source:play()
  Timer.after(keypad.dialogue.AI_doorOpened.delay, function ()
    sceneHandler:goToScene("core")
  end)
end

return keypad