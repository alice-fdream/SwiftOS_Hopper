local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')
local unicode = require('unicode')
local event = require('event')

msg = ...

local log = io.open('/system/systemDATA/logs/log.swos', 'a')
log:write('SwiftOS log: user: [' .. os.getenv('PLA') .. '] ' .. msg .. ' \n')
log:close()

errors = GUI.container(mainContainer.width/2-35, 1, 70, 14)

local panel = GUI.panel (1, 1, errors.width-1, errors.height-1, input_back_foc)
errors:addChild (panel)
errors:addChild (GUI.label (3, 2, panel.width, 1, close_button, "Ошибка"))
errors:addChild(GUI.panel(2, errors.height, panel.width, 1, shadow_window))
errors:addChild(GUI.panel(errors.width, 2, 1, panel.height-1, shadow_window))
errors.touchX, errors.touchY = 0, 0


errors:addChild (GUI.label (3, 3, panel.width, 1, text, "Компьютер приостановил работу из-за возникшей ошибки:"))


page = {msg, "***"}

i = 0

xy = 5




while true do

i = i + 1
if page[i] == "***" then
break
else



sum = unicode.len(page[i])

if sum >= 67 then

race = sum / 67

rtx = math.ceil(race)

f = 0
esum = 66
bsum = 1

while f < rtx do

errors:addChild (GUI.label (3, xy, panel.width, 1, main_text, unicode.sub(page[i], bsum, esum)))

bsum = bsum + 66
esum = esum + 66

xy = xy + 1

f = f + 1
end
else
errors:addChild (GUI.label (3, xy, panel.width, 1, main_text, unicode.sub(page[i], bsum, esum)))
xy = xy + 1
end
end
end





errors.eventHandler = function(main, win, evname, _, x, y)
  if evname == "touch" then
    win.touchX, win.touchY = x, y
	 win:moveToFront()
    main:draw()
  elseif evname == "drag" then
    win.localX = ((x > win.touchX) and win.localX + 1) or ((x < win.touchX) and win.localX - 1) or win.localX
    win.localY = ((y > win.touchY) and win.localY + 1) or ((y < win.touchY) and win.localY - 1) or win.localY
    win.touchX, win.touchY = x, y
    main:draw()
  end
end


mainContainer:addChild (errors)
mainContainer:draw(true)