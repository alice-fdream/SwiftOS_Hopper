local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')
local net = require('internet')
local unicode = require('unicode')
require('swift_term')

local mainContainer = ...

update = GUI.container(mainContainer.width/2-30, mainContainer.height/2-8, 60, 16)

local panel = GUI.panel (1, 1, update.width-1, update.height-1, backgr)
update:addChild (panel)
update:addChild (GUI.label (2, 2, panel.width, 1, text, "Обновление " .. os.getenv('NAME')))
update:addChild(GUI.panel(2, update.height, panel.width, 1, shadow_window))
update:addChild(GUI.panel(update.width, 2, 1, panel.height-1, shadow_window))
update.touchX, update.touchY = 0, 0

update:addChild(GUI.roundedButton (update.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    update:remove()
    mainContainer:draw()
end

 update:addChild (GUI.image (6, 4, buffer.loadImage("/system/SwiftOS/update/main.pic")))
 update:addChild (GUI.label (26, 7, panel.width, 1, text, "Текущая версия: " .. os.getenv('VER')))

 local handle = net.request('https://raw.githubusercontent.com/alice-fdream/SwiftOS/main/VERS')
    local result = ""
  for chunk in handle do
    result = result..chunk
  end
  local vers = unicode.sub(result, 1, -2)

  local swift_key={}
  for str in string.gmatch(vers, "([^%s]+)") do
      table.insert(swift_key, str)
  end
  if out2 ~= nil then
  pr('Avalable version ' .. swift_key[1])
end
  if swift_key[1] ~= os.getenv('VER') then
  update:addChild (GUI.label (26, 8, panel.width, 1, text, "Доступная версия: " .. swift_key[1]))
  update:addChild (GUI.label (26, 9, panel.width, 1, text, "Состояние: " .. swift_key[2]))
  update:addChild (GUI.roundedButton (25, 10, 27, 3, button_def, button_text, button_active, button_text, 'Обновить')).onTouch = function()
  end

else
  update:addChild (GUI.label (26, 8, panel.width, 1, text, "Доступных обновлений SwiftOS нет"))
  end




update.eventHandler = function(main, win, evname, _, x, y)
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


mainContainer:addChild (update)
mainContainer:draw()
