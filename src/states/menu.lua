local menu = {}
local menuProperties = {}
menuProperties.totalLength = 5

function menu:init()
  print("menu init")
  Timer.after(menuProperties.totalLength, function() Gamestate.switch(menu) end)
end

function menu:enter()

end

function menu:draw()

end

function menu:update(dt)

end

function menu:mousepressed(x, y, button)
  
end

return menu