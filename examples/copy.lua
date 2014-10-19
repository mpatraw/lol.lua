local lol = require('lol')
local foo = lol:clone()
foo.var = 1
local bar = foo:copy()
print(bar.var) -- 1
foo.var = 2
print(bar.var) -- 1
print(bar:includes(foo)) -- false
print(bar:includes(lol)) -- true
