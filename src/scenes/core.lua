local core = {
  dialogue = {
    attack = {
      source = love.audio.newSource('assets/game/audio/speech/core/attack.mp3', 'stream'),
    }
  },
  walkSound = love.audio.newSource('assets/game/audio/effects/walking.wav', 'static')
}

for k, v in pairs(core.dialogue) do
  v.delay = v.source:getDuration('seconds') + 0.4
end

function core:init()
  print "core"
end

function core:draw()
end

function core:update(dt)
end

function core:mousepressed(x, y, button)
end

function core:keypressed(key)
  if (not core.walking and key == "w") then
    core.walking = true
    core.walkSound:play()
  end
end

function core:keyreleased(key)
  if (key == "w") then
    core.walking = false
    core.walkSound:pause()
  end
end

function core:complete()
end

return core