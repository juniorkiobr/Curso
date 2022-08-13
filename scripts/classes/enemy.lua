require "scripts.classes.entity"
require "scripts.projectile"

Enemy = newEnemy()

function Enemy:new()
    Enemy:__tostring()
    Enemy:configure()
end

function Enemy:draw()
    DrawSprite(self.sprite)
    self:DrawProjectiles()
end

function Enemy:configure()
    self.MovementEnemy = {
        up = false,
        down = false,
        left = false,
        right = false,
        delayPursuit = 0,
        velocity = 30 * Speed
    }
    self.sprite = CreateSprite(0, 0, "Imagens/inimigo.png")
    self.projectiles = {}
    self.fireCoolDown = 0.7
end

function Enemy:DecideMovement(dt)
    local pPos = {
        x = Player:get("sprite").x,
        y = Player:get("sprite").y
    }
    pPos.enemyDirection = {
        x = pPos.x - self.sprite.x,
        y = pPos.y - self.sprite.y - self.sprite.height - 70
    }
    pPos.distance = math.sqrt((pPos.enemyDirection.x ^ 2) + (pPos.enemyDirection.y ^ 2))

    if (math.floor(pPos.distance) ~= 0) and self.MovementEnemy.delayPursuit <= 0 then
        self.sprite.x =
            self.sprite.x + pPos.enemyDirection.x / pPos.distance * math.floor(self.MovementEnemy.velocity * dt)
        self.sprite.y =
            self.sprite.y + pPos.enemyDirection.y / pPos.distance * math.floor(self.MovementEnemy.velocity * dt)
        print("distance :", pPos.distance)
        print("x, y:", self.sprite.x, self.sprite.y)
    else
        if self.MovementEnemy.delayPursuit <= 0 then
            self.MovementEnemy.delayPursuit = 1.2
        else
            Enemy:fire()
        end
    end
    if self.MovementEnemy.delayPursuit > 0 then
        self.MovementEnemy.delayPursuit = self.MovementEnemy.delayPursuit - dt
    end
end

function Enemy:fire()
    if TableLenght(self.projectiles) < 5 and self.fireCoolDown <= 0 then
        local projectile = ConfigureProjectile({})
        projectile.x = self.sprite.x + (self.sprite.width / 2)
        projectile.y = self.sprite.y + projectile.height
        projectile.speed = projectile.speed
        projectile.sfx:play()
        self.fireCoolDown = 0.5
        table.insert(self.projectiles, projectile)
    end
    self.fireCoolDown = self.fireCoolDown - 0.1
end

function Enemy:UpdateProjectiles(dt)
    for i, projectile in ipairs(self.projectiles) do
        UpdateProjectile(projectile, dt)
        if projectile.lifetime < 0 then
            table.remove(self.projectiles, index)
        end
        -- if projectile.x < 0 or projectile.x > LarguraTela or projectile.y < 0 or projectile.y > AlturaTela then
        --     table.remove(self.projectiles, i)
        -- end
    end
end

function Enemy:Update(dt)
    self:DecideMovement(dt)
    -- self:move(dt)
    self:UpdateProjectiles(dt)
end

function Enemy:DrawProjectiles()
    for _, projectile in pairs(self.projectiles) do
        DrawProjectile(projectile)
    end
end
