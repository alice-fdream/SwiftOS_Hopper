local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local themes = require("get_them")
local fs = require('filesystem')
local event = require('event')
require('swift_term')

mainContainer = ...

shell = GUI.container(4, 4, 80, 25)

local panel = GUI.panel (1, 1, shell.width-1, shell.height-1, backgr)
shell:addChild (panel)
shell:addChild (GUI.label (2, 2, panel.width, 1, text, "Консоль " .. os.getenv('VER')))
shell:addChild(GUI.panel(2, shell.height, panel.width, 1, shadow_window))
shell:addChild(GUI.panel(shell.width, 2, 1, panel.height-1, shadow_window))
shell.touchX, shell.touchY = 0, 0

shell:addChild(GUI.roundedButton (shell.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    shell:remove()
    mainContainer:draw()
end

out1 = GUI.container(2, 4, 77, 16)
local backs = GUI.panel(1, 1, out1.width, 100, input_back)
out2 = GUI.container(1,1, out1.width, 100)
out2:addChild(backs)
out1:addChild(out2)
shell:addChild(out1)



xy = 2
pr('SwiftOS Terminal 1.0. GPL-3.0 License')
xy = xy + 1
com = GUI.input(2, 21, 77, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Enter the command")
	shell:addChild(com).onInputFinished = function ()

	args={}
	for str in string.gmatch(com.text, "([^%s]+)") do
    	table.insert(args, str)
	end




  if args[1] == 'clear' then
    out2:remove()
  local backs = GUI.panel(1, 1, out1.width, 100, input_back)
  out2 = GUI.container(1,1, out1.width, 100)
  out2:addChild(backs)
  out1:addChild(out2)
  mainContainer:draw()
  xy = 1

else
if com.text == nil or com.text == '' then
else
if fs.exists('/system/systemDATA/binares/'.. args[1]) == false then
  pr(args[1] .. ' binare file not found#')
else
  pr( "> " .. com.text)

    local result, reason = loadfile('/system/systemDATA/binares/'.. args[1])
    mainContainer:draw()
        if result then
       result, reason = pcall(result)
         mainContainer:draw()
       if not result then
        if type(reason) == "table" and reason.reason == "terminated" then return end
        error("Failed to perform pcall() : " .. reason)
       end
    else
    error("Failed to perform loadfile() : " .. reason)
    end
end

end
	 end

	xy = xy + 1
	com.text = ''

end





val = 1
out2.eventHandler = function(mainContainer, out2, ename, idds, x, y, chsc)

if ename == "scroll" then
	if chsc >= 1 then
	if val == 1 then
	else
	val = val + 1
	out2.localY = out2.localY + 1
	mainContainer:draw()
	end
	else
	val = val - 1
	out2.localY = out2.localY - 1
	mainContainer:draw()
	end

end
end



shell.eventHandler = function(main, win, evname, _, x, y)
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


mainContainer:addChild (shell)
mainContainer:draw()
