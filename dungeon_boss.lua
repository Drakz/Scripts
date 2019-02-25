function onDeath(cid)
    local text = "dungeon_"..getCreatureStorage(cid,"dungeon").."_boss"
	setGlobalStorageValue(text, 1)
	return false
end