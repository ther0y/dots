local dia = require("modules.dia")

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "W", function()
	print("Hello World")
	dia.swtichProfile("WorkChat")
end)

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "P", function()
	print("Hello World")
	dia.swtichProfile("PersonMail")
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
	local app = hs.application.find("chat")

	if app then
		app:activate()
	else
		hs.alert.show("ChatGpt is not running")
	end
end)
