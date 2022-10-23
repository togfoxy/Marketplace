

require 'marketplace'

require 'constants'
inspect = require 'lib.inspect'
-- https://github.com/kikito/inspect.lua

cf = require 'lib.commonfunctions'
fun = require 'functions'
require 'draw'

function love.keyreleased( key, scancode )
	if key == "return" then
        processturn = true
    end

end


function love.load()

    constants.load()        -- loads globals and constants

	fun.initialisePersons()		-- set up a bunch of random person objects



	local maxqtytobuy = 10 - persons[1].inventory["sugar"]

    local bidqty = marketplace.determineBidQty("sugar", maxqtytobuy, persons[1].commodityKnowledge["sugar"]) -- commodity, maxQty, commodityKnowledge
    bidqty = cf.round(bidqty)

    -- need to determine bidprice which is a rndnum in belief range
    bidprice = marketplace.determineBidPrice(persons[1].beliefRange["sugar"])

    marketplace.createBid("sugar", bidqty, bidprice, "Fox")
    print("Fox made a bid for sugar. Preferred qty = " .. bidqty .. " at price $" .. bidprice)




    marketplace.createAsk("sugar", 7, 156, "Fred")
    marketplace.createAsk("wheat", 2, 100, "Samual")



end

function love.draw()

    draw.allInventory(100)      -- number is the y value down the screen



end


function love.update()

    if processturn then
        processturn = false
        -- deduct one sugar from each person
        for i = 1, #persons do
            persons[i].inventory["sugar"] = persons[i].inventory["sugar"] - 1
            if persons[i].inventory["sugar"] < 0 then persons[i].inventory["sugar"] = 0 end
            table.insert(persons[i].inventoryHistory["sugar"], persons[i].inventory["sugar"])
        end

    end


end
