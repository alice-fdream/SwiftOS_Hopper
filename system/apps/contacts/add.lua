local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local event = require('event')
local unicode = require('unicode')
local fs = require('filesystem')


local data = ...

local mainContainer = data[1]

add = GUI.container(mainContainer.width/2-15, mainContainer.height/2-13, 35, 25)

local panel = GUI.panel (1, 1, add.width-1, add.height-1, backgr)
add:addChild (panel)
add:addChild (GUI.label (2, 2, panel.width, 1, text, "Добавить аккаунт"))
add:addChild(GUI.panel(2, add.height, panel.width, 1, shadow_window))
add:addChild(GUI.panel(add.width, 2, 1, panel.height-1, shadow_window))
add.touchX, add.touchY = 0, 0

add:addChild(GUI.roundedButton (add.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    add:remove()
    mainContainer:draw()
end

  add:addChild (GUI.image (15, 5, buffer.loadImage("/system/systemDATA/images/contacts.pic")))

  name = GUI.input (2, 9, 32, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Имя")
  add:addChild (name)


  id_dev = GUI.input (2, 13, 32, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Id устройства")
  add:addChild (id_dev)

  add:addChild(GUI.roundedButton (2, 17, 32, 3, button_def, button_text, button_active, button_text, 'Сохранить')).onTouch = function ()

    if fs.exists('/Users/' .. os.getenv('PLA') .. '/Contacts/' .. name.text .. '/') then
      add:addChild (GUI.label (2, 20, panel.width, 1, text, "Контакт уже существует"))

    else

      fs.makeDirectory('/Users/' .. os.getenv('PLA') .. '/Contacts/' .. name.text .. '/')

      local hdd_id = io.open('/Users/' .. os.getenv('PLA') .. '/Contacts/' .. name.text .. '/id', 'a')
      hdd_id:write(id_dev.text)
      hdd_id:close()
      add:remove()
      iContacts()
    end

  end

add.eventHandler = function(main, win, evname, _, x, y)
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


mainContainer:addChild (add)
mainContainer:draw()
