local shell = require("shell")
local tty = require("tty")
local fs = require("filesystem")
local gpu = require('component').gpu
local term = require('term')
local gpu = require('component').gpu
local string = require('string')

gpu.setBackground(0x3f096d)
gpu.setForeground(0x000000)
term.clear()

if tty.isAvailable() then
  if io.stdout.tty then
    io.write("\27[40m\27[37m")
    tty.clear()
  end
end

shell.setAlias("dir", "ls")
shell.setAlias("move", "mv")
shell.setAlias("rename", "mv")
shell.setAlias("copy", "cp")
shell.setAlias("del", "rm")
shell.setAlias("md", "mkdir")
shell.setAlias("cls", "clear")
shell.setAlias("rs", "redstone")
shell.setAlias("view", "edit -r")
shell.setAlias("help", "man")
shell.setAlias("cp", "cp -i")



os.setenv('VER', 'Hopper')
os.setenv('NAME', 'SwiftOS')

local id_ip = io.open('/system/SwiftOS/configs/ip')
local ip = id_ip:read()
id_ip:close()

local ch = io.open('/system/SwiftOS/configs/SAEE4.0')
local ch1 = ch:read()
ch:close()

if ip == nil then
local id_ip = io.open('/system/SwiftOS/configs/ip', 'w')
local dates = string.format("%.0f", math.random(22, 200)) .. '.' .. string.format("%.0f",math.random(22, 200)) .. '.' .. string.format("%.0f",math.random(1, 50)) .. '.' .. string.format("%.0f",math.random(1, 100))
id_ip:write(dates)
id_ip:close()
end


if ch1 == '0' or ch1 == nil or ch1 == 0 then
os.execute('/system/SwiftOS/gui/welcome.lua')
else
  os.execute('/system/systemDATA/auth/auth.lua')
end
