function onSay(cid, words, param)
local message = "---------------------------- INFO ----------------------------\nO sistema de auto loot pode ser usado por players FREE e PREMIUM\n com a limita��o da quantidade de loots adicionados em suas respectivas listas.\n---------------------------- COMANDOS ----------------------------\n!addloot NOME DO ITEM - Adiciona um item a sua lista de loots.\n!checkloot - Checa a lista de loots que o sistema ir� pegar.\n!removeloot NOME DO ITEM - Remove um item da sua lista de loots.\n!clearloot - Limpa toda sua lista de loots atual."
doPlayerPopupFYI(cid, message)
return true
end