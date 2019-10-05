local core = {
  dialogue = {
    player_cough = {
      source = love.audio.newSource('assets/game/audio/speech/core/player_1.mp3', 'stream'),
    },
    AI_doorReached = {
      source = love.audio.newSource('assets/game/audio/speech/core/AI_3.mp3', 'stream'),
    }
  },
  allowWalking = true,
  walking = false,
  walkedDist = 0,
  walkDist = 12
}

for k, v in pairs(core.dialogue) do
  v.delay = v.source:getDuration('seconds') + 0.4
end

function core:init()
  self.dialogue.AI_core.source:play()
  Timer.after(self.dialogue.AI_core.delay, function () clickEvent:start(core.podOpened) end)
end

function core:draw()
  love.graphics.setColor(1, 1, 1, 1)
end

function core:update(dt)
  if (core.walking) then
    core.walkedDist = lume.clamp(core.walkedDist + dt, 0, core.walkDist)
    if (core.walkedDist >= core.walkDist) then
      core.allowWalking = false
      core.walking = false
      core.reachedDoor()
    end
  end
end

function core:mousepressed(x, y, button)
end

function core:keypressed(key)
  if (core.allowWalking and key == "w") then
    core.walking = true
  end
end

function core:keyreleased(key)
  if (key == "w") then
    core.walking = false
  end
end

function core:complete()
end

function core:podOpened()
  core.dialogue.AI_podOpened.source:play()
  Timer.after(core.dialogue.AI_podOpened.delay, function ()
    keyTip:start("w") 
    core.allowWalking = true
  end)
end

function core:reachedDoor()
  core.dialogue.AI_doorReached.source:play()
  Timer.after(core.dialogue.AI_doorReached.delay, function ()
    sceneHandler.goToScene("core")
  end)
end

return core