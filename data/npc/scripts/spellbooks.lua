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

shopModule:addBuyableItem({'spellbook'}, 2175, 150, 'spellbook')
shopModule:addBuyableItem({'holy magic book'}, 2163, 400, 'magic lightwand')
shopModule:addBuyableItem({'fire magic book'}, 8704, 20, 1, 'small health potion')
shopModule:addBuyableItem({'energy magic book'}, 7618, 45, 1, 'health potion')
shopModule:addBuyableItem({'frost magic book'}, 7620, 50, 1, 'mana potion')
shopModule:addBuyableItem({'dark magic book'}, 7588, 100, 1, 'strong health potion')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())