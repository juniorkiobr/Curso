math.randomseed(os.time()) -- seed the random number generator

LarguraTela = love.graphics.getWidth()
AlturaTela = love.graphics.getHeight()
Speed = 10
BoolToNumber = {[true] = 1, [false] = 0}
GameActive = true
Score = 0
Enemies = nil
Player = nil
ControllerPlayer1 = nil

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

function ScoreIncrease(qnt)
    Score = Score + qnt
end
function ScoreDecrease(qnt)
    Score = Score - qnt
end

function DefinePlayer(PlayerClass)
    Player = PlayerClass
end

function DefineGameActive(bool)
    GameActive = bool
end

function DefineControllerPlayer1(controller)
    ControllerPlayer1 = controller
end

function LoadGame()
    Enemies = {}
    ConfigBackground()
    PlayerClass:new()
    if (ControllerPlayer1 == nil) then
        love.graphics.print("Press fire to select controller", LarguraTela / 2, AlturaTela / 2)
        while ControllerPlayer1 ~= nil do
        end
    end
    -- SpawnEnemy()
    DrawBackground()
    Player:draw()
    DrawAllEnemies()
    Score = 0
    GameActive = true
end

function TableLenght(t)
    local count = 0

    for _ in pairs(t) do
        count = count + 1
    end
    return count
end
