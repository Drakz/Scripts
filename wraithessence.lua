local config = {
    ctrl_storage = 2147483648,
    storage = "wraith",
    storage_summon = "wraith_still",
	storage_essence = "w_essence",
    pos = {x = 299, y = 454, z = 8},
    pilar = {{x = 296, y = 451, z = 8},{x = 302, y = 451, z = 8},{x = 302, y = 457, z = 8},{x = 296, y = 457, z = 8}},
    effect = 3
}

function onDeath(cid, attacker, type, combat, value)
	if(getGlobalStorageValue(config.storage_essence) > 3) then
		setGlobalStorageValue(config.storage_essence, -1)
	end
    doSendDistanceShoot(config.pilar[math.random(1,#config.pilar)], config.pos, config.effect)
    local aux = getGlobalStorageValue(config.storage_essence)
    setGlobalStorageValue(config.storage_essence, aux + 1)
    if(getGlobalStorageValue(config.storage_essence) == 3) then
    	setGlobalStorageValue(config.storage_essence, -1)
    	doRemoveCreature((getGlobalStorageValue(config.storage_summon)+config.ctrl_storage))
    	doTeleportThing((getGlobalStorageValue(config.storage)+config.ctrl_storage), config.pos,false)
    end
    return false
end