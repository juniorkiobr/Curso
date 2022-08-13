require "scripts.projectile"
require "scripts.classes.entity"

Player = newPlayer()
print("calling newPlayer()")
-- Player.__index = Player

function Player:new()
    -- print("Player:get(name): " .. Player:get("MovementPlayer"))
    Player:__tostring()
    Player:configure()
end

function Player:draw()
    DrawSprite(self.sprite)
    -- self:DrawProjectiles()
end

-- function Player:get(variable)
--     return self[variable]
-- end

function Player:configure()
    self.MovementPlayer = {
        up = false,
        down = false,
        left = false,
        right = false,
        space = false,
        velocity = 30 * Speed
    }
    self.sprite = CreateSprite(LarguraTela / 2, AlturaTela / 2, "Imagens/nave.png")
    self.projectiles = {}
    self.fireCoolDown = 0.7
end
function Player:move(dt)
    if (self.MovementPlayer.up and self.sprite.y - (self.MovementPlayer.velocity * dt) >= 0) then
        self.sprite.y = self.sprite.y - CalculateValocityDiagonal(dt, true)
    end
    if
        (self.MovementPlayer.down and
            (self.sprite.y + self.sprite.height) + (self.MovementPlayer.velocity * dt) <= AlturaTela)
     then
        self.sprite.y = self.sprite.y + CalculateValocityDiagonal(dt, true)
    end
    if (self.MovementPlayer.left and self.sprite.x - (self.MovementPlayer.velocity * dt) >= 0) then
        self.sprite.x = self.sprite.x - CalculateValocityDiagonal(dt)
    end
    if
        (self.MovementPlayer.right and
            (self.sprite.x + self.sprite.width) + (self.MovementPlayer.velocity * dt) <= LarguraTela)
     then
        self.sprite.x = self.sprite.x + CalculateValocityDiagonal(dt)
    end

    if (self.MovementPlayer.space) then
        if TableLenght(self.projectiles) < 5 and self.fireCoolDown <= 0 then
            local projectile = ConfigureProjectile({})
            projectile.x = self.sprite.x + (self.sprite.width / 2)
            projectile.y = self.sprite.y - projectile.height
            projectile.speed = projectile.speed * -1
            projectile.sfx:play()
            self.fireCoolDown = 0.5
            table.insert(self.projectiles, projectile)
        end
        self.fireCoolDown = self.fireCoolDown - 0.1
    end
end

function Player:DrawProjectiles()
    for _, projectile in pairs(self.projectiles) do
        DrawProjectile(projectile)
    end
end

function Player:UpdateProjectiles(dt)
    for index, projectile in pairs(self.projectiles) do
        UpdateProjectile(projectile, dt)
        if projectile.lifetime < 0 then
            table.remove(self.projectiles, index)
        end
    end
end
