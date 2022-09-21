new_globals = {
    --[[ Love globals ]] --
    "_",
    "love",
    --[[ Class globals ]]
    "Class",
    --[[ Main globals ]]
    "GetControllers",
    "GetControllersinfo",
    --[[ Background globals ]]
    "ConfigBackground",
    "RepeatBackground",
    "MoveBackground",
    "DrawBackground",
    "Background",
    "LarguraTela",
    "AlturaTela",
    "Speed",
    --[[ enemy globals ]]
    "NewEnemy",
    "Enemies",
    "InsertEnemy",
    "RemoveEnemy",
    "AutoSpawnEnemy",
    "Enemy",
    "nEnemy",
    "DrawAllEnemies",
    "UpdateAllEnemies",
    "GetEnemyNearProjectile",
    --[[ ShipLife globals ]]
    "ShipLife",
    "NewShipLife",
    --[[ Sprite globals ]]
    "Sprite",
    "CreateSprite",
    "DrawSprite",
    "UpdateX",
    "UpdateY",
    "MirrorX",
    "MirrorY",
    --[[ Player globals ]]
    "Player",
    "PlayerClass",
    "ControllerPlayer1",
    "NewPlayer",
    "DetectKeysPlayer",
    --[[ Projectile globals ]]
    "Projectile",
    "ConfigureProjectile",
    "DrawProjectile",
    "UpdateProjectile",
    --[[ Utils globals ]]
    "TableLenght",
    "Score",
    "GameActive",
    "LoadGame",
    "BoolToNumber",
    "CalculateValocityDiagonal",
    "ScoreIncrease",
    "ScoreDecrease",
    "DefinePlayer",
    "DefineGameActive",
    "DefineControllerPlayer1"
}
exclude_files = {"**/.*"}
std = "love"
ignore = {
    "212/self",
    "212/dt"
}
