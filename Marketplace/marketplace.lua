marketplace = {}

local bidtable = {}
local asktable = {}

function marketplace.determineCommodityPrice(beliefRange)
    -- this is called by buyers and sellers

    local min = beliefRange[1]
    local max = beliefRange[2]
    assert(min <= max)
    return love.math.random(min, max)       --! only does whole numbers
end

local function determineMeanPrice(commodityKnowledge)
    -- returns three values

    local countprice
    local minprice
    local maxprice
    local meanprice
    local sumprice

    countprice = #commodityKnowledge
    for i = 1, #commodityKnowledge do
        local historicprice = commodityKnowledge[i]
        if minprice == nil or historicprice < minprice then
            minprice = historicprice
        end
        if maxprice == nil or historicprice > maxprice then
            maxprice = historicprice
        end
        sumprice = sumprice + historicprice
    end
    local meanprice
    if countprice == 0 then
        meanprice = 5       --! might need to build in a default average at some point
    else
        meanprice = sumprice / countprice
    end
    return minprice, maxprice, meanprice
end

local function determineMeanWithinPriceRange(minprice, maxprice, meanprice)
    -- determine where the mean sits in the observed range
    local observedmeanrange
    observedmeanrange = maxprice - minprice
    if observedmeanrange == 0 then observedmeanrange = 1 end
    local abovefloor = meanprice - minprice
    return (abovefloor / observedmeanrange)
end

function marketplace.determineQty(commodity, maxQty, commodityKnowledge)
    -- given commodity knowledge return the bid qty for stated commodity

    -- commodity = item to buy
    -- print(inspect(commodityKnowledge))

    local minprice = nil
    local maxprice = nil
    local meanprice = nil
    local sumprice = 0      -- to determine average
    local countprice = 0
    if commodityKnowledge == nil then
        -- No knowledge of this commodity. Play safe and just ask for half qty.
        return maxQty / 2
    end

    -- determine key prices for this commodity
    minprice, maxprice, meanprice = determineMeanPrice(commodityKnowledge)
    if maxprice == nil then maxprice = 10 end   --! need to treat mean price the same as min/max price
    if minprice == nil then minprice = 1 end

    -- determine where the mean sits in the observed range
    local percent = determineMeanWithinPriceRange(minprice, maxprice, meanprice)

    -- flip the percent to get favourability
    local favourability = 1 - percent
    return favourability * maxQty
end

function marketplace.createBid(commodity,buyAtMostQty,bidPrice,playerID)
    -- creates a bid (request to buy) for the stated commodity
    -- ensure price is in correct currency and units

    -- commodity = item to buy
    -- buyAtMostQty = how many items to buy. Seller might have less!
    -- bidPrice = how much buyer is prepared to pay PER ITEM
    -- playerID = guid, id, obect or similar

    local bid = {buyAtMostQty, bidPrice, playerID}

    if bidtable[commodity] == nil then
        bidtable[commodity] = {}
    end
    table.insert(bidtable[commodity], bid)

    -- print(inspect(bidtable))
end

function marketplace.createAsk(commodity, sellAtMostQty, askPrice, playerID)
    -- creates an ask fro the stated commodity
    -- ensure price is in correct currency and units

    -- commodity = item to sell
    -- sellAtMostQty = how many items to buy. Buyer might want more or less!
    -- askPrice = how much seller is prepared to sell PER ITEM
    -- playerID = guid, id, obect or similar

    local ask = {sellAtMostQty, askPrice, playerID}
    if asktable[commodity] == nil then
        asktable[commodity] = {}
    end
    table.insert(asktable[commodity], ask)
end
return marketplace
