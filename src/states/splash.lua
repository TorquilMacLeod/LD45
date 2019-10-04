local splash = {}
local splashProperties = {}
splashProperties.totalLength = 6

function splash:init()
  print("splash init")
  Timer.after(splashProperties.totalLength, function() Gamestate.switch(menuGamestate) end)
end

function splash:enter()

end

function splash:draw()

end

function splash:update(dt)

end

function splash:mousepressed(x, y, button)
  
end

return splash