function draw(drawbuffer, tilebuffer, camera)
    camera:draw(function(l, t, w, h)
        for i, entity in pairs(drawbuffer) do
            love.graphics.draw(entity.sprite, entity.position.x, entity.position.y, entity.r or 0, 1, 1, entity.ox or 0,
                entity.oy or 0)
            love.graphics.rectangle("line", entity.position.x, entity.position.y, entity.size.x, entity.size.y)
        end

        for i, tile in pairs(tilebuffer) do
            tile:drawdebug()
        end
    end)
end

function addToDrawBuffer(entity, drawbuffer)
    table.insert(drawbuffer, #drawbuffer + 1, entity)
end
