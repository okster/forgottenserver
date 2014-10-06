local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end

local travelNode = keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you wanna go to Carlin, are you sure?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler,  level = 1, cost = 0, destination = {x=32402, y=31815, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

local travelNode = keywordHandler:addKeyword({'goroma'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Dou you wanna go to Goroma, are you sure?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler,  level = 1, cost = 0, destination = {x=31994, y=32564, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

local travelNode = keywordHandler:addKeyword({'gengia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Dou you wanna go to Gengia, are you sure?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, level = 100, cost = 0, destination = {x=32071, y=32182, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

local travelNode = keywordHandler:addKeyword({'eremo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Dou you wanna go to Eremo, are you sure?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, level = 1, cost = 0, destination = {x=33316, y=31883, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

local travelNode = keywordHandler:addKeyword({'ethno'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Dou you wanna go to Ethno City, are you sure?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 1, cost = 0, destination = {x=32049, y=31974, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

local travelNode = keywordHandler:addKeyword({'yalahar'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you wanna go to Yalahar, are you sure?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, level = 1, cost = 0, destination = {x=615, y=380, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

        keywordHandler:addKeyword({'travel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can take you to Eremo, Gengia, Ethno, Goroma, Carlin and Yalahar.'})
        -- Makes sure the npc reacts when you say hi, bye etc.
        npcHandler:addModule(FocusModule:new())