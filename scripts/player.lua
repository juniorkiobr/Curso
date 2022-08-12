require "scripts.projectile"

function ConfigurePlayer()
    MovementPlayer = {
        up = false,
        down = false,
        left = false,
        right = false,
        space = false,
        velocity = 30 * Speed
    }
    Player = CreateSprite(LarguraTela / 2, AlturaTela / 2, "Imagens/nave.png")
    Player.projectiles = {}
    Player.fireCoolDown = 0.5
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

    if (MovementPlayer.space) then
        if TableLenght(Player.projectiles) < 5 and Player.fireCoolDown <= 0 then
            local projectile = ConfigureProjectile({})
            projectile.x = Player.x + (Player.width / 2)
            projectile.y = Player.y - projectile.height
            projectile.speed = projectile.speed * -1
            projectile.sfx:play()
            Player.fireCoolDown = 0.5
            table.insert(Player.projectiles, projectile)
        end
        Player.fireCoolDown = Player.fireCoolDown - 0.1
    end
end

function PlayerDrawProjectiles()
    for _, projectile in pairs(Player.projectiles) do
        DrawProjectile(projectile)
    end
end

function PlayerUpdateProjectiles(dt)
    for index, projectile in pairs(Player.projectiles) do
        UpdateProjectile(projectile, dt)
        if projectile.lifetime < 0 then
            table.remove(Player.projectiles, index)
        end
    end
end
