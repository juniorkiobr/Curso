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
        local obj = setmetatable(c, {})
        if init then
            init(obj, ...)
        else
            if inherit and inherit.init then
                inherit.init(obj, ...)
            end
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
