draw = {}


function draw.allInventory(yvalue)

    for i = 1, #persons do

        -- print(inspect(persons[i].inventoryHistory))
        local drawx = 0
        for cname, commodity in pairs(persons[i].inventoryHistory) do
            drawx = drawx + 100
            love.graphics.print(cname, drawx, yvalue)

            for k, invhistory in pairs(commodity) do
                drawx = drawx + 1
                drawy = yvalue + 100 - invhistory
                love.graphics.points(drawx,drawy)
            end
        end
    end
end







return draw
