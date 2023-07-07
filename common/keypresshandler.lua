
keys = {}
function initialize()
    keys = {}
end

function addKeyEvent(key, func)
    table.insert(keys,#keys+1,{key = key,func = func})
end


function keyHandler(key)
    for i, event in pairs(keys) do
        if (event.key == key) then
            event.func()
        end
    end
end