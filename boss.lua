--Script de controle de teleports para bosses diarios

arenas = {
	["295455"] = { 
		level_min = 300, 
		level_max = 400, 
		tempo =  10 * 60 * 1000, 
		top_x = 288,top_y = 443, 
		bot_x = 308, bot_y = 466, 
		arena_z = 8,
		boss_hide = {x = 261, y = 228, z = 7}, 
		entrada = {x = 297, y = 464, z = 8}
	}-- wraith
}

boss = {
	["295455"] = { 
		nome = "Wraith", 
		pos = {x = 299, y = 454, z = 8},
		pos_hide = {x = 261, y = 228, z = 7}
	} --wraith
}

saidas = {
	["299444"] = {
		id = "295455",
		saida = {x = 296, y = 455, z = 6}
	} --wraith
}
