--
-- Toggle an application: if frontmost: hide it. if not: activate/launch it
--

local function toggleApplication(name)
    local app = hs.application.find(name)
    if not app or app:isHidden() then
        hs.application.launchOrFocus(name)
    elseif hs.application.frontmostApplication() ~= app then
        app:activate()
    else
        app:hide()
    end
end

function toggleTerminal()
    toggleApplication("iTerm")
end

function toggleDictionary()
    toggleApplication("Dictionary")
end
