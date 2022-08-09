local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local event = require('event')
local unicode = require('unicode')
local fs = require('filesystem')
--------------------
require('swift_network')

local data = ...

local mainContainer = data[1]

view = GUI.container(mainContainer.width/2-15, mainContainer.height/2-13, 35, 25)

local panel = GUI.panel (1, 1, view.width-1, view.height-1, backgr)
view:addChild (panel)
view:addChild (GUI.label (2, 2, panel.width, 1, text, "Просмотр контакта " .. unicode.sub(data[2], 1, -2)))
view:addChild(GUI.panel(2, view.height, panel.width, 1, shadow_window))
view:addChild(GUI.panel(view.width, 2, 1, panel.height-1, shadow_window))
view.touchX, view.touchY = 0, 0

view:addChild(GUI.roundedButton (view.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    view:remove()
    mainContainer:draw()
end


local layout1 = GUI.container(2, 4, 32, 20)
view:addChild(layout1)
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


  layout2:addChild (GUI.image (layout2.width/2-3, 2, buffer.loadImage("/system/systemDATA/images/contacts.pic")))
  layout2:addChild (GUI.label (layout2.width/2-math.floor(unicode.len(data[2])/2), 5, panel.width, 1, input_text, unicode.sub(data[2], 1, -2)))
 

 layout2:addChild (GUI.label (layout2.width/2-math.floor(unicode.len(unicode.sub(data[3], 1, 18)) / 2), 6, panel.width, 1, input_text, unicode.sub(data[3], 1, 18)))
		

  layout2:addChild(GUI.roundedButton (2, 7, 30, 3, button_def, button_text, button_active, button_text, 'Сообщение')).onTouch = function()
			local send_message = GUI.container(mainContainer.width/2-20, mainContainer.height/2-5, 40, 10)
		local panel = GUI.panel (1, 1, send_message.width-1, send_message.height-1, backgr)
			send_message:addChild (panel)
			send_message:addChild (GUI.label (2, 2, panel.width, 1, text, "Написать сообщение"))
			send_message:addChild(GUI.panel(2, send_message.height, panel.width, 1, shadow_window))
			send_message:addChild(GUI.panel(send_message.width, 2, 1, panel.height-1, shadow_window))
			send_message.touchX, send_message.touchY = 0, 0
			send_message:addChild(GUI.roundedButton (send_message.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
				send_message:remove()
				mainContainer:draw()
			end
			local msg = GUI.input(2, 4, 37, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "")
			send_message:addChild(msg)
			
			send_message:addChild(GUI.roundedButton (16, 7, 11, 3, close_button, button_text, button_active, button_text, 'Отправить')).onTouch = function ()
			send_message:remove()
				local swift = {os.getenv('PLA'), msg.text}
				send_request(data[3], 'sms', swift)
				mainContainer:draw()
				end
			
			
		send_message.eventHandler = function(main, win, evname, _, x, y)
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


	mainContainer:addChild (send_message)
	mainContainer:draw()
end
  layout2:addChild(GUI.roundedButton (2, 10, 30, 3, close_button, button_text, button_active, button_text, 'Удалить')).onTouch = function ()
    os.execute('rm -r /Users/' .. os.getenv('PLA') .. '/Contacts/' .. data[2])
    view:remove()
    iContacts()
end


view.eventHandler = function(main, win, evname, _, x, y)
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


mainContainer:addChild (view)
mainContainer:draw()
