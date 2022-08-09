
local GUI = require("GUI")
local buffer = require("NyaDraw")
local computer = require("computer")
local fs = require("filesystem")
local event = require("event")


function open_object(package)
    local result, reason = loadfile('/system/apps/' .. package .. '/' .. package .. '.lua')
  mainContainer:draw()
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


function cwindow(parametrs, window)
  local abx = math.floor(parametrs[2] / 2)
  local aby = math.floor(parametrs[3] / 2)
  X11 = window
X11 = GUI.container(mainContainer.width/2 - abx, mainContainer.height/2 - aby, parametrs[2], parametrs[3])


local panel = GUI.panel (1, 1, X11.width-1, X11.height-1, backgr)
X11:addChild (panel)
X11:addChild (GUI.label (2, 2, panel.width, 1, text, parametrs[1]))
X11:addChild(GUI.panel(2, X11.height, panel.width, 1, shadow_window))
X11:addChild(GUI.panel(X11.width, 2, 1, panel.height-1, shadow_window))
X11.touchX, X11.touchY = 0, 0

X11:addChild(GUI.roundedButton (X11.width-4, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    X11:remove()
    mainContainer:draw()
end

X11.eventHandler = function(text_calc, win, evname, _, x, y)
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


mainContainer:addChild (X11)
mainContainer:draw()


end

function cbutton(x, y, w, ttxt, callBack)
  if callBack ~= nil then
    X11:addChild(GUI.roundedButton (x, y, w, 3, button_def, button_text, button_active, button_text, ttxt)).onTouch = function()
      callBack()
    end
  else
    X11:addChild(GUI.roundedButton (x, y, w, 3, button_def, button_text, button_active, button_text, ttxt))
  end
  mainContainer:draw()
end

function ctext(x, y, ttxt)
  X11:addChild (GUI.label (x, y, X11.width, 1, text, ttxt))
  mainContainer:draw()
end

function cinput(x, y, w, placeholder, callBack)
  if callBack ~= nil then
    id = GUI.input(x, y, w, 3, input_back, input_text, input_text, input_back_foc, input_text, "", placeholder)
    X11:addChild(id).onInputFinished = function(textBack)
      callBack(id.text)
    end
  else
    X11:addChild(GUI.roundedButton (x, y, w, 3, button_def, button_text, button_active, button_text, ttxt))
  end
  mainContainer:draw()
end
