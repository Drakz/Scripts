function onSay(cid, words, param)
	if getItemIdByName(param) == false then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Item inexistente.")
		return true
	end
	if getPlayerStorageValue(cid, "loot") == -1 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Nenhum item registrado.")
		return true
	end
	local msg = "&"
	string.gsub(getPlayerStorageValue(cid, "loot"), "(%d+)", function(x) if tonumber(x) ~= getItemIdByName(param) then msg = msg..x..":" end end)
	if msg == "&" then
		doPlayerSetStorageValue(cid, "loot", -1)
		doPlayerSetStorageValue(cid, "loot_tam", -1)
	else
		doPlayerSetStorageValue(cid, "loot", msg)
		doPlayerSetStorageValue(cid, "loot_tam", getPlayerStorageValue(cid, "loot_tam") - 1)
	end
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, param.." foi removido com sucesso.")
return true
end