require "scripts.inputs"
require "scripts.sprites"
require "scripts.utils"

require "scripts.background"
require "scripts.classes.player"
require "scripts.classes.enemy"

function love.load()
  ConfigBackground()
  Player:new()
  Enemy:new()
end

function love.update(dt)
  DetectKeysPlayer()
  RepeatBackground(dt)
  MoveBackground(dt)
  Player:move(dt)
  Player:UpdateProjectiles(dt)
  Enemy:Update(dt)
end

function love.draw()
  DrawBackground()
  Player:draw()
  Player:DrawProjectiles()
  Enemy:draw()
end
