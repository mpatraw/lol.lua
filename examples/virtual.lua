local lol = require('lol')

local enemy = lol:clone()

function enemy:shout()
	print('I am ' .. self:whoami() .. '!!')
end

function enemy:whoami()
	return '...nobody'
end

local dragon = enemy:clone()

function dragon:whoami()
	return 'a dragon'
end

local e = enemy:clone()
local d = dragon:clone()

e:shout()
d:shout()
