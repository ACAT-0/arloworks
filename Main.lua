local class = require("libs.class")
vector = require("libs.vector")
local gamera = require("libs.gamera")
require("common.draw")
require("common.update")
require("common.keypresshandler")
require("common.utils")
require("common.entity")
require("common.input")
require("common.tile")
require("player.player")
require("common.ui")
require("assets.assethandler")
require("levels.levels")
require("common.color")


drawbuffer = {};
setdebugge = false
camera = {}
debuginfo = {};
Entities = {}
Players = {}
CollisionEntities = {}
camera = gamera.new(0, 0, 1, 1)
UI = {}
TargetWindowSize = vector.new(800, 450)



function love.load()
    debuginfo[1] = 0
    CameraMoveRate = 0.05
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setMode(0, 0, { resizable = false }) -- sets window to monitor display height/width etc.
    local width, height = love.window.getMode()
    love.window.setMode(width, height - 100)
    Assets = loadAssets()
    drawbuffer = {};
    addKeyEvent("1", function() setdebugge = true end)
    addKeyEvent("2", function() setdebugge = false end)
    local width, height = love.window.getMode()
    camera = gamera.new(0, 0, 100000, 100000)



    -- newent = Entity(vector.new(0, 0))
    -- debuginfo[1] = 0
    -- newent:addUpdateEvent(function(self, delta)
    --     debuginfo[1] = debuginfo[1] + 1
    --     self.position.x = self.position.x + delta * 10
    --     end)
    -- newent:sendToBuffer(Entities)
    -- newent:setSprite(Assets.placeholder)
    UI = UIContainer(vector.new(100, 100), vector.new(400, 200), true, true)
    UI:AppendElement(UITextComponent(vector.new(2, 2), "Hi!", Color(1, 1, 1, 1), 200))
    UI:AppendElement(UITextComponent(vector.new(80, 69), "This is a text component. It works pretty well",
        Color(1, 1, 1, 1), 200))
    local button = UIButtonComponent(vector.new(10, 30), vector.new(60, 20), Color(1, 0, 0, 1),
        function() love.event.quit() end)
    button:AppendElement(UITextComponent(vector.new(26, 10), "Quit", Color(1, 1, 1, 1), 200))
    UI:AppendElement(button)
end

function love.keypressed(key)
    keyHandler(key)
end

function love.update(dt)
    UI:Update(dt, TargetWindowSize)
end

function love.draw()
    -- hey bbgrill
    local width, height = love.window.getMode()
    love.graphics.print(boolToString(setdebugge), 0, 0)
    love.graphics.scale(width / TargetWindowSize.x, height / TargetWindowSize.y);
    love.graphics.print(boolToString(setdebugge), 0, 0)
    love.graphics.print(tostring(debuginfo[1]), 0, 30)

    draw(drawbuffer, CollisionEntities, camera);
    drawbuffer = {}
    UI:Draw(TargetWindowSize)
end
