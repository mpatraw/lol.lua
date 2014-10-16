
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



local point = lol:clone()
point.x, point.y = 0, 0

local p = point:clone()

print(p.x) -- 0
point.x = 8
print(p.x) -- 8

print()

local talker = lol:clone()
function talker:talk()
    print('yo')
end

local whisperer = lol:clone()
function whisperer:whisper()
    print('psst')
end

local person = lol:clone()
person:include(talker)
person:include(whisperer)
person:talk()
person:whisper()
person:exclude(talker)
person:talk()
