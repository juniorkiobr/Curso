function CreateSprite(x, y, image_path)
    local image = love.graphics.newImage(image_path)
    local sprite = {}
    sprite.x = x
    sprite.y = y
    sprite.width = image:getWidth()
    sprite.height = image:getHeight()
    sprite.image = image
    sprite.rotation = 0
    sprite.mirrorX = false
    sprite.mirrorY = false
    sprite.scaleX = 1
    sprite.scaleY = 1
    sprite.offsetX = 0
    sprite.offsetY = 0
    return sprite
end

function MirrorX(sprite, mirrorX)
    sprite.mirrorX = mirrorX
    sprite.scaleX = (-2 * BoolToNumber[mirrorX]) + 1
    -- statements
end

function MirrorY(sprite, mirrorY)
    sprite.mirrorY = mirrorY
    sprite.scaleY = (-2 * BoolToNumber[mirrorY]) + 1
    -- statements
end

function UpdateX(sprite, x, offsetX)
    sprite.x = x
    sprite.offsetX = (BoolToNumber[sprite.mirrorX] * sprite.width) + offsetX
end

function UpdateY(sprite, y, offsetY)
    sprite.y = y
    sprite.offsetY = (BoolToNumber[sprite.mirrorY] * sprite.height) + offsetY
end

function DrawSprite(sprite)
    love.graphics.draw(
        sprite.image,
        sprite.x,
        sprite.y,
        sprite.rotation,
        sprite.scaleX,
        sprite.scaleY,
        sprite.offsetX,
        sprite.offsetY
    )
end
