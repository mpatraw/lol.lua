local lol = require('lol')

local point = lol:clone()
function point:init()
    self.x, self.y = 0, 0
end

local p = point:clone()
print(p.x, p.y)
