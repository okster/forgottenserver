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

shopModule:addBuyableItem({'small health'}, 8704, 50, 1, 'small health potion')
shopModule:addBuyableItem({'health potion'}, 7618, 100, 1, 'health potion')
shopModule:addBuyableItem({'mana potion'}, 7620, 100, 1, 'mana potion')
shopModule:addBuyableItem({'strong health'}, 7588, 200, 1, 'strong health potion')
shopModule:addBuyableItem({'strong mana'}, 7589, 200, 1, 'strong mana potion')
shopModule:addBuyableItem({'great health'}, 7591, 500, 1, 'great health potion')
shopModule:addBuyableItem({'great mana'}, 7590, 500, 1, 'great mana potion')
shopModule:addBuyableItem({'ultimate health'}, 8473, 1200, 1, 'ultimate health potion')
shopModule:addBuyableItem({'antidote potion'}, 8474, 1000, 1, 'antidote potion')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
