function ConfigureProjectile(projectile)
    projectile.image = love.graphics.newImage("Imagens/projetil.png")
    projectile.width = projectile.image:getWidth()
    projectile.height = projectile.image:getHeight()
    projectile.x = LarguraTela / 2
    projectile.y = AlturaTela
    projectile.speed = 59 * Speed
    projectile.lifetime = 1.0
    projectile.sfx = love.audio.newSource("sons/Tiro.wav", "static")
    -- projectile.hit_effect = "hit_effect_01"
    -- projectile.particle_effect = "particle_effect_01"
    projectile.hit_callback = function(projectile)
        if projectile.lifetime < 0 then
            print("Projectile lifespan has ended")
        else
            print("Projectile colided with something")
        end
        Player.projectile = nil
        Player.projectile = ConfigureProjectile({})
        MovementPlayer.space = false
    end
    return projectile
end

function DrawProjectile(projectile)
    if projectile then
        love.graphics.draw(projectile.image, projectile.x, projectile.y)
    end
end

function UpdateProjectile(projectile, dt)
    if projectile then
        projectile.y = projectile.y + (projectile.speed * dt)
        projectile.lifetime = projectile.lifetime - dt
        print(projectile.lifetime)

        if projectile.lifetime < 0 then
            projectile.hit_callback(projectile)
        end
    end
end
