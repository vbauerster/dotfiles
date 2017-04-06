-- loggerInfo = hs.logger.new("My Settings", "info")

hyper = {"cmd", "alt", "shift", "ctrl"}

-- left M layer
lM = hs.hotkey.modal.new()
-- right M layer
rM = hs.hotkey.modal.new()

-- U: Quicksilver
-- W: Window Management
hyperBindings = {"U", "W"}

for i, v in ipairs(hyperBindings) do
	lM:bind('', v, function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent(hyper, v, true):post()
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent(hyper, v, false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent(hyper, v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
	rM:bind('', v, function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent(hyper, v, true):post()
		rM.triggered = true
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent(hyper, v, false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent(hyper, v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
end

lMdic = {
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
	space="escape"
}

for k, v in pairs(lMdic) do
	lM:bind('', k, function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent('', v, true):post()
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent('', v, false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent('', v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
end

rMdic = {f19 = "pad0"}
rMdic[18] = "pad1"
rMdic[19] = "pad2"
rMdic[20] = "pad3"
rMdic[12] = "pad4"
rMdic[13] = "pad5"
rMdic[14] = "pad6"
rMdic[0] = "pad7"
rMdic[1] = "pad8"
rMdic[2] = "pad9"

for k, v in pairs(rMdic) do
	rM:bind('', k, function()
		-- Pressed:
		hs.eventtap.event.newKeyEvent('', v, true):post()
		rM.triggered = true
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent('', v, false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent('', v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
end

-- Enter left M layer
leftMPressed = function()
	lM:enter()
end

-- Enter right M layer
rightMPressed = function()
	rM.triggered = false
	rM:enter()
end

-- Leave Hyper Mode when F19 (caps) is pressed,
f19Released = function()
	lM:exit()
end

-- Leave Hyper Mode when F20 (return) is pressed,
-- send RETURN if no other keys are pressed.
f20Released = function()
	rM:exit()
	if not rM.triggered then
		hs.eventtap.keyStroke('', "return", 100000)
	end
end

-- Bind the Hyper key to F19
hs.hotkey.bind('', "F19", leftMPressed, f19Released)

-- Bind the Hyper key to F20
hs.hotkey.bind('', "F20", rightMPressed, f20Released, function()
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
