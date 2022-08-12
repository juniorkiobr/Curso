function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
    if not KeysAreDown("up", "w") then
        Player:get("MovementPlayer").up = false
    end
    if not KeysAreDown("down", "s") then
        Player:get("MovementPlayer").down = false
    end
    if not KeysAreDown("left", "a") then
        Player:get("MovementPlayer").left = false
    end
    if not KeysAreDown("right", "d") then
        Player:get("MovementPlayer").right = false
    end

    if not KeysAreDown("space", "return") then
        Player:get("MovementPlayer").space = false
    end
end

function KeysAreDown(k1, k2)
    return love.keyboard.isDown(k1) or love.keyboard.isDown(k2)
end

function DetectKeysPlayer()
    if KeysAreDown("up", "w") then
        Player:get("MovementPlayer").up = true
    end
    if KeysAreDown("left", "a") then
        Player:get("MovementPlayer").left = true
    end
    if KeysAreDown("right", "d") then
        Player:get("MovementPlayer").right = true
    end
    if KeysAreDown("down", "s") then
        Player:get("MovementPlayer").down = true
    end
    if KeysAreDown("space", "return") then
        Player:get("MovementPlayer").space = true
    end
end
