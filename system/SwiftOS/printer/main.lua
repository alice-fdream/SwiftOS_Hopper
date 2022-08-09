local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')


local mainContainer = ...

printer = GUI.container(mainContainer.width/2-25, mainContainer.height/2-8, 50, 15)

local panel = GUI.panel (1, 1, printer.width-1, printer.height-1, backgr)
printer:addChild (panel)
printer:addChild (GUI.label (2, 2, panel.width, 1, text, "Менеджер печати " .. os.getenv('NAME') .. ' ' .. os.getenv('VER')))
printer:addChild(GUI.panel(2, printer.height, panel.width, 1, shadow_window))
printer:addChild(GUI.panel(printer.width, 2, 1, panel.height-1, shadow_window))
printer.touchX, printer.touchY = 0, 0

printer:addChild(GUI.roundedButton (printer.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    printer:remove()
    mainContainer:draw()
end


local dialog = printer:addChild (GUI.filesystemChooser (6, 6, 30, 3,  input_back,  input_text,  button_def, button_text, "Документ", "Печать", "Отмена", "...",  "/"))
	dialog:setMode (GUI.IO_MODE_OPEN, GUI.IO_MODE_FILE)


dialog.onSubmit = function (path)
	os.execute('printer ' .. path)
        printer:remove()
        mainContainer:draw(true)
	end
	mainContainer:draw()


printer.eventHandler = function(main, win, evname, _, x, y)
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


mainContainer:addChild (printer)
mainContainer:draw()
