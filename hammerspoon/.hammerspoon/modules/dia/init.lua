---@class DiaModule
local M = {}

local profileSwitcher = require("modules.dia.profileSwitcher")

M.swtichProfile = profileSwitcher.switchProfile

M.switchTab = profileSwitcher.switchTab

M.switchProfileAndOpenUrl = profileSwitcher.switchProfileAndOpenUrl

return M
