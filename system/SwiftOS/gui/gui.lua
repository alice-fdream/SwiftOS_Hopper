local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')
local event = require('event')
local unicode = require('unicode')
local modem = require('component').modem
local component = require('component')

------------------------------------------------------------------------------------------
buffer.setGPUProxy(require("component").gpu)

if component.isAvailable('modem') then
local id_ip = io.open('/system/SwiftOS/configs/ip')
local ip = id_ip:read()
id_ip:close()
os.setenv('IP', ip)
modem.open(1184)

daemon_net = event.listen('modem_message', function( _, _, from, port, _, message)
  data = {mainContainer, from, port, message, daemon_net}

    local result, reason = loadfile('/system/systemDATA/daemon')
      if result then
        result, reason = pcall(result, data)
        if not result then
         error("Failed to perform pcall() : " .. reason)
     end
    else
     error("Failed to perform loadfile() : " .. reason)
     end
end)

end
local window1Container, window1Panel

 mainContainer = GUI.application()
mainContainer:addChild(GUI.panel(1, 1, mainContainer.width, mainContainer.height, colorDesktop))


local menu = mainContainer:addChild(GUI.menu(1, 1, mainContainer.width, backgr, text, 0x076918, 0xFFFFFF, nil))

local counn = unicode.len(os.getenv('PLA'))
local yyu = 160 - counn
 mainContainer:addChild (GUI.label (yyu, 1, mainContainer.width, 1, text, os.getenv('PLA')))

local osx = menu:addContextMenu(os.getenv('NAME'), main_text)
osx:addItem('О Системе').onTouch =  function ()
local infosystem = GUI.container    (mainContainer.width/2-30, mainContainer.height/2-8, 60, 15)

infosystem.touchX, infosystem.touchY = 0, 0

infosystem.eventHandler = function(main, win, evname, _, x, y)
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

local x0pan = infosystem:addChild (GUI.panel (1, 1, infosystem.width-1, infosystem.height-1, backgr))
infosystem:addChild(GUI.panel(2, infosystem.height, x0pan.width, 1, shadow_window))
infosystem:addChild(GUI.panel(infosystem.width, 2, 1, x0pan.height-1, shadow_window))

infosystem:addChild (GUI.label (2, 2, x0pan.width, x0pan.height, text, "О Системе"))
infosystem:addChild (GUI.image (4, 4, buffer.loadImage("/system/systemDATA/images/logo.pic")))
infosystem:addChild (GUI.label (28, 5, x0pan.width, x0pan.height, text, os.getenv('NAME')))
infosystem:addChild (GUI.label (28, 6, x0pan.width, x0pan.height, text, 'Версия: ' .. os.getenv('VER')))
infosystem:addChild (GUI.label (28, 7, x0pan.width, x0pan.height, text, 'Процессор: Swift C-7100K'))
 infosystem:addChild (GUI.label (28, 8, x0pan.width, x0pan.height, text, 'RAM: ' .. (computer.totalMemory() / 1024) / 1024 .. ' МБ'))
 infosystem:addChild (GUI.label (28, 9, x0pan.width, x0pan.height, text, 'Пользователь: ' .. os.getenv("PLA")))
  infosystem:addChild (GUI.label (28, 10, x0pan.width, x0pan.height, text, 'Адрес: ' .. os.getenv('IP') ))
 infosystem:addChild (GUI.roundedButton (infosystem.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
		infosystem:remove()
		mainContainer:draw()
	end

	mainContainer:addChild (infosystem)
	mainContainer:draw()
end
osx:addSeparator()
osx:addItem ("Обновление SwiftOS").onTouch = function()
  local result, reason = loadfile('/system/SwiftOS/update/main.lua')
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

osx:addSeparator()
osx:addItem ("Выйти").onTouch     = function () mainContainer:stop()
  event.ignore(daemon_net)
  local result, reason = loadfile('/system/systemDATA/auth/auth.lua')
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
osx:addItem ("Выключить").onTouch     = function () computer.shutdown ()     end
osx:addItem ("Перезагрузить").onTouch = function ()
computer.shutdown (true)
 end




mainContainer:addChild (GUI.roundedButton (mainContainer.width/2-27, 45, 54, 5, backgr, button_text, backgr, button_text, ' '))



 mainContainer:addChild (GUI.image (56, 46, buffer.loadImage("/system/apps/via/icon.pic"))).eventHandler = function (main, win, evn, _, x, y)
if evn == 'touch' then
  local result, reason = loadfile('/system/apps/via/via.lua')
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
end



 mainContainer:addChild (GUI.image (66, 46, buffer.loadImage("/system/systemDATA/images/setting.pic"))).eventHandler = function (main, win, evn, _, x, y)
 if evn == 'touch' then
   local result, reason = loadfile('/system/SwiftOS/settings/main.lua')
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


   mainContainer:addChild (GUI.image (77, 46, buffer.loadImage("/system/systemDATA/images/contacts.pic"))).eventHandler = function (main, win, evn, _, x, y)
 if evn == 'touch' then
     local result, reason = loadfile('/system/apps/contacts/contacts.lua')
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



   mainContainer:addChild (GUI.image (88, 46, buffer.loadImage("/system/apps/shell/shell_dock.pic"))).eventHandler = function (main, win, evn, _, x, y)
 if evn == 'touch' then
   local result, reason = loadfile('/system/apps/shell/shell.lua')
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

     mainContainer:addChild (GUI.image (99, 46, buffer.loadImage("/system/systemDATA/images/all.pic"))).eventHandler = function (main, win, evn, _, x, y)
   if evn == 'touch' then
     local result, reason = loadfile('/system/SwiftOS/applist/apps.lua')
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


mainContainer:draw  (true)
mainContainer:start ()
