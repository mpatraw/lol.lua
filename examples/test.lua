local lol = require('lol')

local obj = lol:clone()
function obj:init()
    self.data = {'hello, ', 'world'}
end

local o1 = obj:clone()
local o2 = obj:orphan()

print(o1:includes(lol)) -- true
print(o2:includes(lol)) -- false
print(o1.data[1] .. o1.data[2]) -- hello, world
print(o2.data[1] .. o2.data[2]) -- hello, world
o1.data[1] = 'goodbye, '
print(o1.data[1] .. o1.data[2]) -- goodbye, world
print(o2.data[1] .. o2.data[2]) -- hello, world
