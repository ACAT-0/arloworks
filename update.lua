
function update(entitybuffer, delta)
    for i, entity in pairs(entitybuffer) do
        entity:update(delta)
        addToDrawBuffer(entity,drawbuffer)
    end
end