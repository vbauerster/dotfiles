-- local log = hs.logger.new("numpad", "info")

local modalKey = hs.hotkey.modal.new({'command', 'ctrl', 'alt', 'shift'}, 'm', 'Npad mode')
modalKey:bind({}, 'escape', function() modalKey:exit() end)

local exit_timer = hs.timer.delayed.new(4, function()
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

local npad = {}
npad[26] = 'pad0'
npad[28] = 'pad2'
npad[25] = 'pad4'
npad[29] = 'pad6'
npad[27] = 'pad8'

npad[22] = 'pad9'
npad[23] = 'pad1'
npad[21] = 'pad3'
npad[20] = 'pad5'
npad[19] = 'pad7'

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
