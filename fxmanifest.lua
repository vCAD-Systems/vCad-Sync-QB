fx_version 'bodacious'
game 'gta5'

name 'vCAD Sync - QB Version'
author 'Mîhó & Converted By Yamie'
version '1.0'

client_scripts {
    'configs/*.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'configs/*.lua',
    'server/*.lua',
}
