require "scripts.inputs"
require "scripts.sprites"
require "scripts.utils"

require "scripts.background"
require "scripts.player"
-- require "scripts.enemy"

function love.load()
  ConfigBackground()
  ConfigurePlayer()
end

function love.update(dt)
  DetectKeysPlayer()
  RepeatBackground(dt)
  MoveBackground(dt)
  MovePlayer(dt)
  PlayerUpdateProjectiles(dt)
end

function love.draw()
  -- love.graphics.print("Hello World!", 10, 10)
  DrawBackground()
  DrawSprite(Player)
  PlayerDrawProjectiles()
end
