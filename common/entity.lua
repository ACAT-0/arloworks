require("libs.vector")

function Entity(position, type)
    Entity = {
        position = position or vector.new(0, 0),
        velocity = vector.new(0, 0),
        type = type or 0,
        update_events = {},
        draw_events = {},
        defaultDraw = true,
        sprite = nil,
        r = 0,
        ox = 0,
        oy = 0
    }

    function Entity:sendToBuffer(buffer)
        table.insert(buffer, #buffer + 1, self)
    end

    function Entity:addUpdateEvent(event)
        table.insert(self.update_events, #self.update_events, event)
    end

    function Entity:update(delta)
        for i, event in pairs(self.update_events) do
            event(self, delta)
        end
    end

    function Entity:setSprite(sprite)
        self.sprite = sprite;
    end

    function Entity:addDrawEvent(event)
        table.insert(self.draw_events, event)
    end

    return Entity
end
