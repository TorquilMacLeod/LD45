lume = require 'src.libs.lume.lume'
Gamestate = require 'src.libs.hump.gamestate'
Timer = require 'src.libs.hump.timer'
Signal = require 'src.libs.hump.signal'
splashGamestate = require 'src.states.splash'
menuGamestate = require 'src.states.menu'
gameGamestate = require 'src.states.game'

titleMusic = love.audio.newSource('assets/menu/audio/title.mp3', 'stream')
titleMusic:setVolume(0.7)

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(splashGamestate)
  love.audio.play(titleMusic)
end

function love.draw()
end

function love.update(dt)
  Timer.update(dt)
end

function love.quit()
end
