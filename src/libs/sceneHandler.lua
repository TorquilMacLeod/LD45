-- Handles game scenarios in order to set the current dialogue, objective and other scene properties
local sceneHandler = {
  currentScene = "intro"
}


sceneHandler.scenes = {
  intro = require 'src.scenes.intro'
}

function sceneHandler:goToScene(scene)
  sceneHandler.currentScene = scene
  sceneHandler.scenes[scene]:init()
end

return sceneHandler