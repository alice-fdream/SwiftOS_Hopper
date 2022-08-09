local shell = require("shell")
local tty = require("tty")
local text = require("text")
local sh = require("sh")
term = require('term')
gpu = require('component').gpu
comp = require('computer')

local args = shell.parse(...)

shell.prime()

if #args == 0 then
  local has_profile
  local input_handler = {hint = sh.hintHandler}
  while true do
    if io.stdin.tty and io.stdout.tty then
      if not has_profile then -- first time run AND interactive
        has_profile = true
dofile("/system/SwiftOS/configs/main_config.lua")
comp.shutdown(true)
      end
      if tty.getCursor() > 1 then
        io.write("\n")
      end
    end
    tty.window.cursor = input_handler
    local command = io.stdin:readLine(false)
    tty.window.cursor = nil
    if command then
      command = text.trim(command)
      if command == "exit" then
        return
      elseif command ~= "" then
        --luacheck: globals _ENV
        local result, reason = sh.execute(_ENV, command)
        if not result then
        end
      end
    elseif command == nil then -- false only means the input was interrupted
    end
  end
else
  -- execute command.
  local result = table.pack(sh.execute(...))
  if not result[1] then
  end
  return table.unpack(result, 2)
end
