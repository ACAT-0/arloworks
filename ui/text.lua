require("common.color")
require("libs.vector")

--- Returns a new Text Component UI object.
---@param relativeposition table
---@param text string
---@param color table
---@param horizontallimit number
---@return table
function UITextComponent(relativeposition, text, color, horizontallimit)
    local group = {
        position = relativeposition,
        limit = horizontallimit or 100,
        text = text or "Whoever made this is stupid, and didn't add any text. Kill Yourself",
        color = color or Color(1, 1, 1, 1)
    }

    --- Draws the text object based on the object's relative vwh position. The limit to how fair the text can travel horizontally is capped at the end of the UI container.
    ---@param parent table the parent object of this UI object
    function group:Draw(parent)
        local xDrawPos = ((self.position.x * (parent.size.x / 100))) + parent.position.x
        local yDrawPos = ((self.position.y * (parent.size.y / 100))) + parent.position.y
        local limit = self.limit;
        if ((xDrawPos + limit) > parent.position.x + parent.size.x) then
            limit = (parent.size.x + parent.position.x) - xDrawPos
        end
        love.graphics.printf(text, xDrawPos, yDrawPos, limit, "left")
    end

    return group
end
