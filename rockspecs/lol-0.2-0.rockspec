package = 'lol'
version = '0.2-0'
source = {
    url = 'git://github.com/mpatraw/lol',
    tag = 'v0.2'
}
description = {
    summary = 'lol object for lua.',
    detailed = [[
    ]],
    homepage = 'http://mpatraw.github.io/lol',
    license = 'ICS'
}
dependencies = {
    'lua => 5.1, < 5.3'
}
build = {
    type = 'builtin',
    modules = {
        ['lol'] = 'lol.lua'
    },
    copy_directories = {'doc', 'examples'}
}
