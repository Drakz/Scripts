function onSay(cid, words, param)
	if(param == "" or param == nil) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Digite o nome de um NPC.")
		return true
	end

	local npc = getCreatureByName(param)

	if isNpc(npc) == true then
		local pos_player = getCreaturePosition(cid)
		local pos_npc = getCreaturePosition(npc)
		local dx = pos_npc.x - pos_player.x
		local dy = pos_npc.y - pos_player.y
		local x = 0
		local y = 0
		local tan = 0
		if(dx ~= 0) then
        	tan = (dy/dx)
    	else
       		tan = 10.0
       	end
    	if(tan < 0.4142) then
        	if(dx > 0) then
            	if(dy < 0) then
               		x = 1
               		y = -1
               	else
            		x = 1
            		y = 0
            	end
        	else
        		if(dy > 0) then
                	x = -1
                	y = 1
                else
            		x = -1
            		y = 0
            	end
    		end
    	elseif(tan < 2.4142) then
        	if(tan > 0) then
            	if(dx > 0) then
            	    x = 1
            	    y = 1
            	else
            	    x = -1
            	    y = -1
        		end
        	end
    	else
        	if(dy > 0) then
            	x = 0
            	y = 1
        	else
            	x = 0
            	y = -1
            end
    	end
    	for i = 1, 2 do
    		doSendDistanceShoot(pos_player, {x = pos_player.x + x , y = pos_player.y + y , z = pos_player.z}, 2)
    	end
    	return true
	end
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Nenhum NPC com esse nome.")
	return true
end