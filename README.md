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

Both `point` and `p` now have the members `x` and `y`, but currently `point`'s members are being shared with `p`. `p` doesn't own it's own `x` and `y` members. Due to semantics, this is perfectly fine in some cases for anything that isn't a table, because when you assign to `p` with a new `x` or `y` value, it creates it's own and no longer shares with `point`. A table usually is updated in place with . or []. This brings us to __shared members__.

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

When you clone an object, the new object puts the cloned object into a list of "includes". This list is is scanned for shared methods or members if it's not found in the original object. You can think of including as a form of inheritance. You can include any number of objects, and you can even exclude them.

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
person:exclude(talker)
person:talk() -- error!
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

Copying and orphaning are two more ways to avoid sharing data, they also provide a powerful mechanism for creating different object trees and copying data when necessary.

```lua
local lol = require('lol')
local obj = lol:copy()
print(obj:includes(lol)) -- false
```

The `copy()` method performs a deep copy for everything _except_ the includes list. This is so a copied object performs exactly the same as the object copied from, except no members are shared.

The `orphan()` method is like copy, but goes a step further and "assimilates" every included object. What this essentially means, is the object owns all the methods and data and is completely independent.

```lua
local lol = require('lol')

local obj = lol:clone()
obj.data = {'hello, ', 'world'}

local o1 = obj:clone()
local o2 = obj:orphan()

print(o1:includes(lol)) -- true
print(o2:includes(lol)) -- false
print(o1.data[1] .. o1.data[2]) -- hello, world
print(o2.data[1] .. o2.data[2]) -- hello, world
o1.data[1] = 'goodbye, '
print(o1.data[1] .. o1.data[2]) -- goodbye, world
print(o2.data[1] .. o2.data[2]) -- hello, world
```

As seen above, `o2` has been completely orphaned from `lol` and `obj`.
