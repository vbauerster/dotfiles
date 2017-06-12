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

local modalKey = hs.hotkey.modal.new(hyper, 'W', 'WM mode')
modalKey:bind({}, 'space', function() modalKey:exit() end)

local exit_timer = hs.timer.delayed.new(3, function()
	modalKey:exit()
end)

function modalKey:exited()
	exit_timer:stop()
    hs.alert.show('Exit WM mode', 1)
end

modalKey:bind({}, 'D', 'Push window to the next screen' , hs.grid.pushWindowNextScreen)

modalKey:bind({}, 'C', function() exit_timer:start() push(0, 0, 1, 0.5) end)
modalKey:bind({}, 'T', function() exit_timer:start() push(0, 0.5, 1, 0.5) end)
modalKey:bind({}, 'H', function() exit_timer:start() push(0, 0, 0.5, 1) end)
modalKey:bind({}, 'N', function() exit_timer:start() push(0.5, 0, 0.5, 1) end)

modalKey:bind({}, 'G', function() exit_timer:start() push(0, 0, 0.5, 0.5) end)
modalKey:bind({}, 'R', function() exit_timer:start() push(0.5, 0, 0.5, 0.5) end)
modalKey:bind({}, 'M', function() exit_timer:start() push(0, 0.5, 0.5, 0.5) end)
modalKey:bind({}, 'V', function() exit_timer:start() push(0.5, 0.5, 0.5, 0.5) end)

modalKey:bind({}, 'U', function() exit_timer:start() push(0.15, 0.15, 0.7, 0.7) end)
modalKey:bind({}, 'F', function() exit_timer:start() fullScreen() end)
modalKey:bind({}, 'W', function() exit_timer:start() push(0,0,1,1) end)

local delta = 40
modalKey:bind({}, 'up', function() exit_timer:start() nudge(0, -delta) end)
modalKey:bind({}, 'down', function() exit_timer:start() nudge(0, delta) end)
modalKey:bind({}, 'left', function() exit_timer:start() nudge(-delta, 0) end)
modalKey:bind({}, 'right', function() exit_timer:start() nudge(delta, 0) end)

modalKey:bind({}, '-', '⍏', function() exit_timer:start() yank(0, -delta) end)
modalKey:bind({}, '+', '⍖', function() exit_timer:start() yank(0, delta) end)
modalKey:bind({}, ']', '⍆', function() exit_timer:start() yank(delta, 0) end)
modalKey:bind({}, '[', '⍅', function() exit_timer:start() yank(-delta, 0) end)

-- Move a window between monitors
-- modalKey:bind({}, 'I', function() moveToMonitor(1) end) -- Move to first monitor
-- modalKey:bind({}, 'D', function() moveToMonitor(2) end) -- Move to second monitor
