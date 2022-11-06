-- disable window animation
hs.window.animationDuration = 0

hs.loadSpoon('WindowHalfsAndThirds')

hs.grid.setGrid('9x5', '5120x2160')
hs.grid.HINTS={
    {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'},
    {'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R'},
    {'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '1'},
    {'2', '3', '4', '5', '6', '7', '8', '9', '0'},
    {'-', '=', ',', '.', '[', ']', '`', '/', '\\'}
}
hs.grid.setMargins({0, 0})

local mash = {"cmd", "alt", "ctrl"}
local meh = {"ctrl", "alt", "shift"}
local audio = require 'hs.audiodevice'
local volume = {}

spoon.WindowHalfsAndThirds:bindHotkeys({
    max_toggle  = { mash, "M" },
    top_half    = { mash, "Up" },
    bottom_half = { mash, "Down" },
    left_half   = { mash, "Left" },
    right_half  = { mash, "Right" },
    -- larger      = { mash, "PageUp" },
    -- smaller     = { mash, "PageDown" },
    -- third_up    = { mash, "Return" },
})

-- Like hs.application.launchOrFocus, except that it works for apps created using Epichrome.
-- I'm not sure why this implementation has different behavior than hs.application.launchOrFocus.
-- Reference: https://github.com/Hammerspoon/hammerspoon/issues/304
function myLaunchOrFocus(appName)
  local app = hs.appfinder.appFromName(appName)
  if app == nil then
    hs.application.launchOrFocus(appName)
  else
    windows = app:allWindows()
    if windows[1] then
      windows[1]:focus()
    end
  end
end

function centerFocusedWindow()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = max.w / 2
  f.h = ((max.w / 2) / 16) * 9
  win:setFrame(f)
  win:centerOnScreen()
end

-- show modal grid selector
hs.hotkey.bind(mash, "Space", function()
    hs.grid.show()
end)

-- send window to center at half screen width @ 16:9 ratio
hs.hotkey.bind(mash, "Return", function()
    centerFocusedWindow()
end)

-- volume helper
function changeVolume(diff)
  return function()
    local current = hs.audiodevice.defaultOutputDevice():volume()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    if new > 0 then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    end
    hs.alert.closeAll(0.0)
    hs.alert.show("Volume " .. new .. "%", {}, 0.5)
    hs.audiodevice.defaultOutputDevice():setVolume(new)
  end
end

-- volume
function volume.mute()
    local dev = audio.defaultOutputDevice()
    return dev and dev:setMuted(true)
end

function volume.unmute()
    local dev = audio.defaultOutputDevice()
    return dev and dev:setMuted(false)
end

function volume.muted()
    local dev = audio.defaultOutputDevice()
    return dev and dev:muted()
end

hs.hotkey.bind(mash, '0', function()
  if volume.muted() then
    volume.unmute()
  else
    volume.mute()
  end
end)
hs.hotkey.bind(mash, '-', changeVolume(-3))
hs.hotkey.bind(mash, '=', changeVolume(3))

-- media keys
hs.hotkey.bind(mash, "/", function()
  hs.eventtap.event.newSystemKeyEvent('PLAY', true):post()
  hs.eventtap.event.newSystemKeyEvent('PLAY', false):post()
end)

hs.hotkey.bind(mash, ".", function()
  hs.eventtap.event.newSystemKeyEvent('NEXT', true):post()
  hs.eventtap.event.newSystemKeyEvent('NEXT', false):post()
end)

hs.hotkey.bind(mash, ",", function()
  hs.eventtap.event.newSystemKeyEvent('PREVIOUS', true):post()
  hs.eventtap.event.newSystemKeyEvent('PREVIOUS', false):post()
end)

-- send window to next screen
-- hs.hotkey.bind(mash, "N", function()
--     local win = hs.window.focusedWindow()
--     local screen = win:screen()
--
--     win:setFullScreen(false)
--     -- move to next screen, don't resize, make sure the window fits on screen
--     win:moveToScreen(screen:next(), true, true)
-- end)

hs.hotkey.bind(mash, "F", function()
    finder = hs.appfinder.appFromName("Finder")
    finderWindows = finder:allWindows()

    if finderWindows[2] == nil then
      finder:selectMenuItem({"File","New Finder Window"})
      finderWindows = finder:allWindows()
      finderWindows[2]:focus()
      centerFocusedWindow()
    else
      finderWindows[2]:focus()
    end
    finder:activate()
end)

hs.hotkey.bind(mash, "T", function()
    myLaunchOrFocus("iTerm")
end)

hs.hotkey.bind(mash, "S", function()
    myLaunchOrFocus("Slack")
end)
hs.hotkey.bind(meh, "S", function()
    myLaunchOrFocus("Slack")
end)

hs.hotkey.bind(mash, "O", function()
    myLaunchOrFocus("Microsoft Outlook")
end)

hs.hotkey.bind(mash, "N", function()
    myLaunchOrFocus("Obsidian")
end)

hs.hotkey.bind(mash, "I", function()
    myLaunchOrFocus("Messages")
end)

-- reload config
hs.hotkey.bind(mash, "R", function()
    hs.reload()
end)

-- bypass blocked paste functionality (usually in silly websites)
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

-- get an alert whenever the config is reloaded
-- hs.alert.show("Hammerspoon config loaded")
hs.loadSpoon('FadeLogo'):start()
