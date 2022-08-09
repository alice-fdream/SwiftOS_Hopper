local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local red = require('component').redstone
local event = require('event')


local mainContainer = ...

window1Container = GUI.container(mainContainer.width/2-26, mainContainer.height/2-9, 65, 29)

local panel = GUI.panel (1, 1, window1Container.width-1, window1Container.height-1, backgr)
window1Container:addChild (panel)
window1Container:addChild (GUI.label (2, 2, panel.width, 1, text, "Redstone контроллер SwiftOS " .. os.getenv('VER')))
window1Container:addChild(GUI.panel(2, window1Container.height, panel.width, 1, shadow_window))
window1Container:addChild(GUI.panel(window1Container.width, 2, 1, panel.height-1, shadow_window))
window1Container.touchX, window1Container.touchY = 0, 0

window1Container:addChild(GUI.roundedButton (window1Container.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    window1Container:remove()
    event.cancel(redst)
    mainContainer:draw()
end

side1 = GUI.roundedButton (2, 4, 6, 3, button_def, button_text, button_active, button_text, '1 ON')
window1Container:addChild(side1).onTouch = function()
red.setOutput(1, 15)
end

side2 = GUI.roundedButton (2, 8, 6, 3, button_def, button_text, button_active, button_text, '2 ON')
window1Container:addChild(side2).onTouch = function()
red.setOutput(2, 15)
end

side3 = GUI.roundedButton (2, 12, 6, 3, button_def, button_text, button_active, button_text, '3 ON')
window1Container:addChild(side3).onTouch = function()
red.setOutput(3, 15)
end

side4 = GUI.roundedButton (2, 16, 6, 3, button_def, button_text, button_active, button_text, '4 ON')
window1Container:addChild(side4).onTouch = function()
red.setOutput(4, 15)
end

side5 = GUI.roundedButton (2, 20, 6, 3, button_def, button_text, button_active, button_text, '5 ON')
window1Container:addChild(side5).onTouch = function()
red.setOutput(5, 15)
end

side0 = GUI.roundedButton (2, 24, 6, 3, button_def, button_text, button_active, button_text, '0 ON')
window1Container:addChild(side0).onTouch = function()
red.setOutput(0, 15)
end




xide1 = GUI.roundedButton (13, 4, 7, 3, button_def, button_text, button_active, button_text, '1 OFF')
window1Container:addChild(xide1).onTouch = function()
red.setOutput(1, 0)
end

xide2 = GUI.roundedButton (13, 8, 7, 3, button_def, button_text, button_active, button_text, '2 OFF')
window1Container:addChild(xide2).onTouch = function()
red.setOutput(2, 0)
end

xide3 = GUI.roundedButton (13, 12, 7, 3, button_def, button_text, button_active, button_text, '3 OFF')
window1Container:addChild(xide3).onTouch = function()
red.setOutput(3, 0)
end

xide4 = GUI.roundedButton (13, 16, 7, 3, button_def, button_text, button_active, button_text, '4 OFF')
window1Container:addChild(xide4).onTouch = function()
red.setOutput(4, 0)
end

xide5 = GUI.roundedButton (13, 20, 7, 3, button_def, button_text, button_active, button_text, '5 OFF')
window1Container:addChild(xide5).onTouch = function()
red.setOutput(5, 0)
end

xide0 = GUI.roundedButton (13, 24, 7, 3, button_def, button_text, button_active, button_text, '0 OFF')
window1Container:addChild(xide0).onTouch = function()
red.setOutput(0, 0)
end






window1Container.eventHandler = function(main, win, evname, _, x, y)
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


mainContainer:addChild (window1Container)
mainContainer:draw()
function get_o(wwq1, wwq2, wwq3, wwq4, wwq5)

 end
redst = event.listen("redstone_changed", function(qq1, qq2, qq3, qq4, qq5)

  if u == 1 then
tex1:remove()
tex2:remove()
tex3:remove()
  end


tex1 = GUI.label (30, 4, panel.width, 1, text, "Компьютер обнаружил сигнал!")
tex2 = GUI.label (30, 5, panel.width, 1, text, "Сторона контроллера: " .. qq3)
tex3 = GUI.label (30, 6, panel.width, 1, text, "Сила сигнала: " .. qq5)
  window1Container:addChild(tex1)
  window1Container:addChild(tex2)
  window1Container:addChild(tex3)
  u = 1
  mainContainer:draw()
end
)
