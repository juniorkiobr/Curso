function CreateSprite(x, y, image_path)
    local image = love.graphics.newImage(image_path)
    local sprite = {}
    sprite.x = x
    sprite.y = y
    sprite.width = image:getWidth()
    sprite.height = image:getHeight()
    sprite.image = image
    sprite.quad = love.graphics.newQuad(0, 0, sprite.width, sprite.height, image:getDimensions())
    return sprite
end

function DrawSprite(sprite)
    love.graphics.draw(sprite.image, sprite.quad, sprite.x, sprite.y)
end
