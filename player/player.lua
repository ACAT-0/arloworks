require("common.entity")
require("common.input")

function Player(position)
    output = {
        position = position or vector.new(0, 0),
        velocity = vector.new(0, 0),
        size = vector.new(28, 33),
        draw_events = {},
        defaultDraw = true,
        sprite = nil,
        r = 0,
        ox = 0,
        oy = 0
    }

    function output:update(delta)
        InputDir = GetInputVector("w", "s", "a", "d") * -1

        if (InputDir.x ~= 0) then
            self.velocity.x = InputDir.x * 200
            if (self:Collide(delta)) then
                self.velocity.x = 0
            end
        else
            self.velocity.x = 0
        end

        if (InputDir.y ~= 0) then
            self.velocity.y = InputDir.y * 200
            if (self:Collide(delta)) then
                self.velocity.y = 0
            end
        else
            self.velocity.y = 0
        end


        -- if (InputDir.x == 0) then
        --     self.velocity.x = self.velocity.x * 0.98
        -- end
        -- if (InputDir.y == 0) then
        --     self.velocity.x = self.velocity.x * 0.98
        -- end


        self.position = self.position + self.velocity * delta
        addToDrawBuffer(self, drawbuffer)
    end

    function output:Collide(delta)
        o = false
        for i, tile in pairs(CollisionEntities) do
            corners = {
                self.position.x,
                self.position.y,
                self.position.x + self.size.x,
                self.position.y + self.size.y
            }
            if (tile:CheckCollision(self.position + (self.velocity * delta), self.size)) then
                o = true
            end
        end
        return o
    end

    return output
end
