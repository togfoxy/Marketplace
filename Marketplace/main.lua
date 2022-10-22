

require 'marketplace'

require 'constants'
inspect = require 'lib.inspect'
-- https://github.com/kikito/inspect.lua

cf = require 'lib.commonfunctions'
require 'draw'


function love.load()

    constants.load()        -- loads globals and constants

    persons = {}
    local newperson = {}
    newperson.guid = cf.getUUID()

    newperson.commodityKnowledge = {}
    newperson.commodityKnowledge["sugar"] = {1,2,1,1,1,1,1,3,4,5,2,5,3}

    newperson.beliefRange = {}
    newperson.beliefRange["sugar"] = {2,5}

    newperson.inventory = {}
    newperson.inventory["sugar"] = love.math.random(0, 10)

    newperson.inventoryHistory = {}
    newperson.inventoryHistory["sugar"] = {3,5,7,3,2,newperson.inventory["sugar"]}

    table.insert(persons, newperson)

    local bidqty = marketplace.determineBidQty("sugar", 10, persons[1].commodityKnowledge["sugar"])
    bidqty = cf.round(bidqty)
    print("Bid qty = " .. bidqty)

    --! need to determine bidprice which is a rndnum in belief range
    bidprice = marketplace.determineBidPrice(persons[1].beliefRange["sugar"])

    marketplace.createBid("sugar", bidqty, bidprice, "Fox")
    print("Fox made a bid for sugar. Preferred qty = " .. bidqty .. " at price $" .. bidprice)


    marketplace.createBid("wheat", 3, 150, "Fox")
    marketplace.createBid("sugar", 4, 175, "Bob")

    marketplace.createAsk("sugar", 7, 156, "Fred")
    marketplace.createAsk("wheat", 2, 100, "Samual")



end

function love.draw()

    draw.allInventory(100)      -- number is the y value down the screen



end


function love.update()


end
