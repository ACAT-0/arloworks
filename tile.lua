function CollisionEntity(position, size)
    output = {
        position = position or vector.new(0, 0),
        size = size or vector.new(1, 1),

    }

    function output:drawdebug()
        love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
    end

    function output:addToBuffer(buffer)
        table.insert(buffer, self)
    end

    function output:CheckCollision(pos2, size2)
        local x1 = self.position.x;
        local x2 = pos2.x
        local y1 = self.position.y
        local y2 = pos2.y
        local w1 = self.size.x
        local w2 = size2.x
        local h1 = self.size.y
        local h2 = size2.y
        return x1 < x2 + w2 and
            x2 < x1 + w1 and
            y1 < y2 + h2 and
            y2 < y1 + h1
    end

    return output
end
