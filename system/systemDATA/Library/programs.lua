

function install_package(files, name)


os.execute('mkdir /system/apps/' .. name .. '/')

i = 1

while true do

local code = files[i]

i = i + 1

local file = files[i]




i = i + 1
		end


end