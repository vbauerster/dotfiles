local modalKey = hs.hotkey.modal.new(hyper, 'U', 'Numpad mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)
function modalKey:exited()
    hs.alert.show('Numpad mode exited', 1)
end

local ndic = {
	u = "pad0",
	g = "pad4",
	c = "pad5",
	r = "pad6",
	h = "pad1",
	t = "pad2",
	n = "pad3"
}
ndic[26] = "pad7"
ndic[28] = "pad8"
ndic[25] = "pad9"
-- ndic[18] = "pad1"
-- ndic[19] = "pad2"
-- ndic[20] = "pad3"

for k, v in pairs(ndic) do
	modalKey:bind('', k, function()
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
