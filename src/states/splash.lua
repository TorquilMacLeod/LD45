local splash = {}

local cardOneProperties = {}
cardOneProperties.cardSpinEndX = (love.graphics.getWidth()/2) + 100
cardOneProperties.cardSpinEndY = (love.graphics.getHeight()/2) - 40
cardOneProperties.cardSpinEndScale = 0.4
cardOneProperties.cardSpinEndRot = 18
cardOneProperties.cardSpinLength = 1.8
cardOneProperties.cardX = (love.graphics.getWidth()/2) - 240
cardOneProperties.cardY = (love.graphics.getHeight()/2) + 110
cardOneProperties.cardRot = 0
cardOneProperties.cardScale = 0.8
cardOneProperties.cardImage = love.graphics.newImage('assets/splash/graphics/card.png')
cardOneProperties.cardWidth, cardOneProperties.cardHeight = cardOneProperties.cardImage:getDimensions()
cardOneProperties.cardOriginX = cardOneProperties.cardWidth/2
cardOneProperties.cardOriginY = cardOneProperties.cardHeight/2

local cardTwoProperties = {}
cardTwoProperties.cardSpinEndX = (love.graphics.getWidth()/2) + 300
cardTwoProperties.cardSpinEndY = (love.graphics.getHeight()/2) - 200
cardTwoProperties.cardSpinEndScale = 0.4
cardTwoProperties.cardSpinEndRot = 20
cardTwoProperties.cardSpinLength = 1.1
cardTwoProperties.cardX = (love.graphics.getWidth()/2) - 10
cardTwoProperties.cardY = (love.graphics.getHeight()/2) + 200
cardTwoProperties.cardRot = 0
cardTwoProperties.cardScale = 0.78
cardTwoProperties.cardImage = love.graphics.newImage('assets/splash/graphics/card.png')
cardTwoProperties.cardWidth, cardTwoProperties.cardHeight = cardTwoProperties.cardImage:getDimensions()
cardTwoProperties.cardOriginX = cardTwoProperties.cardWidth/2
cardTwoProperties.cardOriginY = cardTwoProperties.cardHeight/2

local cardThreeProperties = {}
cardThreeProperties.cardSpinEndX = (love.graphics.getWidth()/2) - 40
cardThreeProperties.cardSpinEndY = (love.graphics.getHeight()/2) + 100
cardThreeProperties.cardSpinEndScale = 0.4
cardThreeProperties.cardSpinEndRot = -25
cardThreeProperties.cardSpinLength = 1.9
cardThreeProperties.cardX = (love.graphics.getWidth()/2) + 270
cardThreeProperties.cardY = (love.graphics.getHeight()/2) - 220
cardThreeProperties.cardRot = 0
cardThreeProperties.cardScale = 0.6
cardThreeProperties.cardImage = love.graphics.newImage('assets/splash/graphics/card.png')
cardThreeProperties.cardWidth, cardThreeProperties.cardHeight = cardThreeProperties.cardImage:getDimensions()
cardThreeProperties.cardOriginX = cardThreeProperties.cardWidth/2
cardThreeProperties.cardOriginY = cardThreeProperties.cardHeight/2

local fadeProperties = {}
fadeProperties.alpha = 0

local splashProperties = {}
splashProperties.totalSpinLength = 1.9
splashProperties.totalFadeLength = 2.4
splashProperties.backgroundImage = love.graphics.newImage('assets/splash/graphics/background.png')

function splash:init()
  love.graphics.setBackgroundColor(13/255, 13/255, 13/255)

  Timer.tween(cardOneProperties.cardSpinLength, cardOneProperties, { cardScale = cardOneProperties.cardSpinEndScale }, 'out-quad')
  Timer.tween(cardOneProperties.cardSpinLength, cardOneProperties, { cardRot = cardOneProperties.cardSpinEndRot }, 'linear')
  Timer.tween(cardOneProperties.cardSpinLength, cardOneProperties, { cardY = cardOneProperties.cardSpinEndY }, 'out-in-back')
  Timer.tween(cardOneProperties.cardSpinLength, cardOneProperties, { cardX = cardOneProperties.cardSpinEndX }, 'in-out-quart')

  Timer.tween(cardTwoProperties.cardSpinLength, cardTwoProperties, { cardScale = cardTwoProperties.cardSpinEndScale }, 'out-quad')
  Timer.tween(cardTwoProperties.cardSpinLength, cardTwoProperties, { cardRot = cardTwoProperties.cardSpinEndRot }, 'linear')
  Timer.tween(cardTwoProperties.cardSpinLength, cardTwoProperties, { cardY = cardTwoProperties.cardSpinEndY }, 'out-in-back')
  Timer.tween(cardTwoProperties.cardSpinLength, cardTwoProperties, { cardX = cardTwoProperties.cardSpinEndX }, 'in-out-quart')

  Timer.tween(cardThreeProperties.cardSpinLength, cardThreeProperties, { cardScale = cardThreeProperties.cardSpinEndScale }, 'out-quad')
  Timer.tween(cardThreeProperties.cardSpinLength, cardThreeProperties, { cardRot = cardThreeProperties.cardSpinEndRot }, 'linear')
  Timer.tween(cardThreeProperties.cardSpinLength, cardThreeProperties, { cardY = cardThreeProperties.cardSpinEndY }, 'out-in-back')
  Timer.tween(cardThreeProperties.cardSpinLength, cardThreeProperties, { cardX = cardThreeProperties.cardSpinEndX }, 'in-out-quart')
  Timer.after(splashProperties.totalSpinLength + 1, splash.fadeOut)
end

function splash:fadeOut()
  Timer.tween(splashProperties.totalFadeLength, fadeProperties, { alpha = 1 }, 'linear', splash.moveToMenu)
end

function splash:moveToMenu()
  Gamestate.switch(menuGamestate)
end

function splash:draw()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(splashProperties.backgroundImage, 0, 0)
  love.graphics.draw(cardOneProperties.cardImage, cardOneProperties.cardX, cardOneProperties.cardY, cardOneProperties.cardRot, cardOneProperties.cardScale, cardOneProperties.cardScale, cardOneProperties.cardOriginX, cardOneProperties.cardOriginY)
  love.graphics.draw(cardTwoProperties.cardImage, cardTwoProperties.cardX, cardTwoProperties.cardY, cardTwoProperties.cardRot, cardTwoProperties.cardScale, cardTwoProperties.cardScale, cardTwoProperties.cardOriginX, cardTwoProperties.cardOriginY)
  love.graphics.draw(cardThreeProperties.cardImage, cardThreeProperties.cardX, cardThreeProperties.cardY, cardThreeProperties.cardRot, cardThreeProperties.cardScale, cardThreeProperties.cardScale, cardThreeProperties.cardOriginX, cardThreeProperties.cardOriginY)
  love.graphics.setColor(13/255, 13/255, 13/255, fadeProperties.alpha)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

return splash