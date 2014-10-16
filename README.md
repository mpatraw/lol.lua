# lol.lua

__lol.lua__ is an object prototyping implementation for Lua. It features __cloning__, __copying and deep copying__, and __dynamic prototyping__.

__lol.lua__ is compatible with [Lua 5.1](http://www.lua.org/versions.html#5.1) and [Lua 5.2](http://www.lua.org/versions.html#5.2).

##Installation

Copy the file [lol.lua](https://github.com/mpatraw/lol.lua/blob/master/lol.lua) inside your project folder, call it using the [require](http://www.lua.org/manual/5.1/manual.html#pdf-require) function. It will return a single object.

##Quicktour

###Cloning

####Basic Cloning

The only object to clone at the start is `lol`.

```lua
local lol = require('lol')

local point = lol:clone()
```

A cloned object acts exactly the same as the object it was cloned from, however you can specialize it.

```lua
local lol = require('lol')

local point = lol:clone()
point.x, point.y = 0, 0

local p = point:clone()
```

Both `point` and `p` now have the members `x` and `y`, but currently `point`'s members are being shared with `p`. `p` doesn't own it's own `x` and `y` members. Due to semantics, this is perfectly fine for anything that isn't a table, because when you assign to `p` with a new `x` or `y` value, it creates it's own and no longer shares with `point`. This brings us to _shared members_.

####Shared Members

If sharing members is undesirable, you have a few options, one of them is to initialize variables when a cloning occurs using `init()`.

```lua
local lol = require('lol')

local point = lol:clone()
function point:init()
    self.x, self.y = 0, 0
end

local p = point:clone()
```

Now `p` owns it's own `x` and `y` members, but `point` doesn't own anything (well, except for it's init() method).

This is an example to show you shared members:

```lua
local lol = require('lol')

local point = lol:clone()
point.x, point.y = 0, 0

local p = point:clone()

print(p.x) -- 0
point.x = 8
print(p.x) -- 8
```

###Including/Excluding

When you clone an object, the new object puts the cloned object into a list of "includes". This list is is scanned for shared methods or member if it's not found in the original object. You can think of including as a form of inheritance. You can include any number of objects, and you can even exclude them.

```lua
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
person:include(talker) -- yo
person:include(whisperer) -- psst
-- person now includes: lol, talker, and whisperer
person:talk()
person:whisper()
person:exclude(talker) -- error!
person:talk()
```

You may also check to see if an object includes or excludes another object with the `excludes()` and `includes()` methods.

```lua
local lol = require('lol')
local obj = lol:clone()
print(obj:includes(lol)) -- true
obj:exclude(lol) -- careful...
print(obj:excludes(lol)) -- error! lol has the excludes() method
```

Note: includes() and excludes() searches recusively.

###Copying/Orphaning

TODO...
