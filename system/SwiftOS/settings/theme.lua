local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')


local mainContainer = ...

themes = GUI.container(1, 1, 160, 50)

local panel = GUI.panel (1, 1, themes.width, themes.height, backgr)
themes:addChild (panel)
themes:addChild (GUI.label (6, 2, panel.width, 1, text, "Менеджер тем " .. os.getenv('NAME') .. ' ' .. os.getenv('VER')))
themes.touchX, themes.touchY = 0, 0

themes:addChild(GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    themes:remove()
    mainContainer:draw()
end


local yu = 6
local xy = 4
local file = ''
for file in fs.list('/system/SwiftOS/themes/list/') do
  if xy == 4 and yu == 51 then
  xy = 31
  yu = 6
  end

  if xy == 31 and yu == 51 then
  xy = 62
  yu = 6
  end

  if xy == 62 and yu == 51 then
  xy = 93
  yu = 6
  end

  if xy == 93 and yu == 51 then
  xy = 122
  yu = 6
  end

local c = 0
  local slash = 0
  local object = ''
  local c = string.len(file)
  local slash = c - 1
  local object = file:sub(1, slash)
  themes:addChild(GUI.label (xy, yu, panel.width, 1, text, object))
  themes:addChild(GUI.roundedButton (xy + 13, yu-1, 3, 3, button_def, button_text, button_active, button_text, '√')).onTouch = function()
    fils = io.open('/system/SwiftOS/themes/current_theme.dll', 'w')
    fils:write(object)
    fils:close()

    themes:remove()
    css_ref()
    computer.shutdown(true)
  end


  themes:addChild(GUI.roundedButton (xy + 17, yu-1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function()
    os.execute('rm -r /system/SwiftOS/themes/list/' .. object .. '/')
    computer.shutdown(true)
  end
yu = yu + 3
end





mainContainer:addChild (themes)
mainContainer:draw()
