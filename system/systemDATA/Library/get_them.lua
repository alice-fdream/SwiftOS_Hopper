function css_ref()
local fils = io.open('/system/SwiftOS/themes/current_theme.dll')
local object = fils:read()
fils:close()


local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/backgr")
backgr = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/text")
text = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/close_button")
close_button = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/shadow_window")
shadow_window = tonumber(css:read())
css:close()


local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/button_def")
button_def = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/button_text")
button_text = tonumber(css:read())
css:close()


local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/button_active")
button_active = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/main_text")
main_text = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/input_back")
input_back = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/input_back_focused")
input_back_foc = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/colorDesktop")
colorDesktop = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/dock_apps")
dock_apps = tonumber(css:read())
css:close()

local css = io.open("/system/SwiftOS/themes/list/" .. object .. "/input_text")
input_text = tonumber(css:read())
css:close()


end
