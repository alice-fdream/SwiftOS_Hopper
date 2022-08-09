local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local gpu = require('component').gpu
local term = require('term')
local md5 = require('md5')
local unicode = require('unicode')
local fs = require('filesystem')
------------------------------------------------------------------------------------------
require("get_them")
buffer.setGPUProxy(require("component").gpu)
css_ref()
------------------------------------------------------------------------------------------


mainContainer = GUI.application()

mainContainer:addChild(GUI.panel(1, 1, mainContainer.width, mainContainer.height, colorDesktop))

auth = GUI.container(1, 1, 160, 50)
local panel = GUI.panel (1, 1, 160, 200, colorDesktop)
auth:addChild (panel)

mssv = ''
for file in fs.list('/Users/') do
  mssv = mssv .. ' ' .. unicode.sub(file, 1, -2)
end

users={}
for str in string.gmatch(mssv, "([^%s]+)") do
    table.insert(users, str)
end


local posy = 3

for _, claster in pairs(users) do


user  = GUI.container(mainContainer.width/2-20, posy, 40, 9)
posy = posy + 10
user:addChild(GUI.panel (1, 1, 40, 13, backgr))
user:addChild (GUI.image (2, 2, buffer.loadImage("/system/systemDATA/images/user.pic")))
user:addChild (GUI.label (19, 5, auth.width, auth.height, text, claster))
auth:addChild(user).eventHandler = function (main, win, evn, _, x, y, _, pll)
if evn == 'touch' then
  mainContainer:stop()
  os.setenv('PLA', claster)
  if pll == claster then
 local result, reason = loadfile('/system/SwiftOS/gui/gui.lua')
  if result then
    result, reason = pcall(result)
    if not result then
     error("Ошибка запуска рабочего стола " .. reason)
 end
else
 error("Ошибка запуска рабочего стола " .. reason)
 end

else
computer.beep(600, 0.2)
computer.beep(550, 0.2)
end
end
  end

end







mainContainer:addChild (auth)
mainContainer:draw  ()
mainContainer:start ()
