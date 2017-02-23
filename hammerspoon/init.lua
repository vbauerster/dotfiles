loggerInfo = hs.logger.new("My Settings", "info")

hyper = { "cmd", "alt", "shift", "ctrl" }

-- A global variable for the sub-key Hyper Mode
f18 = hs.hotkey.modal.new({}, "F18")

-- Hyper+key bindings for external handlers
extHyperBindings = {"a", "o", "u", "e", "j", "k", "p", ",", ".", "space", "+", "-"}

for i, v in ipairs(extHyperBindings) do
  f18:bind({}, v, function()
        -- Pressed:
        hs.eventtap.event.newKeyEvent(hyper, v, true):post()
      end, function()
        -- Released:
        hs.eventtap.event.newKeyEvent(hyper, v, false):post()
        f18.triggered = true
      end)
end

hdic = {h="left", n="right", c="up", t="down", l="pageup", s="pagedown", g="home", r="end", d="delete", f="forwarddelete", b="tab", m="return"}

for k, v in pairs(hdic) do
  f18:bind({}, k, function()
      -- Pressed:
      hs.eventtap.event.newKeyEvent({}, v, true):post()
    end, function()
      -- Released:
      hs.eventtap.event.newKeyEvent({}, v, false):post()
      f18.triggered = true
    end, function()
      -- Repeat:
      hs.eventtap.event.newKeyEvent({}, v, true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
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
    hs.eventtap.keyStroke({}, "escape")
  end
end

-- Leave Hyper Mode when F20 (delete) is pressed,
-- send DELETE if no other keys are pressed.
f20Released = function()
  f18:exit()
  if not f18.triggered then
    hs.eventtap.keyStroke({}, "delete")
  end
end

-- Bind the Hyper key to F19
hs.hotkey.bind({}, "F19", hyperPressed, f19Released)

-- Bind the Hyper key to F20
hs.hotkey.bind({}, "F20", hyperPressed, f20Released, function()
  hs.eventtap.event.newKeyEvent({}, "delete", true):setProperty(hs.eventtap.event.properties.keyboardEventAutorepeat, 1):post()
end)

hs.hotkey.bind({"ctrl"}, ".", nil, function() hs.eventtap.keyStroke({"cmd"}, ".") end)
hs.hotkey.bind({"ctrl"}, ",", nil, function() hs.eventtap.keyStroke({"cmd"}, ",") end)
hs.hotkey.bind({"ctrl"}, ";", nil, function() hs.eventtap.keyStroke({"cmd"}, ";") end)
hs.hotkey.bind({"cmd", "ctrl"}, ".", nil, function() hs.eventtap.keyStroke({"cmd", "alt"}, ".") end)

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

