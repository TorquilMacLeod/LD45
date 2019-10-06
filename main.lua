-- Open Source Libs
lume = require 'src.libs.lume.lume'
Gamestate = require 'src.libs.hump.gamestate'
Timer = require 'src.libs.hump.timer'
Signal = require 'src.libs.hump.signal'
Camera = require 'src.libs.hump.camera'

DEBUG_FLAG = true

-- Custom libs
clickEvent = require 'src.libs.clickEvent'
keyTip = require 'src.libs.keyTip'
-- clickEvent:start(func) to start a click event
-- keyTip:start(tipType) to start a keytip

-- Game states
splashGamestate = require 'src.states.splash'
menuGamestate = require 'src.states.menu'
gameGamestate = require 'src.states.game'

-- Load assets
titleMusic = love.audio.newSource('assets/menu/audio/title.mp3', 'stream')
titleMusic:setVolume(0.7)

function love.load()
  Gamestate.registerEvents()
  Gamestate.switch(gameGamestate) -- DEBUG
  -- love.audio.play(titleMusic) -- DEBUG
end

function love.draw()
end

function love.update(dt)
  Timer.update(dt)
end

function love.quit()
end
