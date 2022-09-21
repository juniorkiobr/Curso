require "scripts.classes.class"
require "scripts.classes.shipLife"
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
    if (self.sprite) then
        return self.sprite.x < projectile.sprite.x + projectile.sprite.width and
            self.sprite.x + self.sprite.width > projectile.sprite.x and
            self.sprite.y < projectile.sprite.y + projectile.sprite.height and
            self.sprite.y + self.sprite.height > projectile.sprite.y
    end
end

function Entity:destroy()
    print("Spaceship destroyed")
    self.sprite.destroysfx:play()
    self:callbackDestroy()
end

function Entity:callbackDestroy()
    print("method not implemented")
end

function Entity:configure()
    self.shipLife = NewShipLife(1)
    self:configureChild()
end

function Entity:configureChild()
    print("Method not implemented")
end

function Entity:removeLife()
    self.shipLife:removeLife()
    if (self.shipLife.lifes == 0) then
        print(self.name .. " life has reached zero")
        self:destroy()
    end
end

function NewPlayer()
    local c = Class(Entity)
    local r = c("Player")
    return r
end

function NewEnemy()
    local c = Class(Entity)
    local r = c("Enemy")
    return r
end
