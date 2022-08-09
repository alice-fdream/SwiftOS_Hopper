local ser = require('serialization')

function css_ref()
local fils = io.open('/system/SwiftOS/themes/current_theme.dll')
local object = fils:read()
fils:close()

local fils = io.open('/system/SwiftOS/themes/list/' .. object .. '/data')
local arrays = fils:read()
fils:close()

local th = ser.unserialize(arrays)


backgr = tonumber(th[1])

text = tonumber(th[13])

close_button = tonumber(th[5])

shadow_window = tonumber(th[12])

button_def = tonumber(th[3])

button_text = tonumber(th[4])

button_active = tonumber(th[2])

main_text = tonumber(th[11])

input_back = tonumber(th[8])

input_back_foc = tonumber(th[9])

colorDesktop = tonumber(th[6])

dock_apps = tonumber(th[7])

input_text = tonumber(th[10])

end
