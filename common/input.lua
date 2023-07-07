function GetInputVector(up, down, left, right)
    dir = vector.new(0, 0)
    if (love.keyboard.isDown(up)) then
        dir.y = dir.y + 1
    end
    if (love.keyboard.isDown(down)) then
        dir.y = dir.y - 1
    end
    if (love.keyboard.isDown(left)) then
        dir.x = dir.x + 1
    end
    if (love.keyboard.isDown(right)) then
        dir.x = dir.x - 1
    end
    return dir
end