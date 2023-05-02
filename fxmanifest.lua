--===== FiveM Script =========================================
--= coke - YUPPZWORKSHOP CFX (Webhook)
--===== Developed By: ========================================
--= YUPPZWORKSHOP CFX
--= Copyright (C) YUPPZWORKSHOP CFX - All Rights Reserved
--= You are not allowed to sell this script or edit
--============================================================

fx_version 'adamant'
game 'gta5'

description 'YUPPz WORKSHOP CFX'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server/server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/client.lua'
}

dependencies {
	'es_extended',
}
