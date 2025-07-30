local dia = require("modules.dia")

hs.urlevent.bind("dia_profiles_work", function()
	dia.swtichProfile("WorkChat")
end)

hs.urlevent.bind("dia_profiles_personal", function()
	dia.swtichProfile("PersonMail")
end)

hs.urlevent.bind("dia_profiles_work_tab", function(event, params)
	dia.switchTab("WorkChat", params.tabName)
end)

hs.urlevent.bind("dia_profiles_personal_tab", function(tabName)
	dia.switchTab("PersonMail", tabName)
end)

hs.urlevent.bind("dia_profiles_work_url", function(event, params)
	dia.switchProfileAndOpenUrl("WorkChat", params.url)
end)

hs.urlevent.bind("dia_profiles_personal_url", function(event, params)
	dia.switchProfileAndOpenUrl("PersonMail", params.url)
end)
