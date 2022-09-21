function ConfigureProjectile(projectile)
    projectile.sprite = CreateSprite(LarguraTela / 2, AlturaTela, "Imagens/projetil.png")
    projectile.speed = 59 * Speed
    projectile.lifetime = 1.0
    projectile.sfx = love.audio.newSource("sons/Tiro.wav", "static")
    -- projectile.hit_effect = "hit_effect_01"
    -- projectile.particle_effect = "particle_effect_01"
    projectile.hit_callback = function()
        if projectile.lifetime < 0 then
            print("Projectile lifespan has ended")
        else
            print("Projectile colided with something")
        end
    end
    return projectile
end

function DrawProjectile(projectile)
    if projectile then
        DrawSprite(projectile.sprite)
    -- love.graphics.draw(projectile.image, projectile.x, projectile.sprite.y)
    end
end

function UpdateProjectile(projectile, dt)
    if projectile then
        projectile.sprite.y = projectile.sprite.y + (projectile.speed * dt)
        projectile.lifetime = projectile.lifetime - dt
        ColisionCheck(projectile)

        if projectile.lifetime < 0 then
            projectile.hit_callback(projectile)
        end
    end
end

function ColisionCheck(projectile)
    if projectile then
        local entity = nil
        local _ = nil
        if projectile.target == "Player" then
            entity = Player
        elseif projectile.target == "Enemy" then
            _, entity = GetEnemyNearProjectile(projectile)
        end
        if GameActive and entity and entity:isNear(projectile) then
            entity:removeLife()
            projectile.hit_callback(projectile)
            projectile.lifetime = -1
        end
    end
end
