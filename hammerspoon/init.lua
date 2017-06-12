-- loggerInfo = hs.logger.new("My Settings", "info")

hyper = {'cmd', 'alt', 'shift', 'ctrl'}

-- hyper layer
local hyperMode = hs.hotkey.modal.new()

-- space: Quicksilver
-- P: flycut
-- return: Npad mode
-- W: Window Management mode
local hyperModeExternalBindings = {'space', 'P', 'return', 'W'}

for i, v in ipairs(hyperModeExternalBindings) do
	hyperMode:bind({}, v, function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent(hyper, v, true):post()
		hyperMode.triggered = true
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent(hyper, v, false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent(hyper, v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
end

-- table lookup: hs.inspect(hs.keycodes.map)
-- https://github.com/Hammerspoon/hammerspoon/issues/1307
local hyperModeBindings = {
	{ 'l', {}, 'pageup'},
	{ 's', {}, 'pagedown'},
	{ 'g', {}, 'home'},
	{ 'r', {}, 'end'},
	{ 'd', {}, 'delete'},
	{ 'f', {}, 'forwarddelete'},
	{ 'm', {}, 'return'},
	{ 'c', {'alt'}, 'up'},
	{ 't', {'alt'}, 'down'},
	{ 'h', {'alt'}, 'left'},
	{ 'n', {'alt'}, 'right'},
	{ '+', {'alt'}, 'pad+'},
	{ '-', {'alt'}, 'pad-'},
	{ '}', {'alt'}, 'j'},
	{ '{', {'alt'}, 'k'},
	{ 'delete', {'cmd'}, 6}, -- cmd + z
}
 for i,bnd in ipairs(hyperModeBindings) do
	hyperMode:bind({}, bnd[1], function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], true):post()
		hyperMode.triggered = true
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent(bnd[2], bnd[3], true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
 end

-- Enter hyper layer
function hyperModeEnter()
	hyperMode.triggered = false
	hyperMode:enter()
end

-- Exit hyper layer
function hyperModeExit()
	hyperMode:exit()
	if not hyperMode.triggered then
		hs.eventtap.keyStroke('', "escape", 100000)
	end
end

-- Bind the hyper layer to F19
hs.hotkey.bind('', "F19", hyperModeEnter, hyperModeExit)

hs.hotkey.bind({"ctrl"}, ".", function() hs.eventtap.keyStroke({"cmd"}, "v") end)
hs.hotkey.bind({"ctrl"}, ",", function() hs.eventtap.keyStroke({"cmd"}, "c") end)
hs.hotkey.bind({"ctrl"}, ";", function() hs.eventtap.keyStroke({"cmd"}, "x") end)
hs.hotkey.bind({"cmd", "ctrl"}, ".", function() hs.eventtap.keyStroke({"cmd", "alt"}, "v") end)

require 'window-management'
require 'numpad'
require 'reload-config'
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
