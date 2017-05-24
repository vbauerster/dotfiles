-- loggerInfo = hs.logger.new("My Settings", "info")

hyper = {"cmd", "alt", "shift", "ctrl"}

-- layer M
local lM = hs.hotkey.modal.new()

-- space: Quicksilver
-- P: flycut
-- U: numpad
-- W: Window Management
-- -: Select the previous input source
-- +: Select next source in input menu
local hyperBindings = {"space", "P", "U", "W", "-", "+"}

for i, v in ipairs(hyperBindings) do
	lM:bind('', v, function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent(hyper, v, true):post()
		lM.triggered = true
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent(hyper, v, false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent(hyper, v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
end

local lMbindings = {
	h="left",
	n="right",
	c="up",
	t="down",
	l="pageup",
	s="pagedown",
	g="home",
	r="end",
	d="delete",
	f="forwarddelete",
	b="tab",
	m="return"
}

for k, v in pairs(lMbindings) do
	lM:bind('', k, function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent('', v, true):post()
		lM.triggered = true
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent('', v, false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent('', v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
end

-- Enter layer M
function lMEnter()
	lM.triggered = false
	lM:enter()
end

-- Exit layer M
function lMExit()
	lM:exit()
	if not lM.triggered then
		hs.eventtap.keyStroke('', "escape", 100000)
	end
end

-- Bind the layer M to F19
hs.hotkey.bind('', "F19", lMEnter, lMExit)

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
