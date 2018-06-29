-- local log = hs.logger.new("numpad", "info")

local modalKey = hs.hotkey.modal.new({'command', 'ctrl', 'alt', 'shift'}, 'm', 'Npad mode')
modalKey:bind({}, 'q', function() modalKey:exit() end)
modalKey:bind({}, 'j', function() modalKey:exit() hs.eventtap.keyStroke({}, 'j') end)
modalKey:bind({}, 'k', function() modalKey:exit() hs.eventtap.keyStroke({}, 'k') end)

local exit_timer = hs.timer.delayed.new(5, function()
	-- log.i("timer fired")
	modalKey:exit()
end)

function modalKey:entered()
	exit_timer:start()
end

function modalKey:exited()
	exit_timer:stop()
	hs.alert.show('Exit Npad mode', 1)
end

-- 7531902468
-- hs.inspect(hs.keycodes.map)
local npad = {}
-- npad[48] = 'delete'

npad[4] = 'pad0'
npad[38] = 'pad2'
npad[40] = 'pad4'
npad[37] = 'pad6'
npad[41] = 'pad8'

npad[3] = 'pad1'
npad[2] = 'pad3'
npad[1] = 'pad5'
npad[0] = 'pad7'
npad[5] = 'pad9'

for k, v in pairs(npad) do
	modalKey:bind({}, k, function()
		-- Pressed:
		exit_timer:start()
		hs.eventtap.event.newKeyEvent({}, v, true):post()
	end, function()
		-- Released:
		hs.eventtap.event.newKeyEvent({}, v, false):post()
	end, function()
		-- Repeat:
		hs.eventtap.event.newKeyEvent({}, v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
	end)
end
