require("libs.vector")
require("common.entity")
require("common.input")


function Player(position)
    output = {
        position = position or vector.new(0, 0),
        velocity = vector.new(0, 0),
        size = vector.new(28, 33),
        jumpTime = 0,
        coyoteTime = 0.15,
        sprite = nil,
        jumpsLeft = 0,
        r = 0,
        ox = 0,
        oy = 0
    }

    function output:update(delta)
        if (self.jumpsLeft <= 0) then
            self.jumpTime = self.jumpTime - delta
        end

        InputDir = GetInputVector("w", "s", "a", "d") * -1

        if (self.velocity.y <= 500) then
            self.velocity.y = self.velocity.y + 2000 * delta * 1.1;
        end


        if (self.velocity.y ~= 0) then
            if (self:Collide(delta)) then
                self.velocity.y = 0
            end
        end

        if (InputDir.x ~= 0) then
            self.velocity.x = InputDir.x * 300
            if (self:Collide(delta)) then
                self.velocity.x = 0
            end
        else
            self.velocity.x = 0
        end

        if (self.velocity.y == 0) then
            self.jumpsLeft = 2;
            self.jumpTime = self.coyoteTime;
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

    function output:jump()
        if (self.jumpTime > 0 and self.jumpsLeft > 0) then
            self.jumpsLeft = self.jumpsLeft - 1
            if (self.jumpsLeft <= 0) then
                self.jumpTime = 0
            end
            self.velocity.y = -700
        end
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
