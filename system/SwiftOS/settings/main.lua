local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')


local mainContainer = ...

settings = GUI.container(mainContainer.width/2-23, mainContainer.height/2-7, 45, 13)

local panel = GUI.panel (1, 1, settings.width-1, settings.height-1, backgr)
settings:addChild (panel)
settings:addChild (GUI.label (2, 2, panel.width, 1, text, "Настройки " .. os.getenv('NAME') .. ' ' .. os.getenv('VER')))
settings:addChild(GUI.panel(2, settings.height, panel.width, 1, shadow_window))
settings:addChild(GUI.panel(settings.width, 2, 1, panel.height-1, shadow_window))
settings.touchX, settings.touchY = 0, 0

settings:addChild(GUI.roundedButton (settings.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    settings:remove()
    mainContainer:draw()
end

settings:addChild (GUI.image (4, 4, buffer.loadImage("/system/systemDATA/images/control_theme.pic"))).eventHandler = function (main, win, evn, _, x, y)
if evn == 'touch' then
  local result, reason = loadfile('/system/SwiftOS/settings/theme.lua')
    if result then
      result, reason = pcall(result, mainContainer)
        mainContainer:draw(true)
      if not result then
       error("Failed to perform pcall() : " .. reason)
   end
  else
   error("Failed to perform loadfile() : " .. reason)
   end
end
  end
settings:addChild(GUI.label (10, 5, panel.width, 1, text, "Темы"))


settings:addChild (GUI.image (21, 6, buffer.loadImage("/system/systemDATA/images/disks.pic"))).eventHandler = function (main, win, evn, _, x, y)
if evn == 'touch' then
  local result, reason = loadfile('/system/SwiftOS/settings/format_disk.lua')
    if result then
      result, reason = pcall(result, mainContainer)
        mainContainer:draw(true)
      if not result then
       error("Failed to perform pcall() : " .. reason)
   end
  else
   error("Failed to perform loadfile() : " .. reason)
   end
end
  end
settings:addChild(GUI.label (27, 7, panel.width, 1, text, "Диски"))







settings.eventHandler = function(main, win, evname, _, x, y)
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


mainContainer:addChild (settings)
mainContainer:draw()
