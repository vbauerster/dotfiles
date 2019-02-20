hs.window.animationDuration = 0

-- Window Hints
hs.hints.style = 'vimperator'
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'x', 'Show window hints', hs.hints.windowHints)

hs.loadSpoon("MiroWindowsManager")
spoon.MiroWindowsManager.sizes = { 6/5, 4/3, 3/2, 2/1, 3/1, 4/1, 6/1 }
spoon.MiroWindowsManager.fullScreenSizes = {1, 6/5, 4/3, 2}
spoon.MiroWindowsManager:bindHotkeys({
  up = {{}, 't'},
  right = {{}, 'u'},
  down = {{}, 'e'},
  left = {{}, 'h'},
  fullscreen = {{}, 'x'},
  middle ={{}, 'm'}
})

-- Dvorak copy/paste
-- hs.inspect(hs.keycodes.map)
-- 44 = z
-- 47 = v
-- 11 = x
-- 34 = c
hs.hotkey.bind({'ctrl'}, '.', function() hs.eventtap.keyStroke({'cmd'}, 47) end)
hs.hotkey.bind({'ctrl'}, ',', function() hs.eventtap.keyStroke({'cmd'}, 34) end)
hs.hotkey.bind({'ctrl'}, ';', function() hs.eventtap.keyStroke({'cmd'}, 44) end)
hs.hotkey.bind({'ctrl', 'shift'}, '.', function() hs.eventtap.keyStroke({'cmd', 'alt'}, 47) end)
hs.hotkey.bind({'ctrl', 'shift'}, ',', function() hs.eventtap.keyStroke({'cmd'}, 11) end)

require 'numpad'
require 'reload-config'
require 'ctrlDoublePress'
