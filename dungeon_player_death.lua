function onDeath(cid)
    for k, v in pairs(getConfigValue("dungeons")) do
        if(getPlayerStorageValue(cid,k) == 1) then
			doCreatureSetDropLoot(cid, false)
            setPlayerStorageValue(cid,k,-1)
            break
        end
    end
    return true
end