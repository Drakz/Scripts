function onLogin(cid)
    for k, v in pairs(getConfigValue("dungeons")) do
        if(getPlayerStorageValue(cid,k) == 1) then
            if v.pos.x == -1 then
                doTeleportThing(cid,v.pos)
            else
                doTeleportThing(cid,getTownTemplePosition(getPlayerTown(cid)))
            end
            setPlayerStorageValue(cid,k,-1)
            break
        end
    end
 	return true
end