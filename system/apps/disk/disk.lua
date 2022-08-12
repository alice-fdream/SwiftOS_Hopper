local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')
local unicode = require('unicode')

local mainContainer = ...

disk = GUI.container(1, 1, 160, 50)

local panel = GUI.panel (1, 1, disk.width, disk.height, backgr)
disk:addChild (panel)
disk:addChild (GUI.label (6, 2, panel.width, 1, text, "Дисковая утилита " .. os.getenv('NAME') .. ' ' .. os.getenv('VER')))
disk.touchX, disk.touchY = 0, 0

disk:addChild(GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    disk:remove()
    mainContainer:draw()
end


right = GUI.container(27, 4, 133, 46)

local panel_right = GUI.panel (1, 1, right.width, right.height, input_back)
right:addChild (panel_right)

local verticalList = disk:addChild(GUI.list(2, 4, 24, 46, 3, 0, input_back, input_text, button_def, button_text, input_text, input_back, false))

local disks = ''
for disks in fs.list('/DISK/') do

local c = 0
  local object = ''
  local c = string.len(disks)
  local object = disks:sub(1, -2)
	verticalList:addItem('Носитель ' .. object).onTouch = function()
	right:remove()
iDISK(object)
end
end










mainContainer:addChild (disk)
disk:addChild (right)

mainContainer:draw()

window_rename = 0

function iDISK(object)

if window_rename == 1 then
rename:remove()
mainContainer:draw()
window_rename = 0
end

	right = GUI.container(27, 4, 133, 46)
	local panel_right = GUI.panel (1, 1, right.width, right.height, input_back)
	right:addChild (panel_right)
	local proxywwws = fs.get('/DISK/' .. object .. '/')
	
	local lname = proxywwws.getLabel()
	if lname == nil then
	right:addChild (GUI.label (6, 2, panel.width, 1, input_text, 'Название носителя: Отсутствует'))
	else
	right:addChild (GUI.label (6, 2, panel.width, 1, input_text, 'Название носителя: ' .. proxywwws.getLabel()))
	end
	
	right:addChild (GUI.label (6, 3, panel.width, 1, input_text, 'Адрес носителя: ' .. proxywwws.address))
	right:addChild (GUI.label (6, 4, panel.width, 1, input_text, 'Объем носителя: ' .. proxywwws.spaceTotal() / 1024 .. ' КБ' ))
	right:addChild (GUI.label (6, 5, panel.width, 1, input_text, 'Занято: ' .. math.floor(proxywwws.spaceUsed() / 1024) .. ' КБ' ))
	local avalible = proxywwws.spaceTotal() - proxywwws.spaceUsed()
	local avab = (proxywwws.spaceUsed() / proxywwws.spaceTotal()) * 100
	local qq1 = math.floor(avab)
	local qq2 = 100 - qq1
	right:addChild(GUI.progressBar(24, 7, 80, input_text, backgr, input_text, qq2, true, true, "Доступно: ", " % (" .. math.floor(avalible / 1024) .. ' КБ)'))
	disk:addChild(right)
	
	right:addChild(GUI.roundedButton (49, 10, 17, 3, button_def, button_text, button_active, button_text, 'Переименовать')).onTouch = function ()
rename = GUI.container(mainContainer.width/2-25, mainContainer.height/2-7, 50, 13)
local q11 = GUI.panel (1, 1, rename.width-1, rename.height-1, backgr)
rename:addChild (q11)
rename:addChild (GUI.label (6, 2, q11.width, 1, text, "Переименовать диск"))
rename:addChild(GUI.panel(2, rename.height, q11.width, 1, shadow_window))
rename:addChild(GUI.panel(rename.width, 2, 1, q11.height-1, shadow_window))
rename.touchX, rename.touchY = 0, 0
rename:addChild(GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    rename:remove()
    mainContainer:draw()    
end

local disk_name = GUI.input(10, 5, 30, 3, input_back, text, text, input_back_foc, text, "", "Новое имя диска")
rename:addChild(disk_name)

rename:addChild(GUI.roundedButton (10, 8, 30, 3, button_def, button_text, button_active, button_text, 'Переименовать')).onTouch = function()
proxywwws.setLabel(disk_name.text)
window_rename = 1
iDISK(object)
end

rename.eventHandler = function(text_calc, win, evname, _, x, y)
  if evname == "touch" then
    win.touchX, win.touchY = x, y
	 win:moveToFront()
    text_calc:draw()
  elseif evname == "drag" then
    win.localX = ((x > win.touchX) and win.localX + 1) or ((x < win.touchX) and win.localX - 1) or win.localX
    win.localY = ((y > win.touchY) and win.localY + 1) or ((y < win.touchY) and win.localY - 1) or win.localY
    win.touchX, win.touchY = x, y
    text_calc:draw()
  end
  
end

disk:addChild (rename)
mainContainer:draw()
end


	right:addChild(GUI.roundedButton (68, 10, 11, 3, button_def, button_text, button_active, button_text, 'Стереть')).onTouch = function ()
	if fs.exists('/DISK/' .. object .. '/system/') == false then
		
		for dele in fs.list("/DISK/" .. object .. '/') do
    		fs.remove("/DISK/" .. object .. '/' .. dele)
		end
		
		iDISK(object)
	end
end

	right:addChild(GUI.roundedButton (49, 13, 30, 3, button_def, button_text, button_active, button_text, 'Записать zip')).onTouch = function ()
end
	
	
	mainContainer:draw()

end
