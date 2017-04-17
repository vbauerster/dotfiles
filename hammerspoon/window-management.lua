-- Based on https://github.com/exark/dotfiles/blob/master/.hammerspoon/init.lua

-- None of this animation shit:
hs.window.animationDuration = 0
-- Get list of screens and refresh that list whenever screens are plugged or unplugged:
-- local screens = hs.screen.allScreens()
-- local screenwatcher = hs.screen.watcher.new(function()
-- 	screens = hs.screen.allScreens()
-- end)
-- screenwatcher:start()

-- --------------------------------------------------------
-- Helper functions - these do all the heavy lifting below.
-- Names are roughly stolen from same functions in Slate :)
-- --------------------------------------------------------

-- Move a window a number of pixels in x and y
function nudge(xpos, ypos)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	f.x = f.x + xpos
	f.y = f.y + ypos
	win:setFrame(f)
end

-- Resize a window by moving the bottom
function yank(xpixels,ypixels)
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w + xpixels
	f.h = f.h + ypixels
	win:setFrame(f)
end

-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function push(x, y, w, h)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w*x)
	f.y = max.y + (max.h*y)
	f.w = max.w*w
	f.h = max.h*h
	win:setFrame(f)
end

function fullScreen()
	local win = hs.window.focusedWindow()
    win:setFullScreen(not win:isFullScreen())
end

-- Move to monitor x. Checks to make sure monitor exists, if not moves to last monitor that exists
function moveToMonitor(x)
	local win = hs.window.focusedWindow()
	local newScreen = nil
	while not newScreen do
		newScreen = screens[x]
		x = x-1
	end

	win:moveToScreen(newScreen)
end

-- -----------------
-- Window management
-- -----------------

local modalKey = hs.hotkey.modal.new(hyper, 'W', 'Window Management mode')
modalKey:bind('', 'space', function() modalKey:exit() end)
function modalKey:exited()
    hs.alert.show('Window Management mode exited', 1)
end

modalKey:bind('', 'D', 'Move window to next Display' , hs.grid.pushWindowNextScreen)

modalKey:bind('', 'C', 'Resize window to top half of screen', function() push(0, 0, 1, 0.5) end)
modalKey:bind('', 'T', 'Resize window to bottom half of screen', function() push(0, 0.5, 1, 0.5) end)
modalKey:bind('', 'H', 'Resize window to left half of screen', function() push(0, 0, 0.5, 1) end)
modalKey:bind('', 'N', 'Resize window to right half of screen', function() push(0.5, 0, 0.5, 1) end)

modalKey:bind('', 'G', 'Resize window to top left quarter of screen', function() push(0, 0, 0.5, 0.5) end)
modalKey:bind('', 'R', 'Resize window to top right quarter of screen', function() push(0.5, 0, 0.5, 0.5) end)
modalKey:bind('', 'M', 'Resize window to bottom left quarter of screen', function() push(0, 0.5, 0.5, 0.5) end)
modalKey:bind('', 'V', 'Resize window to bottom right quarter of screen', function() push(0.5, 0.5, 0.5, 0.5) end)

modalKey:bind('', 'U', 'Resize window to center', function() push(0.15, 0.15, 0.7, 0.7) end)
modalKey:bind('', 'F', 'Toggle full screen', fullScreen)
modalKey:bind('', 'W', 'Maximize window', function() push(0,0,1,1) end)

local delta = 40
modalKey:bind('', 'up', 'Move window up', function() nudge(0, -delta) end)
modalKey:bind('', 'down', 'Move window down', function() nudge(0, delta) end)
modalKey:bind('', 'left', 'Move window to left', function() nudge(-delta, 0) end)
modalKey:bind('', 'right', 'Move window to right', function() nudge(delta, 0) end)

modalKey:bind('', '-', '⍏', function() yank(0, -delta) end)
modalKey:bind('', '+', '⍖', function() yank(0, delta) end)
modalKey:bind('', ']', '⍆', function() yank(delta, 0) end)
modalKey:bind('', '[', '⍅', function() yank(-delta, 0) end)

-- Move a window between monitors
-- modalKey:bind('', 'I', function() moveToMonitor(1) end) -- Move to first monitor
-- modalKey:bind('', 'D', function() moveToMonitor(2) end) -- Move to second monitor
