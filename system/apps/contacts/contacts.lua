local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local event = require('event')
local unicode = require('unicode')
local fs = require('filesystem')


local mainContainer = ...

contacts = GUI.container(mainContainer.width/2-15, mainContainer.height/2-13, 35, 25)

local panel = GUI.panel (1, 1, contacts.width-1, contacts.height-1, backgr)
contacts:addChild (panel)
contacts:addChild (GUI.label (2, 2, panel.width, 1, text, "Контакты " .. os.getenv('VER')))
contacts:addChild(GUI.panel(2, contacts.height, panel.width, 1, shadow_window))
contacts:addChild(GUI.panel(contacts.width, 2, 1, panel.height-1, shadow_window))
contacts.touchX, contacts.touchY = 0, 0

contacts:addChild(GUI.roundedButton (contacts.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    contacts:remove()
    mainContainer:draw()
end

contacts:addChild(GUI.roundedButton (2, 4, 32, 3, button_def, button_text, button_active, button_text, 'Добавить контакт')).onTouch = function ()
  local data = {mainContainer}
  local result, reason = loadfile('/system/apps/contacts/add.lua')
    if result then
      result, reason = pcall(result, data)
        mainContainer:draw(true)
      if not result then
       error("Failed to perform pcall() : " .. reason)
   end
  else
   error("Failed to perform loadfile() : " .. reason)
   end
end

local layout1 = GUI.container(2, 7, 32, 17)
contacts:addChild(layout1)

local layout2 = GUI.container(1,1, layout1.width, 100)
layout2:addChild(GUI.panel (1, 1, layout1.width, 100, input_back_foc))
layout1:addChild(layout2)

function iContacts()
layout1:remove()

local layout1 = GUI.container(2, 7, 32, 17)
contacts:addChild(layout1)

local layout2 = GUI.container(1,1, layout1.width, 100)
layout2:addChild(GUI.panel (1, 1, layout1.width, 100, input_back))
layout1:addChild(layout2)


val = 1

layout2.eventHandler = function(mainContainer, layout2, ename, idds, x, y, chsc)

if ename == "scroll" then
	if chsc >= 1 then
	if val == 1 then
	else
	val = val - 2
	layout2.localY = layout2.localY + 1
	mainContainer:draw()
	end
	else
	val = val + 2
	layout2.localY = layout2.localY - 1
	mainContainer:draw()
	end

end
end

local xyi = 2
  for file in fs.list('/Users/' .. os.getenv('PLA') .. '/Contacts/') do



    local id = io.open('/Users/' .. os.getenv('PLA') .. '/Contacts/' .. file .. '/id')
    local idd = id:read()
    id:close()

    layout2:addChild (GUI.image (4, xyi, buffer.loadImage("/system/systemDATA/images/contacts.pic"))).eventHandler = function (main, win, evn, _, x, y)
if evn == 'touch' then
      local data = {mainContainer, file, idd}
      local result, reason = loadfile('/system/apps/contacts/viewer.lua')
        if result then
          result, reason = pcall(result, data)
            mainContainer:draw(true)
          if not result then
           error("Failed to perform pcall() : " .. reason)
       end
      else
       error("Failed to perform loadfile() : " .. reason)
       end
end
    end

    layout2:addChild (GUI.label (12, xyi, panel.width, 1, input_text, unicode.sub(file, 1, -2)))
    layout2:addChild (GUI.label (12, xyi+1, panel.width, 1, input_text, unicode.sub(idd, 1, 18)))

xyi = xyi + 5


end

contacts.eventHandler = function(main, win, evname, _, x, y)
  if evname == "touch" then
    win.touchX, win.touchY = x, y
	 win:moveToFront()
    main:draw()
  elseif evname == "drag" then
    win.localX = ((x > win.touchX) and win.localX + 1) or ((x < win.touchX) and win.localX - 1) or win.localX
    win.localY = ((y > win.touchY) and win.localY + 1) or ((y < win.touchY) and win.localY - 1) or win.localY
    win.touchX, win.touchY = x, y
    Globalx, Globaly = x, y
    main:draw()
  end
end

mainContainer:draw()
end

iContacts()

mainContainer:addChild (contacts)
mainContainer:draw()
