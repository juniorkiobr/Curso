function ConfigurePlayer()
    MovementPlayer = {
        up = false,
        down = false,
        left = false,
        right = false,
        velocity = 30 * Speed
    }
    Player = CreateSprite(LarguraTela / 2, AlturaTela / 2, "Imagens/nave.png")
end
function MovePlayer(dt)
    if (MovementPlayer.up and Player.y - (MovementPlayer.velocity * dt) >= 0) then
        Player.y = Player.y - CalculateValocityDiagonal(dt, true)
    end
    if (MovementPlayer.down and (Player.y + Player.height) + (MovementPlayer.velocity * dt) <= AlturaTela) then
        Player.y = Player.y + CalculateValocityDiagonal(dt, true)
    end
    if (MovementPlayer.left and Player.x - (MovementPlayer.velocity * dt) >= 0) then
        Player.x = Player.x - CalculateValocityDiagonal(dt)
    end
    if (MovementPlayer.right and (Player.x + Player.width) + (MovementPlayer.velocity * dt) <= LarguraTela) then
        Player.x = Player.x + CalculateValocityDiagonal(dt)
    end
end
