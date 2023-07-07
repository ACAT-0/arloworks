require "levels/levels"

local grass
local dirt
local stone

function generateWorld(world, size)
    for i = 1, size do
        row = {}
        for j = 1, size do
            table.insert(row, 0)
        end
        table.insert(world, row)
    end
end

function love.load()
    fullscreen = false
    love.graphics.setDefaultFilter("nearest", "nearest")
    homeScreen = love.graphics.newImage("sprites/home_screen.png")
    blankSprite = love.graphics.newImage("sprites/blank.png")
    sprite1 = love.graphics.newImage("sprites/dirt.png")
    sprite2 = love.graphics.newImage("sprites/grass.png")
    sprite3 = love.graphics.newImage("sprites/stone.png")
    sprites = { sprite1, sprite2, sprite3, }
    world = {}
    worldSize = 64
    generateWorld(world, worldSize)
    worldSizeX = 128
    worldSizeY = 128
    tilesize = 16
    width, height = love.graphics.getDimensions()
    scale = 2
    cameraX = 1
    cameraY = 1
    scene = 0
    levelToLoad = level
    spriteIndex = 1
end

function getLocation(mouseX, mouseY)
    local i = mouseY + cameraY * scale * tilesize
    i = (i - (i % (scale * tilesize))) / (scale * tilesize)
    local j = mouseX + cameraX * scale * tilesize
    j = (j - (j % (scale * tilesize))) / (scale * tilesize)

    return i, j
end

function drawUI()
    local viewscale = 6
    love.graphics.setColor(82 / 255, 92 / 255, 102 / 255)
    love.graphics.rectangle("fill", 10, 10, 80, #sprites * 80)
    love.graphics.setColor(1, 1, 1)
    for i, sprite in pairs(sprites) do
        love.graphics.draw(sprites[i], 25, 80 * (i - 1) + 20, 0, viewscale)
        if i == spriteIndex then
            love.graphics.rectangle("line", 20, (80 * (i - 1) + 20) - 5, 8 * viewscale + 10, 8 * viewscale + 10,
                viewscale)
        end
    end
end

function drawHomeScreen()
    love.graphics.draw(homeScreen, 0, 0, 0, width / 800, height / 600)
end

function drawSceneEdit()
    for i = 1, worldSize do
        for j = 1, worldSize do
            tile = world[i][j] or 100
            if tile == 0 then
                love.graphics.setColor(0.1, 0.1, 0.1)
                love.graphics.rectangle("fill", (j - cameraX) * scale * tilesize, (i - cameraY) * scale * tilesize,
                    scale * (tilesize), scale * (tilesize))
                love.graphics.setColor(1, 1, 1)
            elseif tile == 1 then
                love.graphics.draw(sprite1, (j - cameraX) * scale * tilesize, (i - cameraY) * scale * tilesize, 0,
                    scale * (tilesize / 8), scale * (tilesize / 8))
            elseif tile == 2 then
                love.graphics.draw(sprite2, (j - cameraX) * scale * tilesize, (i - cameraY) * scale * tilesize, 0,
                    scale * (tilesize / 8), scale * (tilesize / 8))
            elseif tile == 3 then
                love.graphics.draw(sprite3, (j - cameraX) * scale * tilesize, (i - cameraY) * scale * tilesize, 0,
                    scale * (tilesize / 8), scale * (tilesize / 8))
            elseif tile == 100 then
            end
            local x = i * tilesize * scale
        end
    end
    love.graphics.setColor(1, 1, 1)
    drawGrid()
    drawUI()
end

function drawGrid()
    love.graphics.setColor(0.2, 0.2, 0.2)
    for j, tile in pairs(world[1]) do
        local x = (j - cameraX) * tilesize * scale
        love.graphics.line(x, 1 - cameraY * tilesize * scale, x, (worldSize - cameraY + 1) * tilesize * scale)
    end
    for i, tile in pairs(world) do
        local y = (i - cameraY) * tilesize * scale
        love.graphics.line(1 - cameraX * tilesize * scale, y, (worldSize - cameraX + 1) * tilesize * scale, y)
    end
    love.graphics.setColor(1, 1, 1)
end

function saveWorld()
    levelToSave = ""
    for i, row in pairs(world) do
        levelToSave = levelToSave .. "{"
        for j, tile in pairs(world[i]) do
            levelToSave = levelToSave .. tile .. ","
        end
        levelToSave = levelToSave .. "}, " .. "\n"
    end
    file = io.open("levels.lua", "w+")
    io.output(file)
    io.write("level = " .. "{" .. levelToSave .. "}")
    io.close(file)
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        cameraY = cameraY - 1
    end
    if love.keyboard.isDown("a") then
        cameraX = cameraX - 1
    end
    if love.keyboard.isDown("s") then
        cameraY = cameraY + 1
    end
    if love.keyboard.isDown("d") then
        cameraX = cameraX + 1
    end

    if love.mouse.isDown(1) then
        local mouseX = love.mouse.getX()
        local mouseY = love.mouse.getY()
        if scene == 1 then
            local i, j = getLocation(mouseX, mouseY)
            if i >= 1 and j >= 1 and i <= worldSize and j <= worldSize then
                world[i][j] = spriteIndex
            end
        elseif scene == 0 then
            if mouseY > height / 2 then
                if mouseX > width / 2 then
                    scene = 1
                elseif mouseX < width / 2 then
                    world = levelToLoad
                    scene = 1
                end
            end
        end
    end

    if love.mouse.isDown(2) then
        local mouseX = love.mouse.getX()
        local mouseY = love.mouse.getY()
        if scene == 1 then
            i, j = getLocation(mouseX, mouseY)
            if i >= 1 and j >= 1 and i <= worldSize and j <= worldSize then
                world[i][j] = 0
            end
        end
    end
end

function love.keypressed(key)
    if key == "f" then
        if fullscreen == false then
            fullscreen = true
        else
            fullscreen = false
        end
        love.window.setFullscreen(fullscreen)
        width, height = love.graphics.getDimensions()
    end
    if key == "t" then
        scale = scale * 2
    end
    if key == "y" then
        scale = scale / 2
    end
    if key == "1" then
        spriteIndex = spriteIndex + 1
        if spriteIndex > #sprites then
            spriteIndex = 1
        end
    end
    if key == "2" then
        saveWorld()
    end
end

function love.draw()
    if scene == 1 then
        drawSceneEdit()
    end
    if scene == 0 then
        drawHomeScreen()
    end
end
