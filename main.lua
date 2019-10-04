Gamestate = require "libs.hump.gamestate"
Timer = require "libs.hump.timer"
menuGamestate = require "src.states.menu"
splashGamestate = require "src.states.splash"

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(splashGamestate)
end

function love.draw()
end

function love.update(dt)
  Timer.update(dt)
end

function love.quit()
end
