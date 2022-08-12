function ConfigBackground()
    Background = {
        image = love.graphics.newImage("Imagens/background.png"),
        width = LarguraTela,
        height = AlturaTela,
        x = 0,
        yImgA = 0,
        yImgB = 0 - AlturaTela,
        velocity = 30 * Speed
    }
    Background.width = Background.image:getWidth()
    Background.height = Background.image:getHeight()
    Background.yImgB = 0 - Background.height
end

function DrawBackground()
    love.graphics.draw(Background.image, Background.x, Background.yImgA)
    love.graphics.draw(Background.image, Background.x, Background.yImgB)
end

function RepeatBackground()
    if Background.yImgA > AlturaTela then
        print("yImgA: " .. Background.yImgA)
        Background.yImgA = (0 - Background.height)
        print("yImgA Changed: " .. Background.yImgA)
    end
    if Background.yImgB > AlturaTela then
        print("yImgB: " .. Background.yImgB)
        Background.yImgB = (0 - Background.height)
        print("yImgB Changed: " .. Background.yImgB)
    end
end

function MoveBackground(dt)
    Background.yImgA = Background.yImgA + Background.velocity * dt
    Background.yImgB = Background.yImgB + Background.velocity * dt
    -- print(Background.yImgA)
    -- print(Background.yImgB)
end
