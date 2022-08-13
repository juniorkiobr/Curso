LarguraTela = love.graphics.getWidth()
AlturaTela = love.graphics.getHeight()
Speed = 10
BoolToNumber = {[true] = 1, [false] = 0}

function CalculateValocityDiagonal(dt, vertical_keys)
    if vertical_keys == nil then
        vertical_keys = false
    end
    local MovementPlayer = Player:get("MovementPlayer")

    if (vertical_keys) then
        return ((-0.5 * BoolToNumber[MovementPlayer.up or MovementPlayer.down]) + 1) * MovementPlayer.velocity * dt
    else
        return ((-0.5 * BoolToNumber[MovementPlayer.left or MovementPlayer.right]) + 1) * MovementPlayer.velocity * dt
    end
end

function TableLenght(t)
    local count = 0

    for _ in pairs(t) do
        count = count + 1
    end
    return count
end
