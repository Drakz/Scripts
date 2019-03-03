function onSay(cid, words)
local message = "---------------------------- LISTA DE LOOTS ----------------------------"
local msg = ""
if getPlayerStorageValue(cid, "loot") ~= -1 then
	string.gsub(getPlayerStorageValue(cid, "loot"), "(%d+)", function(x) msg = msg.."\n".."Item ID: "..x.." - "..getItemNameById(x) end)
else
msg = "\nVocê não tem nenhum loot registrado no momento\n utilize o comando !lootcheck para aprender mais sobre o sistema."
end
doPlayerPopupFYI(cid, message..msg)
return true
end

