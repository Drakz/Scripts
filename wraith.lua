local config_w = {
    ctrl_storage = 2147483648,
    storage = "wraith",
    storage_summon = "wraith_still",
    storage_stage = "w_stage",
    pos = {x = 299, y = 454, z = 8},
    pos_hide = {x = 261, y = 228, z = 7},
    monster_name = "Wraith Essence",
    still_name = "WraithStill",
    pos_summon = {{x = 295, y = 454, z = 8},{x = 303, y = 454, z = 8},{x = 299, y = 450, z = 8},{x = 299, y = 458, z = 8}}
}

function spawnMonster(f_cid)
    doTeleportThing(f_cid, config_w.pos_hide)
    local var = doCreateMonster(config_w.still_name, config_w.pos)
    setGlobalStorageValue(config_w.storage, (f_cid-config_w.ctrl_storage))
    setGlobalStorageValue(config_w.storage_summon, (var-config_w.ctrl_storage)) 
    for i=1,#config_w.pos_summon do
        doCreateMonster(config_w.monster_name, config_w.pos_summon[i])
    end
end

function onStatsChange(cid, attacker, type, combat, value)
    if not type == STATSCHANGE_HEALTHLOSS then
        return true
    end
    if(getCreatureStorage(cid,config_w.storage_stage) < 0 and getCreatureHealth(cid) < (getCreatureMaxHealth(cid)*0.7)) then
        spawnMonster(cid)
        doCreatureSetStorage(cid, config_w.storage_stage, 1)
        return false
    elseif(getCreatureStorage(cid,config_w.storage_stage) == 1 and getCreatureHealth(cid) < (getCreatureMaxHealth(cid)*0.3)) then
        spawnMonster(cid)
        doCreatureSetStorage(cid, config_w.storage_stage, 2)
        return false
    end
    return true
end