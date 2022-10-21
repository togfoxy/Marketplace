

require 'marketplace'
inspect = require 'lib.inspect'
-- https://github.com/kikito/inspect.lua

cf = require 'lib.commonfunctions'

function love.load()

    local persons = {}
    local newperson = {}
    newperson.guid = cf.getUUID()
    newperson.commodityKnowledge = {}
    newperson.commodityKnowledge["sugar"] = {1,2,1,1,1,1,1,3,4,5,2,5,3}
    table.insert(persons, newperson)

    local bidqty = marketplace.determineBidQty("sugar", 10, persons[1].commodityKnowledge["sugar"])
    bidqty = cf.round(bidqty)
    print("Bid qty = " .. bidqty)

    -- need to determine bidprice which is a rndnum in belief range
    local belieflow, beliefhigh = marketplace.determineBeliefRange(persons[1].commodityKnowledge["sugar"])
    local bidprice = love.math.random(belieflow, beliefhigh)    --! does whole numbers only!!

    marketplace.createBid("sugar", bidqty, bidprice, "Fox")
    print("Fox made a bid for sugar. Preferred qty = " .. bidqty .. " at price $" .. bidprice)


    marketplace.createBid("wheat", 3, 150, "Fox")
    marketplace.createBid("sugar", 4, 175, "Bob")

    marketplace.createAsk("sugar", 7, 156, "Fred")
    marketplace.createAsk("wheat", 2, 100, "Samual")



end

function love.draw()

end


function love.update()


end
