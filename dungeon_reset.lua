function onSay(cid, words, param, channel)
	local txt = ""
	local i = 1
	if(param ~= "") then
		if(getPlayerStorageValue(cid,"dungeon_"..param) < 0) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Dungeon inexistente ou já resetada.")
		else
			setPlayerStorageValue(cid,"dungeon_"..param,-1)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Dungeon "..param.." resetada.")
		end
	else
    	for k, v in pairs(getConfigValue("dungeons")) do
			if(getPlayerStorageValue(cid, k) > 0) then
				setPlayerStorageValue(cid, k, -1)
				txt = txt.."["..i.."] "	
			end
			i = i + 1
		end
		if(txt == "") then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Nenhuma dungeon a ser resetada.")
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Dungeons resetadas: "..txt)
		end
	end
	return true
end