function draw(drawbuffer, tilebuffer)
    love.graphics.print(boolToString(setdebugge), 0, 0)

    for i, entity in pairs(drawbuffer) do
        if (entity.defaultDraw == true) then
            love.graphics.draw(entity.sprite, entity.position.x, entity.position.y, entity.r or 0, 1, 1, entity.ox or 0,
                entity.oy or 0)
        end
        for i, event in pairs(entity.draw_events) do
            event()
        end
        love.graphics.rectangle("line", entity.position.x, entity.position.y, entity.size.x, entity.size.y)
    end

    for i, tile in pairs(tilebuffer) do
        tile:drawdebug()
    end
end

function addToDrawBuffer(entity, drawbuffer)
    table.insert(drawbuffer, #drawbuffer + 1, entity)
end
