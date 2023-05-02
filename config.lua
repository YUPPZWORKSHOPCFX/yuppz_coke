--===== FiveM Script =========================================
--= coke - YUPPZWORKSHOP CFX (Webhook)
--===== Developed By: ========================================
--= YUPPZWORKSHOP CFX
--= Copyright (C) YUPPZWORKSHOP CFX - All Rights Reserved
--= You are not allowed to sell this script or edit
--============================================================

Config 						= {}
Config.Cops                 = 0         -- @=> จำนวนตำรวจที่สามารถขโมยได้
Config.ItemCount            = {1, 2}    -- @=> ถ้าต้องการให้ได้ 1 ทุกครั้ง {1, 1} 2 ทุกครั้ง {2, 2} ถ้าให้สุ่ม {1, 2} ปรับแค่ตัวหลัง
Config.Time					= 5000  -- @=> เวลา
Config.Item = '?'  -- @=> ชื่อไอเทม
Config.Text = 'กำลังเก็บโคเคน'  -- @=> ชื่อเวลาเก็บ
NOTIFYPREE = function ()
	exports["?"]:ShowHelpNotification("กด ~INPUT_CONTEXT~ เก็บโคเคน") -- @=>TextUI
end

Config.CircleZones = {
	CokeField = {coords = vector3(-1631.3264, 4734.1357, 53.1707)}, -- @=> coords x y z
}

Config["Discord"] = {
    Webhook = '',-- @=> webhook
    Enable = false, -- @=> เปิดใช้ Discord Log แยก
    DiscordLog = function(playerId,text) -- @=> Log แยก
        TriggerEvent('azael_discordlogs:sendToDiscord', '?', sendToDiscord, xPlayer.source, '^2')--@=> azaellog
    end
}
