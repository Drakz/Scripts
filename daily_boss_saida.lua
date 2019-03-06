dofile('data/movements/lib/boss.lua')

local config = {
	storage_boss = "b_daily_",
	storage_evento = "b_evento_",
	storage_player = "b_player_",
	delay = 20*60*60
}

function onStepIn(cid, item, position, fromPosition)
	setGlobalStorageValue(config.storage_boss..saidas[tostring(position.x..position.y)].id, 0)
	doCreatureSetStorage(cid, config.storage_player..saidas[tostring(position.x..position.y)].id, os.time() + config.delay)
	stopEvent(getGlobalStorageValue(config.storage_evento..saidas[tostring(position.x..position.y)].id))
	doTeleportThing(cid, saidas[tostring(position.x..position.y)].saida)
	return true
end