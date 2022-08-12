LarguraTela = love.graphics.getWidth()
AlturaTela = love.graphics.getHeight()
Speed = 10
BoolToNumber = {[true] = 1, [false] = 0}

function CalculateValocityDiagonal(dt, vertical_keys)
    if vertical_keys == nil then
        vertical_keys = false
    end
    local MovementPlayer = Player:get("MovementPlayer")

    if (vertical_keys) then
        return ((-0.5 * BoolToNumber[MovementPlayer.up or MovementPlayer.down]) + 1) * MovementPlayer.velocity * dt
    else
        return ((-0.5 * BoolToNumber[MovementPlayer.left or MovementPlayer.right]) + 1) * MovementPlayer.velocity * dt
    end
end

function TableLenght(t)
    local count = 0

    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

function Class(inherit, init)
    local c = {}
    if not init and type(inherit) == "function" then
        init = inherit
        inherit = nil
    elseif type(inherit) == "table" then
        for k, v in pairs(inherit) do
            c[k] = v
        end
        c._inherit = inherit
    end

    c._index = c

    local metatable = {}
    metatable.__call = function(class_tbl, ...)
        local obj = {}
        setmetatable(obj, c)
        if init then
            init(obj, ...)
        else
            if inherit and inherit.init then
                inherit.init(obj, ...)
            end
            return obj
        end
        c.init = init
        c.is_a = function(self, klass)
            local m = getmetatable(self)
            while m do
                if m == klass then
                    return true
                end
                m = m._inherit
            end
            return false
        end
        setmetatable(c, metatable)
        return c
    end
end
