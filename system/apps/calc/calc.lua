
local GUI = require("GUI")
local buffer = require("NyaDraw")
local computer = require("computer")
local fs = require("filesystem")
local event = require("event")



local x = ""
local y = ""
local z = ""
local disp = "x"

local mainContainer = ...

calculator = GUI.container(mainContainer.width/2-17, mainContainer.height/2-13, 33, 25)

local panel = GUI.panel (1, 1, calculator.width-1, calculator.height-1, backgr)
calculator:addChild (panel)
calculator:addChild (GUI.label (2, 2, panel.width, 1, text, "Калькулятор " .. os.getenv('VER')))
calculator:addChild(GUI.panel(2, calculator.height, panel.width, 1, shadow_window))
calculator:addChild(GUI.panel(calculator.width, 2, 1, panel.height-1, shadow_window))
calculator.touchX, calculator.touchY = 0, 0

calculator:addChild(GUI.roundedButton (calculator.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    calculator:remove()
    mainContainer:draw()
end

text_calc = GUI.label (2, 6, panel.width, 1, text, " 0 0 0")
calculator:addChild (text_calc)

but1 = GUI.button (2, 8, 4, 3, button_def, button_text, button_active, button_text, '7')
calculator:addChild(but1).onTouch = function()
if disp == "x" then
    x = x .. '7'
    text_calc:remove()
    text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
    calculator:addChild (text_calc)

  end
  if disp == "z" then
      z = z .. '7'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
end

but2 = GUI.button (8, 8, 4, 3, button_def, button_text, button_active, button_text, '8')
calculator:addChild(but2).onTouch = function()
  if disp == "x" then
      x = x .. '8'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
    if disp == "z" then
        z = z .. '8'
        text_calc:remove()
        text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
        calculator:addChild (text_calc)
      end


end

but3 = GUI.button (14, 8, 4, 3, button_def, button_text, button_active, button_text, '9')
calculator:addChild(but3).onTouch = function()
  if disp == "x" then
      x = x .. '9'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
    if disp == "z" then
        z = z .. '9'
        text_calc:remove()
        text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
        calculator:addChild (text_calc)
      end
end


but4 = GUI.button (2, 12, 4, 3, button_def, button_text, button_active, button_text, '4')
calculator:addChild(but4).onTouch = function()
  if disp == "x" then
      x = x .. '4'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
    if disp == "z" then
        z = z .. '4'
        text_calc:remove()
        text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
        calculator:addChild (text_calc)
      end
end

but5 = GUI.button (8, 12, 4, 3, button_def, button_text, button_active, button_text, '5')
calculator:addChild(but5).onTouch = function()
  if disp == "x" then
      x = x .. '5'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
    if disp == "z" then
        z = z .. '5'
        text_calc:remove()
        text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
        calculator:addChild (text_calc)
      end
end

but6 = GUI.button (14, 12, 4, 3, button_def, button_text, button_active, button_text, '6')
calculator:addChild(but6).onTouch = function()
  if disp == "x" then
      x = x .. '6'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
    if disp == "z" then
        z = z .. '6'
        text_calc:remove()
        text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
        calculator:addChild (text_calc)
      end
end


but7 = GUI.button (2, 16, 4, 3, button_def, button_text, button_active, button_text, '1')
calculator:addChild(but7).onTouch = function()
  if disp == "x" then
      x = x .. '1'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
    if disp == "z" then
        z = z .. '1'
        text_calc:remove()
        text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
        calculator:addChild (text_calc)
      end
end

but8 = GUI.button (8, 16, 4, 3, button_def, button_text, button_active, button_text, '2')
calculator:addChild(but8).onTouch = function()
  if disp == "x" then
      x = x .. '2'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
    if disp == "z" then
        z = z .. '2'
        text_calc:remove()
        text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
        calculator:addChild (text_calc)
      end
end

but9 = GUI.button (14, 16, 4, 3, button_def, button_text, button_active, button_text, '3')
calculator:addChild(but9).onTouch = function()
  if disp == "x" then
      x = x .. '3'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
    if disp == "z" then
        z = z .. '3'
        text_calc:remove()
        text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
        calculator:addChild (text_calc)
      end
end

but0 = GUI.button (2, 20, 16, 3, button_def, button_text, button_active, button_text, '0')
calculator:addChild(but0).onTouch = function()
  if disp == "x" then
      x = x .. '0'
      text_calc:remove()
      text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
      calculator:addChild (text_calc)
    end
    if disp == "z" then
        z = z .. '0'
        text_calc:remove()
        text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
        calculator:addChild (text_calc)
      end
end

plus = GUI.button (20, 8, 4, 3, button_def, button_text, button_active, button_text, '+')
calculator:addChild(plus).onTouch = function()
  y = "+"
  disp = "z"
  text_calc:remove()
  text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
  calculator:addChild (text_calc)
end

delete = GUI.button (26, 8, 4, 3, button_def, button_text, button_active, button_text, 'C')
calculator:addChild(delete).onTouch = function()
  y = ""
  disp = "x"
  x = ""
  z = ""
  text_calc:remove()
  text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
  calculator:addChild (text_calc)
end

equ = GUI.button (26, 12, 4, 11, button_def, button_text, button_active, button_text, '=')
calculator:addChild(equ).onTouch = function()
  digg()
end

minus = GUI.button (20, 12, 4, 3, button_def, button_text, button_active, button_text, '-')
calculator:addChild(minus).onTouch = function()
  y = "-"
  disp = "z"
  text_calc:remove()
  text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
  calculator:addChild (text_calc)
end

umn = GUI.button (20, 16, 4, 3, button_def, button_text, button_active, button_text, '*')
calculator:addChild(umn).onTouch = function()
  y = "*"
  disp = "z"
  text_calc:remove()
  text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
  calculator:addChild (text_calc)
end

del = GUI.button (20, 20, 4, 3, button_def, button_text, button_active, button_text, '/')
calculator:addChild(del).onTouch = function()
  y = "/"
  disp = "z"
  text_calc:remove()
  text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z)
  calculator:addChild (text_calc)
end




calculator.eventHandler = function(text_calc, win, evname, _, x, y)
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


mainContainer:addChild (calculator)
mainContainer:draw()

function digg()
  if y == "+" then
    text_calc:remove()
    text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z .. ' = ' .. tonumber(x) + tonumber(z))
    calculator:addChild (text_calc)
  end

  if y == "/" then
    text_calc:remove()
    text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z .. ' = ' .. tonumber(x) / tonumber(z))
    calculator:addChild (text_calc)
  end


  if y == "*" then
    text_calc:remove()
    text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z .. ' = ' .. tonumber(x) * tonumber(z))
    calculator:addChild (text_calc)
  end

  if y == "-" then
    text_calc:remove()
    text_calc = GUI.label (2, 6, panel.width, 1, text, x .. ' ' .. y .. ' ' .. z .. ' = ' .. tonumber(x) - tonumber(z))
    calculator:addChild (text_calc)
  end
end
