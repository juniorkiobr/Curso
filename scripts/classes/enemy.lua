require "scripts.classes.entity"
require "scripts.projectile"

Enemies = {}
Enemy = newEnemy()

function DrawAllEnemies()
    for i, enemy in ipairs(Enemies) do
        enemy:draw()
    end
end

function UpdateAllEnemies(dt)
    for i, enemy in ipairs(Enemies) do
        enemy:Update(dt)
    end
end

function GetEnemyNearProjectile(projectile)
    for i, enemy in ipairs(Enemies) do
        if enemy:isNear(projectile) then
            return i, enemy
        end
    end
    return nil
end

function InsertEnemy(enemy)
    if TableLenght(Enemies) <= 9 then
        table.insert(Enemies, enemy)
    end
end

-- function Enemy:isNear(projectile)
--     return self.sprite.x < projectile.sprite.x + projectile.sprite.width and
--         self.sprite.x + self.sprite.width > projectile.sprite.x and
--         self.sprite.y < projectile.sprite.y + projectile.sprite.height and
--         self.sprite.y + self.sprite.height > projectile.sprite.y
-- end

function Enemy:new(x, y)
    nEnemy = Class(Enemy)
    nEnemy:configure(x, y)
    InsertEnemy(nEnemy)
end

function Enemy:draw()
    DrawSprite(self.sprite)
    self:DrawProjectiles()
end

function Enemy:configure(x, y)
    self.MovementEnemy = {
        up = false,
        down = false,
        left = false,
        right = false,
        delayPursuit = 0,
        velocity = 30 * Speed
    }
    print(self.MovementEnemy.velocity)
    self.sprite = CreateSprite(x, y, "Imagens/inimigo.png")
    self.sprite.destroysfx = love.audio.newSource("sons/ExplodeInimigo.wav", "static")

    self.projectiles = {}
    self.fireCoolDown = 0.7
end

function Enemy:destroy()
    print("Enemy destroyed")
    score = score + 1
    self.sprite.destroysfx:play()
end

function Enemy:DecideMovement(dt)
    if GameActive then
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
        else
            if self.MovementEnemy.delayPursuit <= 0 then
                self.MovementEnemy.delayPursuit = 1.2
            else
                self:fire()
            end
        end
        if self.MovementEnemy.delayPursuit > 0 then
            self.MovementEnemy.delayPursuit = self.MovementEnemy.delayPursuit - dt
        end
    end
end

function Enemy:fire()
    if TableLenght(self.projectiles) < 5 and self.fireCoolDown <= 0 then
        print("fire", self.sprite.x + math.ceil(self.sprite.width / 2), self.sprite.y)
        local projectile = ConfigureProjectile({})
        projectile.target = "Player"
        MirrorY(projectile.sprite, true)
        UpdateX(projectile.sprite, self.sprite.x + math.ceil(self.sprite.width / 2), 3)
        UpdateY(projectile.sprite, self.sprite.y + projectile.sprite.height, 0)
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
        -- if projectile.x < 0 or projectile.x > LarguraTela or projectile.sprite.y < 0 or projectile.sprite.y > AlturaTela then
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
