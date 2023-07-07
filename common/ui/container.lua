require("common.color")
require("libs.vector")

function UIContainer(position, size, fill, draw)
    local group = {
        position = position,
        size = size,
        children = {},
        color = Color(1, 1, 1, 0.2),
        fill = fill or true,
        draw = draw or true
    }

    function group:AppendElement(element, key)
        if (key ~= nil) then
            self.children[key] = element
        else
            table.insert(self.children, element)
        end
    end

    function group:Draw()
        if (draw == true) then
            local string = "fill";
            if (self.fill == false) then
                string = "line"
            end
            love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
            love.graphics.rectangle(string, self.position.x, self.position.y, self.size.x, self.size.y)
            love.graphics.setColor(1, 1, 1, 1)
        end
        for i, element in pairs(self.children) do
            element:Draw(self)
        end
    end

    -- function group:GetElement(key)
    --     return self.children[key]
    -- end

    return group
end
