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

shopModule:addBuyableItem({'chain armor'}, 2464, 150, 'chain armor')
shopModule:addBuyableItem({'scale armor'}, 2483, 300, 'scale armor')
shopModule:addBuyableItem({'brass armor'}, 2465, 500, 'brass armor')
shopModule:addBuyableItem({'dark armor'}, 2489, 800, 'dark armor')
shopModule:addBuyableItem({'plate armor'}, 2463, 1000, 'plate armor')
shopModule:addBuyableItem({'chain legs'}, 2648, 350, 'chain legs')
shopModule:addBuyableItem({'brass legs'}, 2478, 700, 'brass legs')
shopModule:addBuyableItem({'plate legs'}, 2647, 1000, 'plate legs')
shopModule:addBuyableItem({'legion helmet'}, 2480, 200, 'legion helmet')
shopModule:addBuyableItem({'soldier helmet'}, 2481, 500, 'soldier helmet')
shopModule:addBuyableItem({'dark helmet'}, 2490, 1000, 'dark helmet')
shopModule:addBuyableItem({'steel helmet'}, 2457, 1000, 'steel helmet')
shopModule:addBuyableItem({'steel shield'}, 2509, 200, 'steel shield')
shopModule:addBuyableItem({'battle shield'}, 2513, 500, 'battle shield')
shopModule:addBuyableItem({'dark shield'}, 2521, 800, 'dark shield')
shopModule:addBuyableItem({'ancient shield'}, 2532, 1000, 'ancient shield')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
