local intro = {
  dialogue = {
    AI_intro = {
      source = love.audio.newSource('assets/game/audio/speech/intro/AI_1.mp3', 'stream'),
    },
    AI_podOpened = {
      source = love.audio.newSource('assets/game/audio/speech/intro/AI_2.mp3', 'stream'),
    },
    AI_doorReached = {
      source = love.audio.newSource('assets/game/audio/speech/intro/AI_3.mp3', 'stream'),
    }
  },
  allowWalking = false,
  walking = false,
  walkedDist = 0,
  walkDist = 6
}

for k, v in pairs(intro.dialogue) do
  v.delay = v.source:getDuration('seconds') + 0.4
end

function intro:init()
  self.dialogue.AI_intro.source:play()
  Timer.after(self.dialogue.AI_intro.delay, function () clickEvent:start(intro.podOpened) end)
end

function intro:draw()
  love.graphics.setColor(1, 1, 1, 1)
end

function intro:update(dt)
  if (intro.walking) then
    intro.walkedDist = lume.clamp(intro.walkedDist + dt, 0, intro.walkDist)
    if (intro.walkedDist >= intro.walkDist) then
      intro.allowWalking = false
      intro.walking = false
      intro.reachedDoor()
    end
  end
end

function intro:mousepressed(x, y, button)
end

function intro:keypressed(key)
  if (intro.allowWalking and key == "w") then
    intro.walking = true
  end
end

function intro:keyreleased(key)
  if (key == "w") then
    intro.walking = false
  end
end

function intro:complete()
end

function intro:podOpened()
  intro.dialogue.AI_podOpened.source:play()
  Timer.after(intro.dialogue.AI_podOpened.delay, function ()
    keyTip:start("w") 
    intro.allowWalking = true
  end)
end

function intro:reachedDoor()
  intro.dialogue.AI_doorReached.source:play()
  Timer.after(intro.dialogue.AI_doorReached.delay, function ()
    sceneHandler.goToScene("core")
  end)
end

return intro