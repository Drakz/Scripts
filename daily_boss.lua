dofile('data/movements/lib/boss.lua')

local config = {
	storage_boss = "b_daily_",
	storage_evento = "b_evento_",
	storage_player = "b_player_",
	delay = 20*60*60
}

function SecondsToClock(seconds)
  if seconds <= 0 then
    return "00:00:00"
  else
    local days = math.floor(seconds/86400)
    local hours = math.floor(math.fmod(seconds, 86400)/3600)
    local minutes = math.floor(math.fmod(seconds,3600)/60)
    local secs = math.floor(math.fmod(seconds,60))
    if(days > 0) then
    	return days.." dias "..hours.." horas "..minutes.." minutos e "..secs.." segundos."
    elseif(hours > 0) then
    	return hours.." horas "..minutes.." minutos e "..secs.." segundos."
  	elseif(minutes > 0) then
  		return minutes.." minutos e "..secs.." segundos."
  	else
  		return secs.." segundos."
  	end
  end--Done
end

function checkArea(a_pos)--Done
	for i = arenas[tostring(a_pos.x..a_pos.y)].top_x, arenas[tostring(a_pos.x..a_pos.y)].bot_x do
		for j = arenas[tostring(a_pos.x..a_pos.y)].top_y, arenas[tostring(a_pos.x..a_pos.y)].bot_y do
			local monster = getTopCreature({x = i, y = j, z = arenas[tostring(a_pos.x..a_pos.y)].arena_z}).uid
			if (isMonster(monster) == true) then
				doRemoveCreature(monster)
			end
		end
	end
	local boss = getTopCreature(boss[tostring(a_pos.x..a_pos.y)].pos_hide).uid
	if(isMonster(boss) == true) then
		doRemoveCreature(boss)
	end
end

function spawnBoss(b_pos)--Done
	doCreateMonster(boss[tostring(b_pos.x..b_pos.y)].nome, boss[tostring(b_pos.x..b_pos.y)].pos)
end

function removePlayer(cid, pos_saida, pos_tp)--done
	if(isPlayer(cid) == true) then
		doCreatureSetStorage(cid, config.storage_player..pos_tp.x..pos_tp.y, os.time() + config.delay)
		setGlobalStorageValue(config.storage_boss..pos_tp.x..pos_tp.y, 0)
		doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE, 'O tempo para matar o boss chegou ao fim e voce foi jogado para fora da arena.')
		doTeleportThing(cid, pos_saida)
	end
end

function onStepIn(cid, item, position, fromPosition)--done(?)
    if getPlayerLevel(cid) < arenas[tostring(position.x..position.y)].level_min or getPlayerLevel(cid) > arenas[tostring(position.x..position.y)].level_max then
        doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE, 'Apenas jogadores do level '..arenas[tostring(position.x..position.y)].level_min..' ate o level '..arenas[tostring(position.x..position.y)].level_max..' podem enfrentar esse boss.')
        doTeleportThing(cid, fromPosition)
    elseif(getCreatureStorage(cid,config.storage_player..position.x..position.y) > os.time() and getCreatureStorage(cid,config.storage_player..position.x..position.y) ~= -1) then
    	doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE, 'Tempo para tentar novamente: '..SecondsToClock(getCreatureStorage(cid,config.storage_player..position.x..position.y)-os.time()))
    	doTeleportThing(cid, fromPosition)
    elseif(getGlobalStorageValue(config.storage_boss..position.x..position.y) == 1) then
    	doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE, 'Algum jogador esta enfrentando esse boss no momento.')
    	doTeleportThing(cid, fromPosition)
    else
    	local evento = addEvent(removePlayer, arenas[tostring(position.x..position.y)].tempo, cid, fromPosition, position)
    	setGlobalStorageValue(config.storage_boss..position.x..position.y, 1)
    	setGlobalStorageValue(config.storage_evento..position.x..position.y, evento)
    	doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE, 'Voce tem '..(arenas[tostring(position.x..position.y)].tempo/60000)..' minutos para matar o boss ou sera teletransportado para fora da arena, caso entre no teleport de saida devera esperar um tempo de 20 horas para poder enfrentar o boss novamente.')
        doTeleportThing(cid, arenas[tostring(position.x..position.y)].entrada)
        checkArea(position)
        spawnBoss(position)
    end
   return true
end

--addEvent()
--stopEvent(eventid)
