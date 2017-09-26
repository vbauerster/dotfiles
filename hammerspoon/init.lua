-- loggerInfo = hs.logger.new("My Settings", "info")

hyper = {'ctrl', 'alt', 'shift'}

-- external bindings:
-- space: Quicksilver
-- F7: flycut
-- P: Npad mode
-- W: Window Management mode

-- table lookup: hs.inspect(hs.keycodes.map)
-- https://github.com/Hammerspoon/hammerspoon/issues/1307
local hyperModeBindings = {
	{ 'g', {}, 'pageup'},
	{ 'r', {}, 'pagedown'},
	{ 'm', {}, 'return'},
	{ 's', {}, 'tab'},
	{ 'delete', {}, 'forwarddelete'},
	{ 'h', {'shift'}, 'home'},
	{ 'n', {'shift'}, 'end'},
	{ 'c', {'alt'}, 'k'}, -- for vjump
	{ 't', {'alt'}, 'j'}, -- for vjump
	{ 'b', {'alt'}, 'x'}, -- autopairs.vim BackInstert
	{ ')', {'alt'}, 'n'}, -- autopairs.vim Jump to next closed pair
	{ '+', {'alt'}, 'pad+'},
	{ '-', {'alt'}, 'pad-'},
	{ 'u', {'cmd'}, 'z'},
}

for i,bnd in ipairs(hyperModeBindings) do
	hs.hotkey.bind(hyper, bnd[1], function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], true):post()
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
end

local hyperCmdModeBindings = {
	{ 'c', {'alt'}, 'up'},
	{ 't', {'alt'}, 'down'},
	{ 'h', {'alt'}, 'left'},
	{ 'n', {'alt'}, 'right'},
}

for i,bnd in ipairs(hyperCmdModeBindings) do
    hs.hotkey.bind({'ctrl', 'alt', 'shift', 'cmd'}, bnd[1], function()
        -- Pressed:
        hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], true):post()
    end, function()
        -- Released:
        hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], false):post()
    end, function()
        -- Repeat:
        hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
    end)
end

hs.hotkey.bind({"ctrl"}, ".", function() hs.eventtap.keyStroke({"cmd"}, 47) end)
hs.hotkey.bind({"ctrl"}, ",", function() hs.eventtap.keyStroke({"cmd"}, 34) end)
hs.hotkey.bind({"ctrl"}, ";", function() hs.eventtap.keyStroke({"cmd"}, 7) end)
hs.hotkey.bind({"ctrl", "shift"}, ".", function() hs.eventtap.keyStroke({"cmd", "alt"}, 47) end)

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
