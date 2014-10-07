local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'katana'}, 2412, 150, 'katana')
shopModule:addBuyableItem({'longsword'}, 2397, 400, 'longsword')
shopModule:addBuyableItem({'scimitar'}, 2419, 600, 'scimitar')
shopModule:addBuyableItem({'spike sword'}, 2383, 800, 'spike sword')
shopModule:addBuyableItem({'broadsword'}, 2413, 1000, 'broadsword')
shopModule:addBuyableItem({'hatchet'}, 2388, 100, 'hatchet')
shopModule:addBuyableItem({'steel axe'}, 8601, 300, 'steel axe')
shopModule:addBuyableItem({'orcish axe'}, 2428, 500, 'orcish axe')
shopModule:addBuyableItem({'battle axe'}, 2378, 750, 'battle axe')
shopModule:addBuyableItem({'barbarian axe'}, 2429, 1000, 'barbarian axe')
shopModule:addBuyableItem({'mace'}, 2398, 100, 'mace')
shopModule:addBuyableItem({'iron hammer'}, 2422, 250, 'iron hammer')
shopModule:addBuyableItem({'battle hammer'}, 2417, 500, 'battle hammer')
shopModule:addBuyableItem({'morning star'}, 2394, 750, 'morning star')
shopModule:addBuyableItem({'clerical mace'}, 2423, 1000, 'clerical mace')

shopModule:addSellableItem({'katana'}, 2412, 75, 'katana')
shopModule:addSellableItem({'longsword'}, 2397, 200, 'longsword')
shopModule:addSellableItem({'scimitar'}, 2419, 300, 'scimitar')
shopModule:addSellableItem({'spike sword'}, 2383, 500, 'spike sword')
shopModule:addSellableItem({'broadsword'}, 2413, 600, 'broadsword')
shopModule:addSellableItem({'hatchet'}, 2388, 60, 'hatchet')
shopModule:addSellableItem({'steel axe'}, 8601, 150, 'steel axe')
shopModule:addSellableItem({'orcish axe'}, 2428, 230, 'orcish axe')
shopModule:addSellableItem({'battle axe'}, 2378, 350, 'battle axe')
shopModule:addSellableItem({'barbarian axe'}, 2429, 500, 'barbarian axe')
shopModule:addSellableItem({'mace'}, 2398, 50, 'mace')
shopModule:addSellableItem({'iron hammer'}, 2422, 100, 'iron hammer')
shopModule:addSellableItem({'battle hammer'}, 2417, 200, 'battle hammer')
shopModule:addSellableItem({'morning star'}, 2394, 320, 'morning star')
shopModule:addSellableItem({'clerical mace'}, 2423, 5000, 'clerical mace')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
