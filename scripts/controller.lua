-- Axis 1- 4 are joystick controllers

-- xbox 360 controller:
-- 	axis 1 : left -1
-- 		   : right +1
-- 	axis 2 : up -1
-- 		   : down +1
-- 	axis 3 : cam left -1
-- 		   : cam right +1
-- 	axis 4 : cam up -1
-- 		   : cam down +1
-- 	axis 5 : lt +1
-- 	axis 6 : rt +1

-- ps2 controller:
-- 	axis 1 : left -1
-- 		   : right +1
-- 	axis 2 : up -1
-- 		   : down +1
-- 	axis 3 : cam left -1
-- 		   : cam right +1
-- 	axis 4 : cam up -1
-- 		   : cam down +1

X360CONTROLLER = "030000005e040000a102000000007200"
PS2CONTROLLER = "03000000100800000100000000000000"

X360CONTROLLERMAP = {
    a = "a",
    b = "b",
    x = "x",
    y = "y",
    leftshoulder = "lb",
    rightshoulder = "rb",
    lefttrigger = "lt",
    righttrigger = "rt",
    leftstick = "ls",
    rightstick = "rs",
    back = "back",
    start = "start",
    dpup = "dpup",
    dpdown = "dpdown",
    dpleft = "dpleft",
    dpright = "dpright",
    axisMovHorizontal = 1,
    axisMovVertical = 2,
    axisCamHorizontal = 3,
    axisCamVertical = 4,
    axisLeftTrigger = 5,
    axisRightTrigger = 6
}
PS2CONTROLLERMAP = {
    x = "a",
    circle = "b",
    square = "x",
    triangle = "y",
    l1 = "lb",
    r1 = "rb",
    l2 = "lt",
    r2 = "rt",
    select = "back",
    start = "start",
    l3 = "ls",
    r3 = "rs",
    up = "dpup",
    down = "dpdown",
    left = "dpleft",
    right = "dpright",
    axisMovHorizontal = 1,
    axisMovVertical = 2,
    axisCamHorizontal = 3,
    axisCamVertical = 4
}

function getControllersinfo()
    local joysticks = love.joystick.getJoysticks()

    if TableLenght(joysticks) > 0 then
        print(joysticks[1]:getDeviceInfo())
        love.graphics.print(joysticks[1]:getName(), 0, 0)
        love.graphics.print(joysticks[1]:getGUID(), 0, 10)
        for j = 0, joysticks[1]:getAxisCount(), 1 do
            local axis = joysticks[1]:getAxis(j)
            local text = "Axis " .. j .. ": " .. axis
            love.graphics.print(text, 0, (j + 1) * 10)
        end

        local axes = joysticks[1]:getAxes()
        love.graphics.print(axes, 0, 10 + (joysticks[1]:getAxisCount() + 1) * 10)
    end
end

function getControllers()
    -- local joysticks = love.joystick.getJoysticks()
    if ControllerPlayer1 ~= nil then
        if (ControllerPlayer1:getGUID() == X360CONTROLLER) then
            getAxisGamepad(ControllerPlayer1, X360CONTROLLERMAP.axisMovHorizontal, X360CONTROLLERMAP.axisMovVertical)
        elseif (ControllerPlayer1:getGUID() == PS2CONTROLLER) then
            getAxisGamepad(ControllerPlayer1, PS2CONTROLLERMAP.axisMovHorizontal, PS2CONTROLLERMAP.axisMovVertical)
        end
    end
end

function getAxisGamepad(joystick, axisMovHorizontal, axisMovVertical)
    if joystick then
        if (GameActive) then
            local axisHorizontal = joystick:getAxis(axisMovHorizontal)
            local axisVertical = joystick:getAxis(axisMovVertical)
            if axisHorizontal < 0.1 and axisHorizontal > -0.1 then
                Player.MovementPlayer.left = false
                Player.MovementPlayer.right = false
            end

            if axisVertical < 0.1 and axisVertical > -0.1 then
                Player.MovementPlayer.up = false
                Player.MovementPlayer.down = false
            end

            if axisHorizontal > 0.1 then
                if (Player.MovementPlayer.left) then
                    Player.MovementPlayer.left = false
                end
                Player.MovementPlayer.right = true
            elseif axisHorizontal < -0.1 then
                if (Player.MovementPlayer.right) then
                    Player.MovementPlayer.right = false
                end
                Player.MovementPlayer.left = true
            end

            if axisVertical > 0.1 then
                if (Player.MovementPlayer.up) then
                    Player.MovementPlayer.up = false
                end
                Player.MovementPlayer.down = true
            elseif axisVertical < -0.1 then
                if (Player.MovementPlayer.down) then
                    Player.MovementPlayer.down = false
                end
                Player.MovementPlayer.up = true
            end
        end
        getDpadMGamepad(joystick)
    end
end

function love.gamepadpressed(joystick, button)
    if (not ControllerPlayer1 ~= nil) then
        ControllerPlayer1 = joystick
    else
        print("gamepadpressed ", joystick)
        print("gamepadpressed: " .. button)
    end
end

function love.gamepadreleased(joystick, button)
    notDownGamepad(joystick, button)
end

function notDownGamepad(joystick, button)
    if joystick then
        if button == "back" then
            love.event.quit()
        end
        if (GameActive) then
            if not joystick:isGamepadDown("dpup") then
                Player.MovementPlayer.up = false
            end
            if not joystick:isGamepadDown("dpdown") then
                Player.MovementPlayer.down = false
            end
            if not joystick:isGamepadDown("dpleft") then
                Player.MovementPlayer.left = false
            end
            if not joystick:isGamepadDown("dpright") then
                Player.MovementPlayer.right = false
            end
            if not joystick:isGamepadDown("a") then
                Player.MovementPlayer.space = false
            end
        end
    end
end

function getDpadMGamepad(joystick)
    if joystick then
        if joystick:isGamepadDown("a") then
            if (GameActive) then
                Player.MovementPlayer.space = true
            else
                LoadGame()
            end
        end
        if (GameActive) then
            if joystick:isGamepadDown("dpup") then
                Player.MovementPlayer.up = true
            end

            if joystick:isGamepadDown("dpdown") then
                Player.MovementPlayer.down = true
            end

            if joystick:isGamepadDown("dpleft") then
                Player.MovementPlayer.left = true
            end

            if joystick:isGamepadDown("dpright") then
                Player.MovementPlayer.right = true
            end
        end
    end
end
