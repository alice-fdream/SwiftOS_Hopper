local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local themes = require("get_them")
local gpu = require('component').gpu
local fs = require('filesystem')
------------------------------------------------------------------------------------------
buffer.setGPUProxy(require("component").gpu)


css_ref()
local post_install, window1Panel

mainContainer = GUI.application()

mainContainer:addChild(GUI.panel(1, 1, mainContainer.width, mainContainer.height, colorDesktop))

local post_install = GUI.container(mainContainer.width/2-30, mainContainer.height/2-10, 60, 20)

local panel = GUI.panel (1, 1, post_install.width-1, post_install.height-1, backgr)

post_install:addChild (panel)
post_install:addChild(GUI.panel(2, post_install.height, panel.width, 1, shadow_window))
post_install:addChild(GUI.panel(post_install.width, 2, 1, panel.height-1, shadow_window))

post_install.touchX, post_install.touchY = 0, 0

post_install:addChild (GUI.image (21, 2, buffer.loadImage("/system/systemDATA/images/logo.pic")))
post_install:addChild (GUI.label (24, 13, panel.width, 3, text, "SwiftOS Hopper"))

local ends = GUI.roundedButton(4, 15, 53, 3, button_def, button_text, button_active, button_text, 'Завершить установку')

post_install:addChild(ends).onTouch = function()
	post_install:remove()
	
	local post_install2 = GUI.container(mainContainer.width/2-30, mainContainer.height/2-10, 60, 20)
	
	local panel = GUI.panel (1, 1, post_install2.width-1, post_install2.height-1, backgr)
	
	post_install2:addChild(GUI.panel(2, post_install2.height, panel.width, 1, shadow_window))
	post_install2:addChild(GUI.panel(post_install2.width, 2, 1, panel.height-1, shadow_window))
	post_install2:addChild (panel)
	
	local identity = GUI.roundedButton(4, 10, 53, 3, button_def, button_text, button_active, button_text, 'Нажмите для идентификации')
	post_install2:addChild(identity).eventHandler = function (main, win, evn, _, x, y, _, pll)
		if evn == 'touch' then
		fs.makeDirectory('/Users/')
		fs.makeDirectory('/Users/' .. pll .. '/')
		fs.makeDirectory('/Users/' .. pll .. '/Contacts/')
		fs.makeDirectory('/Users/' .. pll .. '/Documents/')
		fs.makeDirectory('/Users/' .. pll .. '/lipSync/')
		fs.makeDirectory('/Users/' .. pll .. '/Projects/')
		
		local ch = io.open('/system/SwiftOS/configs/SAEE4.0', 'w')
		local ch1 = ch:write('1')
		ch:close()
		
		computer.shutdown(true)
		
		end
	end
	
	mainContainer:addChild(post_install2)
	mainContainer:draw()
end

mainContainer:addChild (post_install)
mainContainer:draw  (true)
mainContainer:start ()
