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

function getControllersinfo()
    local joysticks = love.joystick.getJoysticks()

    if TableLenght(joysticks) > 0 then
        for i = 1, TableLenght(joysticks) do
            print(joysticks[i]:getDeviceInfo())
            love.graphics.print(joysticks[i]:getName(), 0, 0)
            love.graphics.print(joysticks[i]:getGUID(), 0, 10)
            for j = 0, joysticks[i]:getAxisCount(), 1 do
                local axis = joysticks[i]:getAxis(j)
                local text = "Axis " .. j .. ": " .. axis
                love.graphics.print(text, 0, (j + 1) * 10)
            end

            local axes = joysticks[i]:getAxes()
            love.graphics.print(axes, 0, 10 + (joysticks[i]:getAxisCount() + 1) * 10)
        end
    end
end

function getControllers()
    local joysticks = love.joystick.getJoysticks()
    if TableLenght(joysticks) > 0 then
        for i = 1, TableLenght(joysticks) do
            -- print(joysticks[i]:getGUID())
            if (joysticks[i]:getGUID() == "030000005e040000a102000000007200") then
                getAxisMovX360(joysticks[i])
            end
        end
    end
end

function getAxisMovX360(joystick)
    if joystick then
        if (GameActive) then
            local axisHorizontal = joystick:getAxis(1)
            local axisVertical = joystick:getAxis(2)
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
        getDpadMovX360(joystick)
    end
end

function love.gamepadpressed(joystick, button)
    print(joystick, button)
end

function love.gamepadreleased(joystick, button)
    notDownX360(joystick, button)
end

function notDownX360(joystick, button)
    if joystick then
        if button == "guide" then
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

function getDpadMovX360(joystick)
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
