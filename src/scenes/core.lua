local core = {
  dialogue = {
    attack = {
      source = love.audio.newSource('assets/game/audio/speech/core/AI_1.mp3', 'stream'),
      hitFlashTime = 6.35 -- seconds into the mp3 that the punch happens, used for timing visual effect
    },
    AI_afterClap = {
      source = love.audio.newSource('assets/game/audio/speech/core/AI_2.mp3', 'stream')
    }
  },
  walkSound = love.audio.newSource('assets/game/audio/effects/walking.wav', 'static'),
  punchProperties = {
    hit = false,
    hitColor = {0.8, 0.2, 0.2, 1},
    hitFadeColor = {0.8, 0.2, 0.2, 0},
    hitTime = 4,
    hitFadeTime = 4
  },
  movement = {
    allowMovement = false,
    moving = false,
    direction = {w = false, a = false, s = false, d = false},
    playerX = 0,
    playerY = 0,
    playerSpeed = 100,
    playerSize = 15,
    movementKeys = {w = true, a = true, s = true, d = true},
    allowClap = false,
    clapped = false,
    clapCooldownTime = 2,
    timeToClap = 0,
    firstClap = true,
    clapSound = love.audio.newSource('assets/game/audio/effects/clap.wav', 'static')
  },
  debugFont = love.graphics.newFont()
}

-- Set up HUMP lib camera
core.movement.camera = Camera(core.movement.playerX, core.movement.playerY)

for k, v in pairs(core.dialogue) do
  v.delay = v.source:getDuration('seconds') + 0.4
end

function core:init()
  love.graphics.setFont(core.debugFont)
  self.dialogue.attack.source:play()
  Timer.after(self.dialogue.attack.hitFlashTime, function () core.punched() end)
  Timer.after(self.dialogue.attack.delay, function () core.allowClap() end)
end

function core:draw()
  if (core.punchProperties.hit) then
    love.graphics.setColor(core.punchProperties.hitColor)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  end
  if (core.movement.allowMovement) then
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("x: " .. core.movement.playerX, 10, 10)
    love.graphics.print("y: " .. core.movement.playerY, 10, 30)
    love.graphics.print("w: " .. tostring(core.movement.direction.w), 10, 50)
    love.graphics.print("a: " .. tostring(core.movement.direction.a), 10, 70)
    love.graphics.print("s: " .. tostring(core.movement.direction.s), 10, 90)
    love.graphics.print("d: " .. tostring(core.movement.direction.d), 10, 110)
    core.movement.camera:attach()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.circle('line', core.movement.playerX, core.movement.playerY, core.movement.playerSize)
    core.movement.camera:detach()
    
  end
end

function core:update(dt)
  if (core.punchProperties.hit) then
    core.punchProperties.hitTime = lume.clamp(core.punchProperties.hitTime - dt, 0, 100)
    if (core.punchProperties.hitTime <= 0) then
      core.punchProperties.hit = false
    end
  end
  if (core.movement.clapped) then
    core.movement.timeToClap = lume.clamp(core.movement.timeToClap - dt, 0, core.movement.clapCooldownTime)
    if (core.movement.timeToClap <= 0) then
      core.movement.clapped = false
    end
  end
  if (love.keyboard.isDown("w")) then
    core.movement.playerY = core.movement.playerY - (dt * core.movement.playerSpeed)
  end
  if (love.keyboard.isDown("a")) then
    core.movement.playerX = core.movement.playerX - (dt * core.movement.playerSpeed)
  end
  if (love.keyboard.isDown("s")) then
    core.movement.playerY = core.movement.playerY + (dt * core.movement.playerSpeed)
  end
  if (love.keyboard.isDown("d")) then
    core.movement.playerX = core.movement.playerX + (dt * core.movement.playerSpeed)
  end
  -- Update camera position
  core.movement.camera:lookAt(core.movement.playerX, core.movement.playerY)
end

function core:mousepressed(x, y, button)
end

function core:keypressed(key)
  if (core.movement.movementKeys[key] == true) then
    core.movement.moving = true
    core.movement.direction[key] = true
    if (not core.walkSound:isPlaying()) then
      core.walkSound:play()
      core.walkSound:setLooping(true)
    end
  elseif (core.movement.allowClap and key == "e") then
    core:clap()
  end
end

function core:keyreleased(key)
  if (core.movement.moving and core.movement.movementKeys[key] == true) then
    core.movement.direction[key] = false
    if (lume.all(core.movement.direction, function(isFalse) return not isFalse end)) then
      core.movement.moving = false
      core.walkSound:pause()
    end
  end
end

function core:complete()
end

function core:punched()
  Timer.tween(core.punchProperties.hitFadeTime, core.punchProperties.hitColor, core.punchProperties.hitFadeColor, 'in-quint')
  core.punchProperties.hit = true
end

function core:allowClap()
  core.movement.allowClap = true
  keyTip:start("e")
end

function core:clap()
  core.movement.clapped = true
  core.movement.timeToClap = core.movement.clapCooldownTime
  core.movement.clapSound:play()
  if (core.movement.firstClap) then
    core:startMovement()
    core.movement.firstClap = false
  end
end

function core:startMovement()
  core.dialogue.AI_afterClap.source:play()
  core.movement.allowMovement = true
  keyTip:start("wasd")
end

return core