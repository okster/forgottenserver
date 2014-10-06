local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:eek:nCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:eek:nCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:eek:nCreatureSay(cid, type, msg) end
function onThink() npcHandler:eek:nThink() end

npcHandler:setMessage(MESSAGE_GREET, "Hello, type {account} to create a new account, {character} to add a new character or {manage} to see all available features.")

local config =
{
newPlayerChooseVoc = getConfigValue("newPlayerChooseVoc"),
newPlayerSpawnPosX = getConfigValue("newPlayerSpawnPosX"),
newPlayerSpawnPosY = getConfigValue("newPlayerSpawnPosY"),
newPlayerSpawnPosZ = getConfigValue("newPlayerSpawnPosZ"),
newPlayerTownId = getConfigValue("newPlayerTownId"),
newPlayerLevel = getConfigValue("newPlayerLevel"),
newPlayerMagicLevel = getConfigValue("newPlayerMagicLevel"),
generateAccountNumber = getConfigValue("generateAccountNumber")
}

local account = 
{
name = {},
pass = {}
}

local character = 
{
name = {},
voc = {},
sex = {}
}
local toBe = 0
local capMax = 400
local voc =
{
["wizard"] = 1,
["druid"] = 2,
["paladin"] = 3,
["warrior"] = 4
["cleric"] = 2,
["ranger"] = 2,
["rogue"] = 2,
["druid"] = 2,
["necromancer"] = 9,
}
function creatureSayCallback(cid, type, msg)

if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_PRIVATE and 0 or cid
if msgcontains(msg, "account") then
npcHandler:say("What would you like your password to be?", cid)
talkState[talkUser] = 1
elseif talkState[talkUser] == 1 then
if msg ~= "" or msg ~= nil then
toBe = string.gsub(msg, "[!'·#$%&/()=?¿¡.*\|;:,><{}]", "")
npcHandler:say(toBe .. " is it {yes} or {no}?", cid)
talkState[talkUser] = 2
else
npcHandler:say("What would you like your password to be?", cid)
end
elseif talkState[talkUser] == 2 and msgcontains(msg, "no") then
npcHandler:say("What would you like your password to be?", cid)
talkState[talkUser] = 1
elseif talkState[talkUser] == 2 and msgcontains(msg, "yes") then
account.pass[cid] = toBe
if config.generateAccountNumber then
toBe = string.format("%s%s%s%s%s%s%s", math.random(1, 9), math.random(1, 9), math.random(1, 9), math.random(1, 9), math.random(1, 9), math.random(1, 9), math.random(1, 9))
local query = db.getResult("select id from accounts where name = " .. toBe .. ";")
if query:getID() == -1 then
account.name[cid] = toBe
local query_ = db.executeQuery("insert into accounts (name, password) values (" .. db.escapeString(account.name[cid]) .. ", " .. db.escapeString(account.pass[cid]) .. ");")
if query_ then
npcHandler:say("Your account has been created, you may {manage} it now, but remember your account name: {" .. account.name[cid] .. "} and password: {" .. account.pass[cid] .. "}!", cid)
talkState[talkUser] = 0
else
npcHandler:say("Your account cannot be created.", cid)
talkState[talkUser] = 0
end
end
else
npcHandler:say("What would you like your account name to be?", cid)
talkState[talkUser] = 3
end
elseif talkState[talkUser] == 3 then
if msg ~= "" or msg ~= nil then
toBe = string.gsub(msg, "[!·#$%&¬/()=?'¿¡.*\|;:,><{}]", "")
if toBe == account.pass[cid] then
npcHandler:say("Your account name cannot be the same as your password.", cid)
talkState[talkUser] = 3
else
npcHandler:say(toBe .. " is it {yes} or {no}?", cid)
talkState[talkUser] = 4
end
else
npcHandler:say("What would you like your account name to be?", cid)
end
elseif talkState[talkUser] == 4 and msgcontains(msg, "no") then
npcHandler:say("Od... then what would you like your account name to be?", cid)
talkState[talkUser] = 3
elseif talkState[talkUser] == 4 and msgcontains(msg, "yes") then
local query = db.getResult("select id from accounts where name = " .. db.escapeString(toBe) .. ";")
local deny = false
if query:getID() ~= -1 then
deny = true
query:free()
end
if deny then
npcHandler:say("An account with that name already exists, please try another account name.", cid)
talkState[talkUser] = 3
else
account.name[cid] = toBe
local query = db.executeQuery("insert into accounts (name, password) values (" .. db.escapeString(account.name[cid]) .. ", " .. db.escapeString(account.pass[cid]) .. ");")
if query then
npcHandler:say("Your account has been created, you may {manage} it now, but remember your account name: {" .. account.name[cid] .. "} and password: {" .. account.pass[cid] .. "}!", cid)
talkState[talkUser] = 0
else
npcHandler:say("Your account cannot be created.", cid)
talkState[talkUser] = 0
end
end
elseif msgcontains(msg, "manage") then
account.name[cid] = (account.name[cid] or getPlayerAccount(cid))
local query = db.getResult("select password from accounts where name = " .. db.escapeString(account.name[cid]) .. ";")
if query:getID() ~= -1 then
account.pass[cid] = (account.pass[cid] or query:getDataString("password"))
query:free()
end
npcHandler:say("You can {change} your pass or create a new {character}.", cid)
talkState[talkUser] = 5
elseif msgcontains(msg, "change") then
npcHandler:say("Tell me your new password please.", cid)
talkState[talkUser] = 6
elseif talkState[talkUser] == 6 then
if msg ~= "" or msg ~= nil then
toBe = string.gsub(msg, "[!'·#$%&/()=?¿¡.*\|;:,><{}]", "")
if string.len(toBe) < 6 then
npcHandler:say("That password is too short, at least 6 digits are required. Please select a longer password.", cid)
else
npcHandler:say("Should {" .. toBe .. "} be your new password?", cid)
talkState[talkUser] = 7
end
else
npcHandler:say("What would you like your new password to be?", cid)
end
elseif talkState[talkUser] == 7 and msgcontains(msg, "no") then
npcHandler:say("Then not.", cid)
talkState[talkUser] = 0
elseif talkState[talkUser] == 7 and msgcontains(msg, "yes") then
local query = db.executeQuery("update accounts set password = " .. db.escapeString(toBe) .. " where name = " .. db.escapeString(getPlayerAccount(cid)).. ";")
if query then
npcHandler:say("Your password has been changed.", cid)
talkState[talkUser] = 0
else
npcHandler:say("Your password cannot be changed.", cid)
talkState[talkUser] = 0
end
elseif msgcontains(msg, "character") then
local query = db.getResult("select count(id) as count from players where account_id = " .. getPlayerAccountId(cid) .. ";")
if query:getID() ~= -1 then
local t = query:getDataInt("count")
if t >= 15 then
npcHandler:say("Your account reach the limit of 15 players, you need delete a character if you want to create a new one.", cid)
talkState[talkUser] = 0
else
npcHandler:say("What would you like as your character name?", cid)
talkState[talkUser] = 8
end
query:free()
end
elseif talkState[talkUser] == 8 then
if msg ~= "" or msg ~= nil then
toBe = string.gsub(msg, "[!'·#$%&/()=?¿¡.*\|;:,><{}]", "")
if string.len(toBe) < 4 then
npcHandler:say("Your name you want is too short, please select a longer name.", cid)
elseif string.len(toBe) > 20 then
npcHandler:say("Your name you want is too long, please select a longer name.", cid)
elseif string.sub(toBe, 0, 4) == "god " or isInArray({"gm ", "cm "}, string.sub(toBe, 0, 3)) then
npcHandler:say("Your character is not a staff member, please tell me another name!", cid)
elseif string.sub(toBe, 0, 1) == string.sub(toBe, 0, 1):lower() then
npcHandler:say("Your name can not be the first letter in lower case.", cid)
else
local query = db.getResult("select id from players where name = " .. db.escapeString(toBe) .. ";")
if query:getID() ~= - 1 then
npcHandler:say("A player with that name already exists, please choose another name.", cid)
query:free()
else
npcHandler:say(toBe .. " is it {yes} or {no}?", cid)
talkState[talkUser] = 9
end
end
else
npcHandler:say("What would you like as your character name?", cid)
end
elseif talkState[talkUser] == 9 and msgcontains(msg, "no") then
npcHandler:say("What else would you like to name your character?", cid)
talkState[talkUser] = 8
elseif talkState[talkUser] == 9 and msgcontains(msg, "yes") then
character.name[cid] = toBe
npcHandler:say("Should your character be a {male} or a {female}.", cid)
talkState[talkUser] = 10
elseif talkState[talkUser] == 10 and msgcontains(msg, "male") or msgcontains(msg, "female") then
toBe = (msg == "male" and 1 or 0)
npcHandler:say("A " .. msg .. ", are you sure?", cid)
talkState[talkUser] = 11
elseif talkState[talkUser] == 11 and msgcontains(msg, "no") then
npcHandler:say("Tell me... would you like to be a {male} or a {female}?", cid)
talkState[talkUser] = 10
elseif talkState[talkUser] == 11 and msgcontains(msg, "yes") then
character.sex[cid] = toBe
if config.newPlayerChooseVoc then
npcHandler:say("What do you want to be... {sorcerer}, {druid}, {paladin} or {knight}.", cid)
talkState[talkUser] = 12
else
character.voc[cid] = 0
local query = db.executeQuery("insert into players (id, name, world_id, group_id, account_id, level, vocation, health, healthmax, experience, lookbody, lookfeet, lookhead, looklegs, looktype, lookaddons, maglevel, mana, manamax, manaspent, soul, town_id, posx, posy, posz, conditions, cap, sex, lastlogin, lastip, skull, skulltime, save, rank_id, guildnick, lastlogout, blessings, online) VALUES (NULL, " .. db.escapeString(character.name[cid]) .. ", " .. getConfigValue("worldId") .. ", 1, " .. getAccountIdByAccount(account.name[cid]) .. ", " .. config.newPlayerLevel .. ", " .. character.voc[cid] .. ", " .. getVocationInfo(character.voc[cid]).healthGain * config.newPlayerLevel .. ", " .. getVocationInfo(character.voc[cid]).healthGain * config.newPlayerLevel .. ", " .. (config.newPlayerLevel < 2 and 0 or getExperienceForLevel(config.newPlayerLevel)) .. ", 68, 76, 78, 39, " .. (character.sex[cid] == 1 and 136 or 128) .. ", 0, " .. config.newPlayerMagicLevel .. ", 0, 0, 0, 100, " .. config.newPlayerTownId .. ", " .. config.newPlayerSpawnPosX .. ", " .. config.newPlayerSpawnPosY .. ", " .. config.newPlayerSpawnPosZ .. ", 0, " .. capMax + getVocationInfo(character.voc[cid]).capacity * config.newPlayerLevel .. ", " .. character.sex[cid] .. ", 0, 0, 0, 0, 1, 0, '', 0, 0, 0);")
if query then
npcHandler:say("Your character has been created.", cid)
talkState[talkUser] = 0
else
npcHandler:say("Your character couldn't be created, please try again.", cid)
talkState[talkUser] = 5
end
end
elseif talkState[talkUser] == 12 then
if voc[msg] then
npcHandler:say("So you would like to be " .. msg .. "... are you sure?", cid)
toBe = voc[msg]
talkState[talkUser] = 13
else
npcHandler:say("I don't understand what vocation you would like to be... could you please repeat it?", cid)
end
elseif talkState[talkUser] == 13 and msgcontains(msg, "no") then
npcHandler:say("No? Then what would you like to be?", cid)
talkState[talkUser] = 12
elseif talkState[talkUser] == 13 and msgcontains(msg, "yes") then
character.voc[cid] = toBe
local query = db.executeQuery("insert into players (id, name, world_id, group_id, account_id, level, vocation, health, healthmax, experience, lookbody, lookfeet, lookhead, looklegs, looktype, lookaddons, maglevel, mana, manamax, manaspent, soul, town_id, posx, posy, posz, conditions, cap, sex, lastlogin, lastip, skull, skulltime, save, rank_id, guildnick, lastlogout, blessings, online) VALUES (NULL, " .. db.escapeString(character.name[cid]) .. ", " .. getConfigValue("worldId") .. ", 1, " .. getAccountIdByAccount(account.name[cid]) .. ", " .. config.newPlayerLevel .. ", " .. character.voc[cid] .. ", " .. getVocationInfo(character.voc[cid]).healthGain * config.newPlayerLevel .. ", " .. getVocationInfo(character.voc[cid]).healthGain * config.newPlayerLevel .. ", " .. (config.newPlayerLevel < 2 and 0 or getExperienceForLevel(config.newPlayerLevel)) .. ", 68, 76, 78, 39, " .. (character.sex[cid] == 1 and 136 or 128) .. ", 0, " .. config.newPlayerMagicLevel .. ", 0, 0, 0, 100, " .. config.newPlayerTownId .. ", " .. config.newPlayerSpawnPosX .. ", " .. config.newPlayerSpawnPosY .. ", " .. config.newPlayerSpawnPosZ .. ", 0, " .. capMax + getVocationInfo(character.voc[cid]).capacity * config.newPlayerLevel .. ", " .. character.sex[cid] .. ", 0, 0, 0, 0, 1, 0, '', 0, 0, 0);")
if query then
npcHandler:say("Your character has been created.", cid)
talkState[talkUser] = 0
else
npcHandler:say("Your character couldn't be created, please try again.", cid)
talkState[talkUser] = 5
end
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())