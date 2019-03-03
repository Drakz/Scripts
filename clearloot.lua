function onSay(cid, words, param)
	doPlayerSetStorageValue(cid, "loot", -1)
	doPlayerSetStorageValue(cid, "loot_tam", -1)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Lista de loot apagada.")
return true
end