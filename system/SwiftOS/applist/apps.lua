local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')


local mainContainer = ...

list = GUI.container(1, 1, 160, 50)

local panel = GUI.panel (1, 1, list.width, list.height, dock_apps, 0.3)

list:addChild (panel)
list.touchX, list.touchY = 0, 0

 list:addChild(GUI.framedButton(-1, -1, 163, 53, button_text, button_text, button_text, button_text, "")).onTouch = function()
list:remove()
mainContainer:draw()
end

local yu = 4
local xy = 6
local counts = 0
local file = ''
for file in fs.list('/system/apps/') do

local c = 0
  local slash = 0
  local object = ''

  if counts == 10 then
  yu = yu + 8
  xy = 6
  counts = 0
  end

  local c = string.len(file)
  local slash = c - 1
  local object = file:sub(1, slash)
  list:addChild (GUI.image (xy, yu, buffer.loadImage("/system/apps/" .. object .. "/" .. object .. ".pic")))
  counts = counts + 1
  list:addChild(GUI.framedButton(xy-1, yu-1, 10, 6, main_text, button_text, colorDesktop, colorDesktop, "")).onTouch = function ()
   local result, reason = loadfile('/system/apps/' .. object .. '/' .. object .. '.lua')
   list:remove()
mainContainer:draw()
       if result then
      result, reason = pcall(result, mainContainer)
        mainContainer:draw(true)
      if not result then
       if type(reason) == "table" and reason.reason == "terminated" then return end
       error("Failed to perform pcall() : " .. reason)
      end
  else
   error("Failed to perform loadfile() : " .. reason)
   end
  end

  xy = xy + 15

end



mainContainer:addChild (list)
mainContainer:draw()
