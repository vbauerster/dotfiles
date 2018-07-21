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

local modalKey = hs.hotkey.modal.new({'ctrl', 'alt', 'shift'}, 'w', 'WM mode')
modalKey:bind({}, 'q', function() modalKey:exit() end)

local exit_timer = hs.timer.delayed.new(5, function()
	modalKey:exit()
end)

function modalKey:entered()
	exit_timer:start()
end

function modalKey:exited()
	exit_timer:stop()
    hs.alert.show('Exit WM mode', 1)
end

modalKey:bind({}, 'space', 'Push window to the next screen' , hs.grid.pushWindowNextScreen)

modalKey:bind({}, 'h', function() exit_timer:start() push(0, 0, 0.5, 1) end)
modalKey:bind({}, 'j', function() exit_timer:start() push(0, 0.5, 1, 0.5) end)
modalKey:bind({}, 'k', function() exit_timer:start() push(0, 0, 1, 0.5) end)
modalKey:bind({}, 'u', function() exit_timer:start() push(0.5, 0, 0.5, 1) end)

modalKey:bind({}, 'c', function() exit_timer:start() push(0, 0, 0.5, 0.5) end)
modalKey:bind({}, '.', function() exit_timer:start() push(0.5, 0, 0.5, 0.5) end)
modalKey:bind({}, 't', function() exit_timer:start() push(0, 0.5, 0.5, 0.5) end)
modalKey:bind({}, 'e', function() exit_timer:start() push(0.5, 0.5, 0.5, 0.5) end)

modalKey:bind({}, 'p', function() exit_timer:start() push(0.4, 0, 0.6, 1) end)
modalKey:bind({}, 'i', function() exit_timer:start() push(0.6, 0, 0.4, 1) end)
modalKey:bind({}, 'g', function() exit_timer:start() push(0, 0, 0.6, 1) end)
modalKey:bind({}, 'd', function() exit_timer:start() push(0, 0, 0.4, 1) end)

-- modalKey:bind({}, 'U', function() exit_timer:start() push(0.15, 0.15, 0.7, 0.7) end)
modalKey:bind({'alt'}, 'w', function() exit_timer:start() push(0.15, 0.1, 0.7, 0.8) end)
modalKey:bind({}, 'w', function() exit_timer:start() push(0.15, 0, 0.7, 1) end)
-- modalKey:bind({}, 'F', function() exit_timer:start() fullScreen() end)
modalKey:bind({}, 'm', function() exit_timer:start() push(0,0,1,1) end)

local delta = 40
-- modalKey:bind({}, 'h', function() exit_timer:start() push(0, 0, 0.5, 1) end)
-- modalKey:bind({}, 'h', function() exit_timer:start() push(0, 0, 0.5, 1) end)
-- modalKey:bind({}, 'h', function() exit_timer:start() push(0, 0, 0.5, 1) end)
-- modalKey:bind({}, 'h', function() exit_timer:start() push(0, 0, 0.5, 1) end)
modalKey:bind({}, 'up', function() exit_timer:start() nudge(0, -delta) end)
modalKey:bind({}, 'down', function() exit_timer:start() nudge(0, delta) end)
modalKey:bind({}, 'left', function() exit_timer:start() nudge(-delta, 0) end)
modalKey:bind({}, 'right', function() exit_timer:start() nudge(delta, 0) end)

modalKey:bind({'alt'}, 'up', function() exit_timer:start() yank(0, -delta) end)
modalKey:bind({'alt'}, 'down', function() exit_timer:start() yank(0, delta) end)
modalKey:bind({'alt'}, 'left', function() exit_timer:start() yank(-delta, 0) end)
modalKey:bind({'alt'}, 'right', function() exit_timer:start() yank(delta, 0) end)

-- Move a window between monitors
-- modalKey:bind({}, 'I', function() moveToMonitor(1) end) -- Move to first monitor
-- modalKey:bind({}, 'D', function() moveToMonitor(2) end) -- Move to second monitor
