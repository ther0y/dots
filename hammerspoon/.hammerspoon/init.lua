local menubarHeight = 23

require("modules")
require("keybindings")
require("urlbindings")

hs.loadSpoon("AClock")
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "C", function()
	spoon.AClock:toggleShow()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "H", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.x = f.x - 10
	win:setFrame(f)
end)

hs.hotkey.bind({ "alt", "cmd", "ctrl" }, "R", function()
	hs.reload()
	hs.alert("Reloaded")
end)

function setFrame()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.w * 2.5 / 100
	f.y = (max.h * 4 / 100) + menubarHeight
	f.w = max.w * 95 / 100
	f.h = max.h * 92 / 100
	win:setFrame(f)
end

hs.urlevent.bind("w95h92", setFrame)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Left", setFrame)
