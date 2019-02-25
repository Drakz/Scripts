function onDeath(cid)
    local text = "dungeon_"..getCreatureStorage(cid,"dungeon").."_qtd"
    local aux = getGlobalStorageValue(text)
	setGlobalStorageValue(text, aux - 1)
	return false
end