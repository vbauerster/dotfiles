-- Launch applications

local modalKey = hs.hotkey.modal.new(hyper, 'P', 'Launch Application mode')
modalKey:bind('', 'escape', function() modalKey:exit() end)

local appShortCuts = {

    C = 'Visual Studio Code',
    D = 'Dash',
    E = 'evernote',
    F = 'Firefox',
    G = 'Google Chrome',
    S = 'Quicksilver',
    T = 'iTerm'
}

for key, app in pairs(appShortCuts) do

    modalKey:bind('', key, 'Launching '..app, function() hs.application.launchOrFocus(app) end, function() modalKey:exit() end)
end

