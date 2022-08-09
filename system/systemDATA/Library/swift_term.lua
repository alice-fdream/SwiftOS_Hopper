local GUI = require('GUI')

function pr(twt)
  out2:addChild (GUI.label (2, xy, out2.width, 1, input_text, ' >> ' .. twt))
  xy = xy + 1
  if xy >= 14 then
  	out2.localY = out2.localY - 1
  end
end

function read(read)
  xy = xy - 1
  read = GUI.input(2, 21, 57, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Text ")
  shell:addChild(read)
  read.onInputFinished = function()
    read:remove()
    if case ~= nil then
      pr('  >> ' .. read.text)
    case(read)
    xy = xy + 1
  end
    mainContainer:draw()
    case = nil
  end
end

function open_ssl()
  local result, reason = loadfile('/system/apps/shell/shell.lua')
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