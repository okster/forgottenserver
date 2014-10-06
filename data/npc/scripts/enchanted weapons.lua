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

shopModule:addBuyableItem({'small enchanted ruby', 'enchanted ruby'}, 7760, 10000, 'enchanted ruby')
shopModule:addBuyableItem({'small enchanted sapphire', 'enchanted sapphire'}, 7759, 10000, 'enchanted sapphire')
shopModule:addBuyableItem({'small enchanted emerald', 'enchanted emerald'}, 7761, 10000, 'enchanted emerald')
shopModule:addBuyableItem({'small enchanted amethyst', 'enchanted amethyst'}, 7762, 10000, 'enchanted amethyst')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
