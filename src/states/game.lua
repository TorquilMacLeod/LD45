local sceneHandler = require 'src.libs.sceneHandler'

local game = {}

function game:init()
  love.graphics.setBackgroundColor(13/255, 13/255, 13/255)
end

function game:enter()
  sceneHandler.scenes.intro:init()
end

function game:draw()
  -- draw the scene first, then the UI
  sceneHandler.scenes[sceneHandler.currentScene]:draw()
  clickEvent:draw()
  keyTip:draw()
end

function game:update(dt)
  -- Update scene
  sceneHandler.scenes[sceneHandler.currentScene]:update(dt)

  -- Update libraries
  clickEvent:update(dt)
  keyTip:update(dt)
end


function game:mousepressed(x, y, button)
  sceneHandler.scenes[sceneHandler.currentScene]:mousepressed(x, y, button)
  clickEvent:mousepressed(x, y, button)
end

function game:keypressed(key)
  sceneHandler.scenes[sceneHandler.currentScene]:keypressed(key)
  keyTip:keypressed(key)
end

return game