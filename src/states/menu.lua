local menu = {}
local menuProperties = {}
menuProperties.titleFadeInTime = 2.6
menuProperties.loaded = false
menuProperties.showCredits = false
menuProperties.optionFadeInTime = 4
menuProperties.fadeOutTime = 2.6
menuProperties.titleAlpha = 0
menuProperties.optionAlpha = 0
menuProperties.titleFont = love.graphics.newFont('assets/menu/fonts/Roboto-BoldItalic.ttf', 144)
menuProperties.titleFontHeight = menuProperties.titleFont:getHeight()
menuProperties.optionFont = love.graphics.newFont('assets/menu/fonts/SpaceMono-Bold.ttf', 36)
menuProperties.optionFontHeight = menuProperties.optionFont:getHeight()

menuProperties.options = {
  {
    text = "Start",
    x = 140,
    y = 160 + (menuProperties.titleFontHeight * 2),
    option = true,
    hover = false,
    click = function ()
      Timer.tween(menuProperties.fadeOutTime, menuProperties, { titleAlpha = 0, optionAlpha = 0 }, 'out-quad', function() Gamestate.switch(gameGamestate) end)
    end
  },
  {
    text = "Credits",
    x = 140,
    y = 170 + (menuProperties.titleFontHeight * 2) + menuProperties.optionFontHeight,
    option = true,
    hover = false,
    click = function ()
      menuProperties.showCredits = true
    end
  },
  {
    text = "Quit Game",
    x = 140,
    y = 180 + (menuProperties.titleFontHeight * 2) + (menuProperties.optionFontHeight * 2),
    option = true,
    hover = false,
    click = function ()
      love.event.quit(0)
    end
  }
}

menuProperties.creditOptions = {
  {
    text = "Music by Arda Güler",
    x = 140,
    y = 160 + (menuProperties.titleFontHeight * 2),
    option = false,
    hover = false,
    click = function ()
    end
  },
  {
    text = "Fonts from Google Fonts",
    x = 140,
    y = 170 + (menuProperties.titleFontHeight * 2) + menuProperties.optionFontHeight,
    option = false,
    hover = false,
    click = function ()
    end
  },
  {
    text = "Back",
    x = 140,
    y = 380 + (menuProperties.titleFontHeight * 2) + (menuProperties.optionFontHeight * 2),
    option = true,
    hover = false,
    click = function ()
      menuProperties.showCredits = false
    end
  }
}

function menu:init()
  love.graphics.setBackgroundColor(13/255, 13/255, 13/255)
  Timer.tween(menuProperties.titleFadeInTime, menuProperties, { titleAlpha = 1 }, 'in-quint')
  Timer.tween(menuProperties.optionFadeInTime, menuProperties, { optionAlpha = 1 }, 'in-quint', function () menuProperties.loaded = true end)
end

function menu:draw()
  if (not menuProperties.showCredits) then
    -- Draw menu items
    love.graphics.setColor(0.85, 0.85, 0.85, menuProperties.titleAlpha)
    love.graphics.setFont(menuProperties.titleFont)
    love.graphics.print("Outlook", 120, 120)

    love.graphics.setFont(menuProperties.optionFont)

    for k, v in pairs(menuProperties.options) do
      if (v.hover) then
        love.graphics.setColor(0.9, 0.9, 0.9, menuProperties.optionAlpha)
      else
        love.graphics.setColor(0.65, 0.65, 0.65, menuProperties.optionAlpha)
      end
      love.graphics.print(v.text, v.x, v.y)
    end
  else
    -- Draw credits items
    love.graphics.setColor(0.85, 0.85, 0.85, menuProperties.titleAlpha)
    love.graphics.setFont(menuProperties.titleFont)
    love.graphics.print("Outlook", 120, 120)

    love.graphics.setFont(menuProperties.optionFont)

    for k, v in pairs(menuProperties.creditOptions) do
      if (v.hover) then
        love.graphics.setColor(0.9, 0.9, 0.9, 1)
      else
        love.graphics.setColor(0.65, 0.65, 0.65, 1)
      end
      love.graphics.print(v.text, v.x, v.y)
    end

  end
end

function menu:update(dt)
  if (menuProperties.loaded) then
    local mouseX, mouseY = love.mouse.getPosition()
    if (not menuProperties.showCredits) then
      for k, v in pairs(menuProperties.options) do
        if (mouseX >= v.x and mouseX <= (v.x + menuProperties.optionFont:getWidth(v.text)) and mouseY >= v.y and mouseY <= (v.y + menuProperties.optionFontHeight) and v.option == true) then
          v.hover = true
        else
          v.hover = false
        end
      end
    else
      for k, v in pairs(menuProperties.creditOptions) do
        if (mouseX >= v.x and mouseX <= (v.x + menuProperties.optionFont:getWidth(v.text)) and mouseY >= v.y and mouseY <= (v.y + menuProperties.optionFontHeight) and v.option == true) then
          v.hover = true
        else
          v.hover = false
        end
      end
    end
  end
end

function menu:mousepressed(x, y, button)
  if (menuProperties.loaded) then
    if (not menuProperties.showCredits) then
      if (button == 1) then
        for k, v in pairs(menuProperties.options) do
          if (v.hover) then
            v.click()
          end
        end
      end
    else
      if (button == 1) then
        for k, v in pairs(menuProperties.creditOptions) do
          if (v.hover) then
            v.click()
          end
        end
      end
    end
  end
end

return menu