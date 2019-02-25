function SecondsToClock(seconds)

  if seconds <= 0 then
    return "00:00:00"
  else
    local days = math.floor(seconds/86400)
    local hours = math.floor(math.fmod(seconds, 86400)/3600)
    local minutes = math.floor(math.fmod(seconds,3600)/60)
    local secs = math.floor(math.fmod(seconds,60))
    if(days > 0) then
    	return days.." dias "..hours.." horas "..minutes.." minutos e "..secs.." segundos."
    elseif(hours > 0) then
    	return hours.." horas "..minutes.." minutos e "..secs.." segundos."
  	elseif(minutes > 0) then
  		return minutes.." minutos e "..secs.." segundos."
  	else
  		return secs.." segundos."
  	end
  end
end

function onSay(cid, words, param, channel)
	local delay = true
	for k, v in pairs(getConfigValue("dungeons")) do
		if(getPlayerStorageValue(cid,k) > os.time()) then
			local t = getPlayerStorageValue(cid,k) - os.time()
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você poderá refazer a "..v.nome.." em: "..SecondsToClock(t))
			delay = false
		end
	end
	if(delay) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você não precisa esperar para fazer qualquer dungeon.")
	end
	return true
end
