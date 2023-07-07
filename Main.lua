class = require("libs.class")
vector = require("libs.vector")
gamera = require("libs.gamera")
require("common.draw")
require("common.update")
require("common.keypresshandler")
require("common.utils")
require("common.entity")
require("common.input")
require("player.player")
require("assets.assethandler")


drawbuffer = {};
setdebugge = false
camera = {}
debuginfo = {};
Entities = {}
Players = {}

function love.load()
    love.graphics.setDefaultFilter("nearest","nearest")
    love.window.setMode(0, 0, {resizable = true}) -- sets window to monitor display height/width etc.
    Assets = loadAssets()
    drawbuffer = {};
    addKeyEvent("1", function() setdebugge = true end)
    addKeyEvent("2",function() setdebugge = false end)
    camera = gamera.new(-1000, -1000, 1000, 1000)


    -- newent = Entity(vector.new(0, 0))
    -- debuginfo[1] = 0
    -- newent:addUpdateEvent(function(self, delta)
    --     debuginfo[1] = debuginfo[1] + 1
    --     self.position.x = self.position.x + delta * 10
    --     end)
    -- newent:sendToBuffer(Entities)
    -- newent:setSprite(Assets.placeholder)

    player = Player()
    player.sprite = Assets.player.idle
    table.insert(Players,player)
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
    love.graphics.scale(width/800,height/450);
    love.graphics.print(boolToString(setdebugge), 0, 0)
    love.graphics.print(tostring(debuginfo[1]),0,30)

    draw(drawbuffer);
end