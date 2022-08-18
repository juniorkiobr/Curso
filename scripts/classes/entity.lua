require "scripts.classes.class"
Entity =
    Class(
    function(tbl, name)
        print("Entity:new(name): " .. name)
        tbl.name = name
    end
)
print(Entity)
function Entity:get(key)
    return self[key]
end

function Entity:set(key, value)
    self[key] = value
end

function Entity:draw()
    return "Method not implemented"
end

function Entity:update(dt)
    return "Method not implemented"
end

function Entity:move(dt)
    return "Method not implemented"
end

function Entity:__tostring()
    for name, value in pairs(self) do
        print(name .. ": ")
        print(value)
    end
end

function Entity:isNear(projectile)
    return self.sprite.x < projectile.sprite.x + projectile.sprite.width and
        self.sprite.x + self.sprite.width > projectile.sprite.x and
        self.sprite.y < projectile.sprite.y + projectile.sprite.height and
        self.sprite.y + self.sprite.height > projectile.sprite.y
end

function Entity:destroy()
    print("Spaceship destroyed")
    self.sprite.destroysfx:play()
end

function newPlayer()
    local c = Class(Entity)
    local r = c("Player")
    return r
end

function newEnemy()
    local c = Class(Entity)
    local r = c("Enemy")
    return r
end
