--Comando para adicionar loots na lista para autoloot

function onSay(cid, words, param)
	if getItemIdByName(param) == false then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Item inexistente.")
		return true
	end
	
	local texto = ""
	local config = { 
		item_free = 3, --Não mexer no -1
		item_premium = 10 --Não mexer no -1
	}
	if isPremium(cid) then
		if(tonumber(getPlayerStorageValue(cid, "loot_tam")) >= config.item_premium) then 
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sua lista de loots já chegou no seu limite.")
			return true
		end
	else
		if(tonumber(getPlayerStorageValue(cid, "loot_tam")) >= config.item_free) then 
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Sua lista de loots já chegou no seu limite.")
			return true
		end
	end
	local ctrl = false
	if getPlayerStorageValue(cid, "loot") == -1 then
		texto = "&"
		texto = texto..tostring(getItemIdByName(param))..":"
		doPlayerSetStorageValue(cid, "loot", texto)
		doPlayerSetStorageValue(cid, "loot_tam", 1)
	else
		local aux = getPlayerStorageValue(cid, "loot")
		string.gsub(aux, "(%d+)", function(d) if getItemIdByName(param) == tonumber(d) then ctrl = true end end)
		if ctrl == true then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Este item já foi adicionado.")
		return true
		end
		local textinho = getPlayerStorageValue(cid,"loot")
		texto = texto..textinho..tostring(getItemIdByName(param))..":"
		doPlayerSetStorageValue(cid, "loot", texto)
		doPlayerSetStorageValue(cid, "loot_tam", getPlayerStorageValue(cid, "loot_tam") + 1)
	end
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, param.." adicionado com sucesso.")
	return true
end
