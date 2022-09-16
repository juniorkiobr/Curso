SpawnerPositions = {
    {x = -10, y = -10},
    {x = 80, y = -10},
    {x = 130, y = -10},
    {x = 250, y = -10},
    {x = 400, y = -10}
}
SpawnCooldown = 0.0

function SpawnEnemy()
    rnd = math.random(1, #SpawnerPositions)
    Enemy:new(SpawnerPositions[rnd].x, SpawnerPositions[rnd].y)
end

function AutoSpawnEnemy(dt)
    if (TableLenght(Enemies) < 10 and SpawnCooldown < 0) then
        SpawnEnemy()
        SpawnCooldown = 0.7
    end
    SpawnCooldown = SpawnCooldown - dt
end
