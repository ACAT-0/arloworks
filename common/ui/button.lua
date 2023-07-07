require("common.color")
require("libs.vector")
require("common.utils")
--- Returns a new Button Component UI object.
---@param relativeposition table
---@param color table
---@param onclick any
---@return table
function UIButtonComponent(relativeposition, size, color, onclick)
    local group = {
        position = relativeposition,
        color = color or Color(1, 1, 1, 1),
        onclick = onclick,
        size = size,
        children = {}
    }

    function group:AppendElement(element, key)
        if (key ~= nil) then
            self.children[key] = element
        else
            table.insert(self.children, element)
        end
    end

    function group:Draw(parent, scale)
        local xDrawPos = ((self.position.x * (parent.size.x / 100))) + parent.position.x
        local yDrawPos = ((self.position.y * (parent.size.y / 100))) + parent.position.y
        local string = "fill";
        if (self.fill == false) then
            string = "line"
        end
        love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
        love.graphics.rectangle(string, xDrawPos, yDrawPos, self.size.x, self.size.y, 2, 2)
        love.graphics.setColor(1, 1, 1, 1)
        for i, element in pairs(self.children) do
            element:Draw(self, vector.new(xDrawPos, yDrawPos))
        end
    end

    function group:Update(parent, dt, scale)
        if (love.mouse.isDown(1)) then
            local xDrawPos = ((self.position.x * (parent.size.x / 100))) + parent.position.x
            local yDrawPos = ((self.position.y * (parent.size.y / 100))) + parent.position.y
            local width, height = love.window.getMode()
            width = width / scale.x
            height = height / scale.y
            local MousePos = vector.new(love.mouse.getX() / width, love.mouse.getY() / height)
            if (CheckCollision(MousePos, vector.new(1, 1), vector.new(xDrawPos, yDrawPos), self.size)) then
                debuginfo[1] = debuginfo[1] + 1
                self.onclick()
            end
        end
    end

    function group:GetElement(key)
        return self[key]
    end

    return group
end
