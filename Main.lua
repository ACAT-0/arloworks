class = require("libs.class")
vector = require("libs.vector")
gamera = require("libs.gamera")
require("common.draw")
require("common.update")
require("common.keypresshandler")
require("common.utils")
require("common.entity")
require("common.input")
require("common.tile")
require "common.ui"
require("player.player")
require("assets.assethandler")


drawbuffer = {};
setdebugge = false
camera = {}
debuginfo = {};
Entities = {}
Players = {}
CollisionEntities = {}
UITest = {}


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setMode(0, 0, { resizable = true }) -- sets window to monitor display height/width etc.
    Assets = loadAssets()
    drawbuffer = {};
    addKeyEvent("1", function() setdebugge = true end)
    addKeyEvent("2", function() setdebugge = false end)
    camera = gamera.new(-1000, -1000, 1000, 1000)


    -- newent = Entity(vector.new(0, 0))
    -- debuginfo[1] = 0
    -- newent:addUpdateEvent(function(self, delta)
    --     debuginfo[1] = debuginfo[1] + 1
    --     self.position.x = self.position.x + delta * 10
    --     end)
    -- newent:sendToBuffer(Entities)
    -- newent:setSprite(Assets.placeholder)
    UITest = UIContainer(vector.new(200, 200), vector.new(200, 100), false, true)
    UITest:AppendElement(
        UITextComponent(vector.new(2, 2),
            "This is a Text Component!",
            nil, 1000), nil)
    UITest:AppendElement(UITextComponent(vector.new(2, 20), "Wowee!", Color(1, 0.2, 0.2, 1), math.maxinteger))
end

function love.update(delta)
    update(Entities, delta)
    for i, player in pairs(Players) do
        player:update(delta)
    end
end

function love.keypressed(key)
    keyHandler(key)
end

function love.draw()
    -- hey bbgrill
    local width, height = love.window.getMode()
    love.graphics.scale(width / 800, height / 450);
    love.graphics.print(boolToString(setdebugge), 0, 0)


    draw(drawbuffer, CollisionEntities);
    UITest:Draw()

    drawbuffer = {}
end
