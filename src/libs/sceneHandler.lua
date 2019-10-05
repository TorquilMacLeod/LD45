-- Handles game scenarios in order to set the current dialogue, objective and other scene properties
local sceneHandler = {
  currentScene = "core" -- DEBUG
}


sceneHandler.scenes = {
  intro = require 'src.scenes.intro',
  keypad = require 'src.scenes.keypad',
  core = require 'src.scenes.core'
}

function sceneHandler:goToScene(scene)
  sceneHandler.currentScene = scene
  sceneHandler.scenes[scene]:init()
end

return sceneHandler