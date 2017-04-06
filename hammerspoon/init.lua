loggerInfo = hs.logger.new("My Settings", "info")

hyper = {"cmd", "alt", "shift", "ctrl"}

-- A global variable for the sub-key Hyper Mode
f18 = hs.hotkey.modal.new('', "F18")

-- w: Window management mode
-- u: Quicksilver
extHyperBindings = {"w", "u"}

for i, v in ipairs(extHyperBindings) do
	f18:bind('', v, function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent(hyper, v, true):post()
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent(hyper, v, false):post()
		f18.triggered = true
	end)
end

hdic = {
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
	m="return",
	space="escape",
	tab="pad0"
}

hdic[18] = "pad1"
hdic[19] = "pad2"
hdic[20] = "pad3"
hdic[12] = "pad4"
hdic[13] = "pad5"
hdic[14] = "pad6"
hdic[0] = "pad7"
hdic[1] = "pad8"
hdic[2] = "pad9"

for k, v in pairs(hdic) do
	f18:bind('', k, function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent('', v, true):post()
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent('', v, false):post()
		f18.triggered = true
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent('', v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
end

-- Enter Hyper Mode
hyperPressed = function()
	f18.triggered = false
	f18:enter()
end

-- Leave Hyper Mode when F19 (caps) is pressed,
-- send ESCAPE if no other keys are pressed.
f19Released = function()
	f18:exit()
	if not f18.triggered then
		-- hs.eventtap.keyStroke('', "escape")
		-- https://github.com/Hammerspoon/hammerspoon/issues/1009
		hs.eventtap.event.newSystemKeyEvent('CAPS_LOCK', true)
		hs.eventtap.event.newSystemKeyEvent('CAPS_LOCK', false)
	end
end

-- Leave Hyper Mode when F20 (return) is pressed,
-- send RETURN if no other keys are pressed.
f20Released = function()
	f18:exit()
	if not f18.triggered then
		hs.eventtap.keyStroke('', "return")
	end
end

-- Bind the Hyper key to F19
hs.hotkey.bind('', "F19", hyperPressed, f19Released)

-- Bind the Hyper key to F20
hs.hotkey.bind('', "F20", hyperPressed, f20Released, function()
	hs.eventtap.event.newKeyEvent('', "return", true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
end)

hs.hotkey.bind({"ctrl"}, "F20", function() hs.eventtap.keyStroke({"ctrl"}, "return") end)
hs.hotkey.bind({"cmd"}, "F20", function() hs.eventtap.keyStroke({"cmd"}, "return") end)
hs.hotkey.bind({"shift"}, "F20", function() hs.eventtap.keyStroke({"shift"}, "return") end)

hs.hotkey.bind({"ctrl"}, ".", function() hs.eventtap.keyStroke({"cmd"}, "v") end)
hs.hotkey.bind({"ctrl"}, ",", function() hs.eventtap.keyStroke({"cmd"}, "c") end)
hs.hotkey.bind({"ctrl"}, ";", function() hs.eventtap.keyStroke({"cmd"}, "x") end)
hs.hotkey.bind({"cmd", "ctrl"}, ".", function() hs.eventtap.keyStroke({"cmd", "alt"}, "v") end)

require 'window-management'
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
