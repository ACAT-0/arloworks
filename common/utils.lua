function boolToString(bool)
    output = "nil"
    if (bool == true) then
        output = "true"
    else
        output = "false"
    end
    return output
end

function CheckCollision(pos1, size1, pos2, size2)
    local x1 = pos1.x;
    local x2 = pos2.x
    local y1 = pos1.y
    local y2 = pos2.y
    local w1 = size1.x
    local w2 = size2.x
    local h1 = size1.y
    local h2 = size2.y
    return x1 < x2 + w2 and
        x2 < x1 + w1 and
        y1 < y2 + h2 and
        y2 < y1 + h1
end
