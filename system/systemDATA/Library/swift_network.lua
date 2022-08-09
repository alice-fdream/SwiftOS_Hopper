
local GUI = require("GUI")
local buffer = require("NyaDraw")
local computer = require("computer")
local fs = require("filesystem")
local event = require("event")
local unicode = require('unicode')
local modem = require('component').modem
local serializ = require('serialization')


function send_request(ip, key, swift)
	local data = serializ.serialize({ip, key, os.getenv('IP'), swift})
	modem.broadcast(1184, data)
end