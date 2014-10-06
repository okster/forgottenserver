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

shopModule:addBuyableItem({'bow'}, 2456, 150, 'bow')
shopModule:addBuyableItem({'crossbow'}, 2455, 150, 'crossbow')
shopModule:addBuyableItem({'throwing knife'}, 2410, 50, 'throwing knife')
shopModule:addBuyableItem({'throwing star'}, 2399, 50, 'throwing star')
shopModule:addBuyableItem({'royal spear'}, 7378, 100, 'royal spear')
shopModule:addBuyableItem({'arrow'}, 2544, 1, 'arrow')
shopModule:addBuyableItem({'poison arrow'}, 2545, 2, 'poison arrow')
shopModule:addBuyableItem({'burst arrow'}, 2546, 5, 'burst arrow')
shopModule:addBuyableItem({'sniper arrow'}, 7364, 10, 'sniper arrow')
shopModule:addBuyableItem({'bolt'}, 2543, 2, 'bolt')
shopModule:addBuyableItem({'piercing bolt'}, 7363, 5, 'piercing bolt')
shopModule:addBuyableItem({'vortex bolt'}, 15649, 15, 'vortex bolt')
shopModule:addBuyableItem({'power bolt'}, 2547, 20, 'power bolt')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
