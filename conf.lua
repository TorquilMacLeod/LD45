function love.conf(t)
  t.window.width = 1920
  t.window.height = 1080
  t.window.title = "Outlook"         -- The window title (string)
  t.window.icon = nil                 -- Filepath to an image to use as the window's icon (string)
  t.window.resizable = false          -- Let the window be user-resizable (boolean)
  t.window.fullscreen = true         -- Enable fullscreen (boolean)
  t.window.fullscreentype = "desktop" -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
  t.window.vsync = 1                  -- Vertical sync mode (number)
end