-- loggerInfo = hs.logger.new("My Settings", "info")

-- table lookup: https://github.com/Hammerspoon/hammerspoon/issues/1307
-- local ctrlAltBindings = {
-- 	{ 'c', {'alt'}, 'up'},
-- 	{ 't', {'alt'}, 'down'},
-- 	{ 'h', {'alt'}, 'left'},
-- 	{ 'n', {'alt'}, 'right'},
-- }
--  for i,bnd in ipairs(ctrlAltBindings) do
-- 	hs.hotkey.bind({"ctrl", "alt"}, bnd[1], function()
-- 		-- Pressed:
-- 		hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], true):post()
-- 	end, function()
-- 		-- Released:
-- 		hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], false):post()
-- 	end, function()
-- 		-- Repeat:
-- 		hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
-- 	end)
-- end

-- hs.inspect(hs.keycodes.map)
-- 44 = z
-- 47 = v
-- 11 = x
-- 34 = c
hs.hotkey.bind({"ctrl"}, ".", function() hs.eventtap.keyStroke({"cmd"}, 47) end)
hs.hotkey.bind({"ctrl"}, ",", function() hs.eventtap.keyStroke({"cmd"}, 34) end)
hs.hotkey.bind({"ctrl"}, ";", function() hs.eventtap.keyStroke({"cmd"}, 11) end)
hs.hotkey.bind({"ctrl", "alt"}, ".", function() hs.eventtap.keyStroke({"cmd", "alt"}, 47) end)
hs.hotkey.bind({"ctrl", "shift"}, ",", function() hs.eventtap.keyStroke({"cmd"}, 44) end)
hs.hotkey.bind({"ctrl", "shift"}, ".", function() hs.eventtap.keyStroke({"shift", "cmd"}, 44) end)

require 'window-management'
require 'numpad'
require 'reload-config'
require 'ctrlDoublePress'
-- require 'caffeine'
-- require 'clipboard'
-- require 'launch-applications'

-- Lock System
-- hs.hotkey.bind(hyper, 12, 'Lock system', function() hs.caffeinate.lockScreen() end)
-- Sleep system
-- hs.hotkey.bind(hyper, 'S', 'Put system to sleep',function() hs.caffeinate.systemSleep() end)

-- Window Hints
-- hs.hints.style = 'vimperator'
-- hs.hotkey.bind(hyper, 'H', 'Show window hints', hs.hints.windowHints)
