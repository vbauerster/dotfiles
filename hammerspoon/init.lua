loggerInfo = hs.logger.new('My Settings', 'info')

hyper = { "cmd", "alt", "shift", "ctrl" }

-- A global variable for the sub-key Hyper Mode
k = hs.hotkey.modal.new({}, 'F18')

-- Hyper+key bindings for external handlers
extHyperBindings = {'a', 'o', 'u', 'e', 'j', 'k', 'p', ',', '.', 'space', '+', '-'}

for i,key in ipairs(extHyperBindings) do
  k:bind({}, key, nil, function() hs.eventtap.keyStroke(hyper, key)
    k.triggered = true
  end)
end

k:bind({}, 'h', nil, function() hs.eventtap.keyStroke({}, 'left') k.triggered = true end)
k:bind({}, 'n', nil, function() hs.eventtap.keyStroke({}, 'right') k.triggered = true end)
k:bind({}, 'c', nil, function() hs.eventtap.keyStroke({}, 'up') k.triggered = true end)
k:bind({}, 't', nil, function() hs.eventtap.keyStroke({}, 'down') k.triggered = true end)

k:bind({}, 'l', nil, function() hs.eventtap.keyStroke({}, 'pageup') k.triggered = true end)
k:bind({}, 's', nil, function() hs.eventtap.keyStroke({}, 'pagedown') k.triggered = true end)

k:bind({}, 'g', nil, function() hs.eventtap.keyStroke({}, 'home') k.triggered = true end)
k:bind({}, 'r', nil, function() hs.eventtap.keyStroke({}, 'end') k.triggered = true end)

k:bind({}, 'd', nil, function() hs.eventtap.keyStroke({}, 'delete') k.triggered = true end)
k:bind({}, 'b', nil, function() hs.eventtap.keyStroke({}, 'forwarddelete') k.triggered = true end)

k:bind({}, 'm', nil, function() hs.eventtap.keyStroke({}, 'return') k.triggered = true end)

-- Enter Hyper Mode
hyperPressed = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F19 (caps) is pressed,
-- send ESCAPE if no other keys are pressed.
f19Released = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'escape')
  end
end

-- Leave Hyper Mode when F20 (delete) is pressed,
-- send RETURN if no other keys are pressed.
f20Released = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'delete')
  end
end

-- Bind the Hyper key to Caps
hs.hotkey.bind({}, 'F19', hyperPressed, f19Released)

-- Bind the Hyper key to Return
hs.hotkey.bind({}, 'F20', hyperPressed, f20Released)

hs.hotkey.bind({"ctrl"}, ".", nil, function() hs.eventtap.keyStroke({"cmd"}, ".") end, nil, nil)
hs.hotkey.bind({"ctrl"}, ",", nil, function() hs.eventtap.keyStroke({"cmd"}, ",") end, nil, nil)
hs.hotkey.bind({"ctrl"}, ";", nil, function() hs.eventtap.keyStroke({"cmd"}, ";") end, nil, nil)
hs.hotkey.bind({"cmd", "ctrl"}, ".", nil, function() hs.eventtap.keyStroke({"cmd", "alt"}, ".") end, nil, nil)

-- require 'caffeine'
-- require 'clipboard'
-- require 'launch-applications'
-- require 'window-management'
require 'reload-config'

-- Lock System
-- hs.hotkey.bind(hyper, 12, 'Lock system', function() hs.caffeinate.lockScreen() end)
-- Sleep system
-- hs.hotkey.bind(hyper, 'S', 'Put system to sleep',function() hs.caffeinate.systemSleep() end)

-- Window Hints
-- hs.hints.style = 'vimperator'
-- hs.hotkey.bind(hyper, 'H', 'Show window hints', hs.hints.windowHints)

