-- disable window animation
hs.window.animationDuration = 0

hs.loadSpoon('WindowHalfsAndThirds')

hs.grid.setGrid('2x2', '2560x1600')
hs.grid.setMargins({0, 0})

local mash = {"cmd", "alt", "ctrl"}

spoon.WindowHalfsAndThirds:bindHotkeys({
    max_toggle  = { mash, "M" },
    top_half    = { mash, "Up" },
    bottom_half = { mash, "Down" },
    left_half   = { mash, "Left" },
    right_half  = { mash, "Right" },
    larger      = { mash, "PageUp" },
    smaller     = { mash, "PageDown" },
    third_up    = { mash, "Return" },
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
hs.hotkey.bind(mash, "Delete", function()
    centerFocusedWindow()
end)

-- send window to next screen
hs.hotkey.bind(mash, "N", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()

    win:setFullScreen(false)
    -- move to next screen, don't resize, make sure the window fits on screen
    win:moveToScreen(screen:next(), true, true)
end)

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

hs.hotkey.bind(mash, "1", function()
    myLaunchOrFocus("1Password 7")
end)

hs.hotkey.bind(mash, "P", function()
    myLaunchOrFocus("Plex Media Player")
end)

hs.hotkey.bind(mash, "C", function()
    myLaunchOrFocus("Google Chrome")
end)

hs.hotkey.bind(mash, "I", function()
    myLaunchOrFocus("Messages")
end)

hs.hotkey.bind(mash, "T", function()
    myLaunchOrFocus("iTerm")
end)

hs.hotkey.bind(mash, "E", function()
    myLaunchOrFocus("/Applications/Emacs.app")
end)

hs.hotkey.bind(mash, "S", function()
    myLaunchOrFocus("Spotify")
end)

hs.hotkey.bind(mash, "O", function()
    myLaunchOrFocus("Organizr")
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
