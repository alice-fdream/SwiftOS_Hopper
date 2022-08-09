
local GUI = require("GUI")
local buffer = require("NyaDraw")
local computer = require("computer")
local fs = require("filesystem")
local event = require("event")
local unicode = require("unicode")

local mainContainer = ...

idr = 1

via = GUI.container(mainContainer.width/2-50, mainContainer.height/2-15, 100, 30)

local panel = GUI.panel (1, 1, via.width-1, via.height-1, backgr)
via:addChild (panel)
via:addChild (GUI.label (2, 2, panel.width, 1, text, "Via " .. os.getenv('NAME') .. ' ' .. os.getenv('VER')))
via:addChild(GUI.panel(2, via.height, panel.width, 1, shadow_window))
via:addChild(GUI.panel(via.width, 2, 1, panel.height-1, shadow_window))
via.touchX, via.touchY = 0, 0

via:addChild(GUI.roundedButton (90, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    via:remove()
    mainContainer:draw()
end

via:addChild(GUI.roundedButton (94, 1, 5, 3, button_def, button_text, button_active, button_text, '<<')).onTouch = function ()
if os.getenv('VIA') == '/' then
else
idr = idr - 1
os.setenv('VIA', iDIR[idr])
iVIA()
end
end
os.setenv('VIA', '/')

iDIR = {}

via.eventHandler = function(text_calc, win, evname, _, x, y)
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


local left_menu = GUI.container(2,4, 22, 26)
local lfs = GUI.panel (1, 1, left_menu.width, left_menu.height, dock_apps)
left_menu:addChild(lfs)
via:addChild(left_menu)

left_menu:addChild(GUI.framedButton(2, 2, 20, 3, main_text, input_text, button_def, input_text, "Дом")).onTouch = function()
iDIR[idr] = os.getenv('VIA')
idr = idr + 1
os.setenv('VIA', '/Users/' .. os.getenv('PLA') .. '/')
iVIA()
end

left_menu:addChild(GUI.framedButton(2, 5, 20, 3, main_text, input_text, button_def, input_text, "Диски")).onTouch = function()
iDIR[idr] = os.getenv('VIA')
idr = idr + 1
os.setenv('VIA', '/DISK/')
iVIA()
end

left_menu:addChild(GUI.framedButton(2, 8, 20, 3, main_text, input_text, button_def, input_text, "Приложения")).onTouch = function()
iDIR[idr] = os.getenv('VIA')
idr = idr + 1
os.setenv('VIA', '/system/apps/')
iVIA()
end

left_menu:addChild(GUI.framedButton(2, 11, 20, 3, main_text, input_text, button_def, input_text, "Библиотеки")).onTouch = function()
iDIR[idr] = os.getenv('VIA')
idr = idr + 1
os.setenv('VIA', '/system/systemDATA/Library/')
iVIA()
end

left_menu:addChild(GUI.framedButton(2, 14, 20, 3, main_text, input_text, button_def, input_text, "Системный том")).onTouch = function()
iDIR[idr] = os.getenv('VIA')
idr = idr + 1
os.setenv('VIA', '/system/systemDATA/')
iVIA()
end

left_menu:addChild(GUI.framedButton(2, 17, 20, 3, main_text, input_text, button_def, input_text, "Общее")).onTouch = function()
iDIR[idr] = os.getenv('VIA')
idr = idr + 1
os.setenv('VIA', '/Users/' .. os.getenv('PLA') .. '/lipSync/')
iVIA()
end


left_menu:addChild(GUI.framedButton(2, 20, 20, 3, main_text, input_text, button_def, input_text, "Корень")).onTouch = function()
iDIR[idr] = os.getenv('VIA')
idr = (idr - idr) + 1
os.setenv('VIA', '/')
iVIA()
end


fils = GUI.container(1,1, 96, 100)
local filss = GUI.panel (1, 1, fils.width, fils.height, input_back_foc)
fils:addChild(filss)

cont = GUI.container(25, 4, 74, 26)
local contf = GUI.panel (1, 1, cont.width, cont.height, input_back_foc)
fils:addChild(contf)
via:addChild(cont)


cont:addChild(fils)
mainContainer:draw()

mainContainer:addChild (via)
mainContainer:draw()


scroll = via:addChild(GUI.scrollBar(99, 4, 1, 26, backgr, button_active, 1, 100, 1, 10, 1, false))

scroll.onTouch = function()
scroll.value = val
end

val = 1

cont.eventHandler = function(via, cont, ename, idds, x, y, chsc)

if ename == "scroll" then
	if chsc >= 1 then
	if scroll.value == 1 then
	else
	val = val - 2
	scroll.value = scroll.value - 2
	fils.localY = fils.localY + 2
	mainContainer:draw()
	end
	else
	val = val + 2
	scroll.value = scroll.value + 2
	fils.localY = fils.localY - 2
	mainContainer:draw()
	end

end
end




function iVIA()
scroll.value = 1
fils:remove()

fils = GUI.container(1,1, 96, 100)
local filss = GUI.panel (1, 1, fils.width, fils.height, dock_apps)--фон файл менеджера
fils:addChild(filss)
cont:addChild(fils)
mainContainer:draw()

filss.eventHandler = function(mainC, filss, enmm, iddpm, xm, ym, clicm)
if enmm == 'touch' then

	if clicm == 0 then

	else
			local inf = GUI.addContextMenu(via, xm-via.localX, ym-via.localY)

			inf:addItem("Новый файл").onTouch = function()
			wall = GUI.container(1,1, 160, 50)
		walls = GUI.panel (1, 1, 160, 50, dock_apps, 0.2)
		wall:addChild(walls)
		mainC:addChild(wall)
		local llm = GUI.label (72, 20, panel.width, 1, text, "Новый файл")
		wall:addChild(llm)
		file_name = GUI.input(64, 21, 30, 3, input_back, text, text, input_back_foc, text, "", "Новый файл")
		wall:addChild(file_name).onInputFinished = function()

		if file_name.text == '' or file_name.text == nil then
		llop = GUI.label (72, 24, panel.width, 1, text, "Введите имя")
			wall:addChild (llop)
			mainC:draw()
		else
			os.execute('touch ' .. os.getenv('VIA') .. file_name.text)
			wall:remove()
			iVIA()
		end

		-- end input func
		end

		mainC:draw()
					end


			inf:addItem("Новая папка").onTouch = function()

			wall = GUI.container(1,1, 160, 50)
		walls = GUI.panel (1, 1, 160, 50, dock_apps, 0.2)
		wall:addChild(walls)
		mainC:addChild(wall)
		local llm = GUI.label (72, 20, panel.width, 1, text, "Новая папка")
		wall:addChild(llm)
		file_name = GUI.input(64, 21, 30, 3, input_back, text, text, input_back_foc, text, "", "Новая папка")
		wall:addChild(file_name).onInputFinished = function()

		if file_name.text == '' or file_name.text == nil then
		llop = GUI.label (72, 24, panel.width, 1, text, "Введите имя")
			wall:addChild (llop)
			mainC:draw()
		else
			os.execute('mkdir ' .. os.getenv('VIA') .. file_name.text)
			wall:remove()
			iVIA()
		end

		-- end input func
		end

		mainC:draw()




		end

			inf:addSeparator()
			inf:addItem("Свойства")
			mainC:draw()
		end
	end
end






yu = 2
xy = 4
local counts = 0
local file = ''
for file in fs.list(os.getenv('VIA')) do

local c = 0
  local slash = 0
  local object = ''

  if counts == 5 then
  yu = yu + 8
  xy = 4
  counts = 0
  end

  local check = unicode.len(file)
  local object = unicode.sub(file, check, check+1)

	if object == '/' then

	local litlecheck = unicode.sub(file, 1, 4)

	if litlecheck == 'disk' then

	 fils:addChild (GUI.image (xy, yu, buffer.loadImage("/system/apps/via/disk.pic")))
  fils:addChild (GUI.label (xy+1, yu+3, panel.width, 1, 0x000000, file))

	elseif fs.exists(os.getenv('VIA') .. file .. unicode.sub(file, 1, -2) .. '.pic') then

	fils:addChild (GUI.image (xy, yu, buffer.loadImage(os.getenv('VIA') .. file .. unicode.sub(file, 1, -2) .. '.pic')))


	else

	 fils:addChild (GUI.image (xy, yu, buffer.loadImage("/system/apps/via/via.pic")))
  	fils:addChild (GUI.label (xy, yu+5, panel.width, 1, input_text, file))

	end

  counts = counts + 1
  folder = GUI.framedButton(xy-1, yu-1, 10, 6, main_text, button_text, colorDesktop, colorDesktop, "")
  fils:addChild(folder).onTouch = function(mainC, folder, enm, iddp, x, y, click)

  if enm == "touch" then
  if click == 0 then
  iDIR[idr] = os.getenv('VIA')
  idr = idr + 1
  os.setenv('VIA', os.getenv('VIA') .. file .. '/')
  iVIA()


    else


    		-- Add context menu object to workspace and some items to it
		local alt = GUI.addContextMenu(mainContainer, x, y)
		alt:addItem("Открыть").onTouch = function()
		iDIR[idr] = os.getenv('VIA')
  		idr = idr + 1
  		os.setenv('VIA', os.getenv('VIA') .. file .. '/')
		alt:remove()
		iVIA()
		end
		alt:addItem("Переименовать").onTouch = function ()
		alt:remove()
		wall = GUI.container(1,1, 160, 50)
		walls = GUI.panel (1, 1, 160, 50, dock_apps, 0.2)
		wall:addChild(walls)
		mainC:addChild(wall)
		llm = GUI.label (72, 20, panel.width, 1, text, "Переименовать")
		wall:addChild (llm)
		file_name = GUI.input(64, 21, 30, 3, input_back, text, text, input_back_foc, text, unicode.sub(file, 1, -2), "Новое имя папки")
		wall:addChild(file_name).onInputFinished = function()

		if file_name.text == '' or file_name.text == nil then
		llop = GUI.label (72, 24, panel.width, 1, text, "Введите имя")
			wall:addChild (llop)
			mainC:draw()
		elseif file_name.text == unicode.sub(file, 1, -2) then
			llop = GUI.label (72, 24, panel.width, 1, text, file_name.text .. ' = ' .. file_name.text)
			wall:addChild (llop)
			mainC:draw()
		else
			fs.rename(os.getenv('VIA') .. file, os.getenv('VIA') .. file_name.text )
			wall:remove()
			iVIA()
		-- end check
		end

		-- end input func
		end

		mainC:draw()
		end
		alt:addItem("Удалить").onTouch = function()
		fs.remove(os.getenv('VIA') .. file)
		iVIA()
		end
		alt:addItem("Копировать").onTouch = function()
				alt:remove()
		wall = GUI.container(1,1, 160, 50)
		walls = GUI.panel (1, 1, 160, 50, dock_apps, 0.2)
		wall:addChild(walls)
		mainC:addChild(wall)
		llm = GUI.label (72, 20, panel.width, 1, text, "Копировать")
		wall:addChild (llm)
		file_name = GUI.input(64, 21, 30, 3, input_back, text, text, input_back_foc, text, "", "Куда копировать")
		wall:addChild(file_name).onInputFinished = function()

		if file_name.text == '' or file_name.text == nil then
		llop = GUI.label (72, 24, panel.width, 1, text, "Введите путь")
			wall:addChild (llop)
			mainC:draw()
		elseif file_name.text == unicode.sub(file, 1, -2) then
			llop = GUI.label (72, 24, panel.width, 1, text, file_name.text .. ' = ' .. file_name.text)
			wall:addChild (llop)
			mainC:draw()
		else
			os.execute('cp -r ' .. os.getenv('VIA') .. file .. ' ' .. file_name.text)
			wall:remove()
			iVIA()
		-- end check
		end

		-- end input func
		end

		mainC:draw()
		end


		alt:addItem("Переместить").onTouch = function()
			alt:remove()
		wall = GUI.container(1,1, 160, 50)
		walls = GUI.panel (1, 1, 160, 50, dock_apps, 0.2)
		wall:addChild(walls)
		mainC:addChild(wall)
		llm = GUI.label (72, 20, panel.width, 1, text, "Переместить")
		wall:addChild (llm)
		file_name = GUI.input(64, 21, 30, 3, input_back, text, text, input_back_foc, text, "", "Куда переместить")
		wall:addChild(file_name).onInputFinished = function()

		if file_name.text == '' or file_name.text == nil then
		llop = GUI.label (72, 24, panel.width, 1, text, "Введите путь")
			wall:addChild (llop)
			mainC:draw()
		elseif file_name.text == unicode.sub(file, 1, -2) then
			llop = GUI.label (72, 24, panel.width, 1, text, file_name.text .. ' = ' .. file_name.text)
			wall:addChild (llop)
			mainC:draw()
		else
			os.execute('cp -r ' .. os.getenv('VIA') .. file .. ' ' .. file_name.text)
			fs.remove(os.getenv('VIA') .. file)
			wall:remove()
			iVIA()
		-- end check
		end

		-- end input func
		end

		mainC:draw()
		end

		alt:addSeparator()
		 alt:addItem("Отмена").onTouch = function()
			alt:remove()
			iVIA()
				end
		mainC:draw()
   end

  end
  end

  else

  fils:addChild (GUI.image (xy, yu, buffer.loadImage("/system/apps/via/file.pic")))
  fils:addChild (GUI.label (xy, yu+5, panel.width, 1, input_text, file))
  counts = counts + 1
  fils:addChild(GUI.framedButton(xy-1, yu-1, 10, 6, main_text, button_text, colorDesktop, colorDesktop, "")).onTouch = function(mainC, folder, enm, iddp, x, y, click)

  if enm == "touch" then
  if click == 0 then
    local result, reason = loadfile(os.getenv('VIA') .. file)
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
    else


    		-- Add context menu object to workspace and some items to it
		local alt = GUI.addContextMenu(mainContainer, x, y)
		alt:addItem("Изменить").onTouch = function()
      os.execute('edit ' .. os.getenv('VIA') .. file)
      mainC:draw(true)
		alt:remove()


		end
		alt:addItem("Переименовать").onTouch = function ()
		alt:remove()
		wall = GUI.container(1,1, 160, 50)
		walls = GUI.panel (1, 1, 160, 50, dock_apps, 0.2)
		wall:addChild(walls)
		mainC:addChild(wall)
		llm = GUI.label (72, 20, panel.width, 1, text, "Переименовать")
		wall:addChild (llm)
		file_name = GUI.input(64, 21, 30, 3, input_back, text, text, input_back_foc, text, file, "Новое имя папки")
		wall:addChild(file_name).onInputFinished = function()

		if file_name.text == '' or file_name.text == nil then
		llop = GUI.label (72, 24, panel.width, 1, text, "Введите имя")
			wall:addChild (llop)
			mainC:draw()
		elseif file_name.text == unicode.sub(file, 1, -2) then
			llop = GUI.label (72, 24, panel.width, 1, text, file_name.text .. ' = ' .. file_name.text)
			wall:addChild (llop)
			mainC:draw()
		else
			fs.rename(os.getenv('VIA') .. file, os.getenv('VIA') .. file_name.text )
			wall:remove()
			iVIA()
		-- end check
		end

		-- end input func
		end

		mainC:draw()
		end
		alt:addItem("Удалить").onTouch = function()
		fs.remove(os.getenv('VIA') .. file)
		iVIA()
		end
		alt:addItem("Копировать").onTouch = function()
				alt:remove()
		wall = GUI.container(1,1, 160, 50)
		walls = GUI.panel (1, 1, 160, 50, dock_apps, 0.2)
		wall:addChild(walls)
		mainC:addChild(wall)
		llm = GUI.label (72, 20, panel.width, 1, text, "Копировать")
		wall:addChild (llm)
		file_name = GUI.input(64, 21, 30, 3, input_back, text, text, input_back_foc, text, "", "Куда копировать")
		wall:addChild(file_name).onInputFinished = function()

		if file_name.text == '' or file_name.text == nil then
		llop = GUI.label (72, 24, panel.width, 1, text, "Введите путь")
			wall:addChild (llop)
			mainC:draw()
		elseif file_name.text == unicode.sub(file, 1, -2) then
			llop = GUI.label (72, 24, panel.width, 1, text, file_name.text .. ' = ' .. file_name.text)
			wall:addChild (llop)
			mainC:draw()
		else
			os.execute('cp -r ' .. os.getenv('VIA') .. file .. ' ' .. file_name.text)
			wall:remove()
			iVIA()
		-- end check
		end

		-- end input func
		end

		mainC:draw()
		end


		alt:addItem("Переместить").onTouch = function()
			alt:remove()
		wall = GUI.container(1,1, 160, 50)
		walls = GUI.panel (1, 1, 160, 50, dock_apps, 0.2)
		wall:addChild(walls)
		mainC:addChild(wall)
		llm = GUI.label (72, 20, panel.width, 1, text, "Переместить")
		wall:addChild (llm)
		file_name = GUI.input(64, 21, 30, 3, input_back, text, text, input_back_foc, text, "", "Куда переместить")
		wall:addChild(file_name).onInputFinished = function()

		if file_name.text == '' or file_name.text == nil then
		llop = GUI.label (72, 24, panel.width, 1, text, "Введите путь")
			wall:addChild (llop)
			mainC:draw()
		elseif file_name.text == unicode.sub(file, 1, -2) then
			llop = GUI.label (72, 24, panel.width, 1, text, file_name.text .. ' = ' .. file_name.text)
			wall:addChild (llop)
			mainC:draw()
		else
			os.execute('cp -r ' .. os.getenv('VIA') .. file .. ' ' .. file_name.text)
			fs.remove(os.getenv('VIA') .. file)
			wall:remove()
			iVIA()
		-- end check
		end

		-- end input func
		end

		mainC:draw()
		end

		alt:addSeparator()
		 alt:addItem("Отмена").onTouch = function()
			alt:remove()
			iVIA()
				end
		mainC:draw()
   end

  end
  end


  end
xy = xy + 15

end
end


iVIA()
