require "scripts.background"
require "scripts.inputs"
require "scripts.player"
-- require "scripts.enemy"
require "scripts.sprites"
require "scripts.utils"

function love.load()
  ConfigBackground()
  ConfigurePlayer()
end

function love.update(dt)
  DetectKeysPlayer()
  RepeatBackground(dt)
  MoveBackground(dt)
  MovePlayer(dt)
end

function love.draw()
  -- love.graphics.print("Hello World!", 10, 10)
  DrawBackground()
  DrawSprite(Player)
end
