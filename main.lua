Gamestate = require "libs.hump.gamestate"
Timer = require "libs.hump.timer"
splashGamestate = require "src.states.splash"
menuGamestate = require "src.states.menu"

titleMusic = love.audio.newSource('assets/menu/audio/title.mp3', 'stream')

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(menuGamestate)
  love.audio.play(titleMusic)
end

function love.draw()
end

function love.update(dt)
  Timer.update(dt)
end

function love.quit()
end
