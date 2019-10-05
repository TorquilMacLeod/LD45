local game = {}
local clickEvent = require 'src.libs.clickEvent'
-- clickEvent:start(func) to start a click event

local titleVolume = 1 --scale the title music volume down when the game state is entered until it is low

function game:init()
  love.graphics.setBackgroundColor(13/255, 13/255, 13/255)
end

function game:draw()
  clickEvent:draw()
end

function game:update(dt)
  -- Update libraries
  clickEvent:update(dt)

  if (titleVolume >= 0.2) then
    titleVolume = titleVolume - (dt / 2)
    titleMusic:setVolume(titleVolume)
  end
end


function game:mousepressed(x, y, button)
  clickEvent:mousepressed(x, y, button)
end

return game