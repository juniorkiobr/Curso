require "scripts.classes.class"
ShipLife =
    Class(
    function(tbl, name)
        print("ShipLife:new(name): " .. name)
        tbl.name = name
    end
)

function ShipLife:get(key)
    return self[key]
end

function ShipLife:set(key, value)
    self[key] = value
end

function ShipLife:__tostring()
    for name, value in pairs(self) do
        print(name .. ": ")
        print(value)
    end
end

function ShipLife:configure(lifes)
    self.lifes = lifes
end

function ShipLife:removeLife()
    self.lifes = self.lifes - 1
    self:callbackRemoveLife()
end

function ShipLife:addLife()
    self.lifes = self.lifes + 1
end

function ShipLife:callbackRemoveLife()
    return "method not implemented"
end

function newShipLife(lifes)
    local c = Class(ShipLife)
    local r = c("ShipLife")
    r:configure(lifes)
    return r
end
