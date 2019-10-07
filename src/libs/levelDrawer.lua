local levelDrawer = {
  currentLevel = nil,
  levels = {
    core = require 'src.levels.core'
  },
  tiles = {
    {
      solid = false,
      color = {1, 1, 1, 0}
    },
    {
      solid = false,
      color = {1, 1, 1, 0.4}
    }
  },
  sounds = {},
  soundRadius = 10,
  numRaysPerSound = 12,
  raySpeed = 10
}

function levelDrawer:addSound(x, y, volume)
  local volume = volume or 1
  local newSound = {
    volume = volume,
    originX = x,
    originY = y,
    rays = {}
  }
  -- Add rays to sound in circle
  for i = 0, levelDrawer.numRaysPerSound do
    local a = (2 * math.pi / i)
    local ray = {}
    ray.position = Vector.new(math.sin(a), math.cos(a))
    ray.velocity = Vector.new(math.sin(a), math.cos(a)):normalized()
    table.insert(newSound.rays, ray)
  end
  table.insert(levelDrawer.sounds, newSound)
end

function levelDrawer:update(dt)
  for ind, sound in ipairs(sounds) do
    for rayInd, ray in ipairs(sound.rays) do
      sounds.rays[rayInd].position = sounds.rays[rayInd].position + (sounds.rays[rayInd].velocity * dt)
      if (levelDrawer:isTouchingWalls(sounds.rays[rayInd].position.x, sounds.rays[rayInd].position.y)) then
        sounds.rays[rayInd].hit = true
      end
    end
  end
end

function levelDrawer:draw()
  if (levelDrawer.currentLevel) then
    local curLevel = levelDrawer.levels[levelDrawer.currentLevel]
    for y, row in ipairs(curLevel) do
      for x, tileID in ipairs(row) do
        love.graphics.setColor(levelDrawer.tiles[tileID].color)
        love.graphics.rectangle('fill', (-300 + (x * 60)), (-300 + (y * 60)), 60, 60)
      end
    end
  end
end

function levelDrawer:loadLevel(level)
  levelDrawer.currentLevel = level
end

return levelDrawer