
local lol = require('lol')

local animal = lol:clone()
function animal:init()
    self.calls = {}
end
function animal:call()
    print(self.calls[math.random(#self.calls)])
end

local dog = animal:clone()
function dog:init()
    self.calls = {'woof', 'bark', 'sniff'}
end

local cat = animal:clone()
function cat:init()
    self.calls = {'meow', 'purr', 'hiss'}
end

local adog = dog:clone()
local acat = cat:clone()

adog:call()
acat:call()
adog:call()
acat:call()

print('a dog includes animal?', adog:includes(animal))
print('a dog includes a cat?', adog:includes(acat))
print('a dog includes lol?', adog:includes(lol))
