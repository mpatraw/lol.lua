local lol = require('lol')

local point = lol:clone()
point.x, point.y = 0, 0

local p = point:clone()
print(p.x, p.y)
point.x, point.y = 'not 0', 'not 0'
print(p.x, p.y)
