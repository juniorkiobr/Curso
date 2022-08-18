require "scripts.inputs"
require "scripts.sprites"
require "scripts.utils"

require "scripts.background"
require "scripts.classes.player"
require "scripts.classes.enemy"

function love.load()
  LoadGame()
end

function love.update(dt)
  DetectKeysPlayer()

  if (GameActive) then
    RepeatBackground(dt)
    MoveBackground(dt)
    Player:move(dt)
    Player:UpdateProjectiles(dt)
    UpdateAllEnemies(dt)
  end
end

function love.draw()
  if (GameActive) then
    DrawBackground()
    Player:draw()
    Player:DrawProjectiles()
    DrawAllEnemies()
  else
    love.graphics.print("Press fire to start", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2)
  end
end
