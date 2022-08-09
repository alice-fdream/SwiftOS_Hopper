component = require('component')
op = component.openprinter
unicode = require('unicode')

path = ...


page = {
}

i = 1
for line in io.lines(path) do
  page[i] = line
  i = i + 1
end

daemon = 0

i = 1
while true do

daemon = daemon + 1
i = i + 1
if page[i] == "***" then
break
else

if daemon >= 20 then
op.setTitle('Документ')
op.print()
daemon = 0
end

sum = unicode.len(page[i])

if sum >= 29 then

race = sum / 29

rtx = math.ceil(race)

f = 0
esum = 28
bsum = 1

while f < rtx do


op.writeln(unicode.sub(page[i], bsum, esum), 0x000000, page[1])
bsum = bsum + 28
esum = esum + 28
daemon = daemon + 1

f = f + 1
end
else
op.writeln(page[i], 0x000000, page[1])
daemon = daemon + 1
end
end
end

op.setTitle('Документ')
op.print()
