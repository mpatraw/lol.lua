local lol = require('lol')

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
