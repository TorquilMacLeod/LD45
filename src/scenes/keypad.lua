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
  keypadTip = love.graphics.newImage('assets/game/graphics/UI/keypadTip.png')
}

for k, v in pairs(keypad.dialogue) do
  v.delay = v.source:getDuration('seconds') + 0.4
end

function keypad:init()
end

function keypad:draw()
  if (keypad.atKeypad) then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(keypad.keypadTip, love.graphics.getWidth() - 200, love.graphics.getHeight() - 200)
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
  -- local halfScreenWidth, halfScreenHeight = love.graphics.getWidth()/2, love.graphics.getHeight()/2
  -- if (keypad.atKeypad) then
  --   local pressed = false
  --   if (helperLib.isInside(x, y, halfScreenWidth - 105, halfScreenHeight - 105, halfScreenWidth - 45, halfScreenHeight - 45)) then
  --     keypad.currentCode = keypad.currentCode .. "1"
  --     pressed = true
  --   elseif (helperLib.isInside(x, y, halfScreenWidth - 30, halfScreenHeight - 105, halfScreenWidth + 30, halfScreenHeight - 45)) then
  --     keypad.currentCode = keypad.currentCode .. "2"
  --     pressed = true
  --   elseif (helperLib.isInside(x, y, halfScreenWidth + 45, halfScreenHeight - 105, halfScreenWidth + 105, halfScreenHeight - 45)) then
  --     keypad.currentCode = keypad.currentCode .. "3"
  --     pressed = true
  --   elseif (helperLib.isInside(x, y, halfScreenWidth - 105, halfScreenHeight - 30, halfScreenWidth - 45, halfScreenHeight + 30)) then
  --     keypad.currentCode = keypad.currentCode .. "4"
  --     pressed = true
  --   elseif (helperLib.isInside(x, y, halfScreenWidth - 30, halfScreenHeight - 30, halfScreenWidth + 30, halfScreenHeight + 30)) then
  --     keypad.currentCode = keypad.currentCode .. "5"
  --     pressed = true
  --   elseif (helperLib.isInside(x, y, halfScreenWidth + 45, halfScreenHeight - 30, halfScreenWidth + 105, halfScreenHeight + 30)) then
  --     keypad.currentCode = keypad.currentCode .. "6"
  --     pressed = true
  --   elseif (helperLib.isInside(x, y, halfScreenWidth - 105, halfScreenHeight + 45, halfScreenWidth - 45, halfScreenHeight + 105)) then
  --     keypad.currentCode = keypad.currentCode .. "7"
  --     pressed = true
  --   elseif (helperLib.isInside(x, y, halfScreenWidth - 30, halfScreenHeight + 45, halfScreenWidth + 30, halfScreenHeight + 105)) then
  --     keypad.currentCode = keypad.currentCode .. "8"
  --     pressed = true
  --   elseif (helperLib.isInside(x, y, halfScreenWidth + 45, halfScreenHeight + 45, halfScreenWidth + 105, halfScreenHeight + 105)) then
  --     keypad.currentCode = keypad.currentCode .. "9"
  --     pressed = true
  --   end
  --   if (pressed) then
  --     if (keypad.currentCode:len() >= 4) then
  --       if (keypad.currentCode == keypad.code) then
  --         keypad.atKeypad = false
  --         keypad.correctCodeSound:play()
  --         Timer.after(keypad.correctCodeSound:getDuration('seconds')/2, function () keypad.doorOpened() end)
  --       else
  --         keypad.incorrectCodeSound:play()
  --         keypad.currentCode = ""
  --       end
  --     else 
  --       keypad.keypressSound:play()
  --     end
  --   end
  -- end
end

function keypad:keypressed(key)
  if (keypad.allowWalking and not keypad.walking and key == "w") then
    keypad.walking = true
    keypad.walkSound:play()
  end
  if (keypad.atKeypad) then
    if (key == "0" or key == "kp0") then
      keypad.currentCode = keypad.currentCode .. "0"
    elseif (key == "1" or key == "kp1") then
      keypad.currentCode = keypad.currentCode .. "1"
    elseif (key == "2" or key == "kp2") then
      keypad.currentCode = keypad.currentCode .. "2"
    elseif (key == "3" or key == "kp3") then
      keypad.currentCode = keypad.currentCode .. "3"
    elseif (key == "4" or key == "kp4") then
      keypad.currentCode = keypad.currentCode .. "4"
    elseif (key == "5" or key == "kp5") then
      keypad.currentCode = keypad.currentCode .. "5"
    elseif (key == "6" or key == "kp6") then
      keypad.currentCode = keypad.currentCode .. "6"
    elseif (key == "7" or key == "kp7") then
      keypad.currentCode = keypad.currentCode .. "7"
    elseif (key == "8" or key == "kp8") then
      keypad.currentCode = keypad.currentCode .. "8"
    elseif (key == "9" or key == "kp9") then
      keypad.currentCode = keypad.currentCode .. "9"
    end
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