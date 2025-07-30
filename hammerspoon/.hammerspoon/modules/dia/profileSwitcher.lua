---@class ProfileSwitcher
local M = {}

local cachedDiaWindows = {}

---Focus a Dia window by its pinned tab name
---@param tabName string The name of the pinned tab to focus
---@param next function The function to call after the window is focused
local function focusDiaByPinnedTab(tabName, next)
	local cached = cachedDiaWindows[tabName]
	if cached and cached:isVisible() and cached:title() ~= "" then
		cached:focus()
		if next then
			next()
		end
		return
	end

	for _, win in ipairs(hs.window.filter.new("Dia"):getWindows()) do
		local axWin = hs.axuielement.windowElement(win)
		if not axWin then
			goto continue
		end

		local children = axWin.AXChildren or {}
		for _, child in ipairs(children) do
			if child:attributeValue("AXRole") == "AXGroup" then
				local subChildren = child:attributeValue("AXChildren") or {}
				for _, tab in ipairs(subChildren) do
					local title = tab:attributeValue("AXTitle")
					if title == tabName then
						cachedDiaWindows[tabName] = win
						win:focus()
						if next then
							next()
						end
						return
					end
				end
			end
		end
		::continue::
	end

	hs.alert("No Dia window with pinned tab: " .. tabName)
end

-- Focus a specific tab in a window
---@param window hs.window The Dia window to operate in
---@param tabTitle string The internal tab title to focus
local function focusTabInWindow(window, tabTitle)
	local maxAttempts = 5
	local delayBetween = 0.3 -- seconds
	local targetRole = "AXUnknown" -- Based on Dia's AX tree for tabs

	local mousePos = hs.mouse.absolutePosition() -- Updated for deprecation

	local function trySearch()
		window:focus()
		hs.timer.usleep(100000) -- Increased settle time (100ms) for Dia's UI

		local axWin = hs.axuielement.windowElement(window)
		if not axWin then
			return false
		end

		local tabs = {} -- Collect potential tabs first
		local function collectTabs(el)
			local title = el:attributeValue("AXTitle")
			local role = el:attributeValue("AXRole") or "unknown"
			if title and role == targetRole then
				table.insert(tabs, { element = el, title = title, role = role })
			end

			for _, child in ipairs(el:attributeValue("AXChildren") or {}) do
				collectTabs(child)
			end
		end

		collectTabs(axWin) -- Build list of tabs

		-- Log found tabs for debugging
		if #tabs > 0 then
			print("Found " .. #tabs .. " potential tabs (AXUnknown with titles):")
			for i, tab in ipairs(tabs) do
				print("Tab " .. i .. ": " .. tab.title .. " (role: " .. tab.role .. ")")
			end
		else
			print("No tabs found with role '" .. targetRole .. "' and title")
		end

		for _, tab in ipairs(tabs) do
			if string.find(tab.title, tabTitle) then -- Partial match; change to == for exact
				local actions = tab.element:actionNames() or {}
				if hs.fnutils.contains(actions, "AXPress") then
					tab.element:performAction("AXPress")
					return true
				end

				-- Fallback to click if no press action
				local pos = tab.element:attributeValue("AXPosition")
				local size = tab.element:attributeValue("AXSize")
				if pos and size then
					local center = { x = pos.x + size.w / 2, y = pos.y + size.h / 2 }
					hs.eventtap.leftClick(center)
					hs.timer.doAfter(0.1, function()
						hs.mouse.setAbsolutePosition(mousePos)
					end)
					return true
				end
			end
		end

		return false
	end

	-- Retry loop
	local attempt = 1
	local function retry()
		if trySearch() then
			return
		end
		if attempt < maxAttempts then
			attempt = attempt + 1
			hs.timer.doAfter(delayBetween, retry)
		else
			hs.alert("Tab containing '" .. tabTitle .. "' not found after " .. maxAttempts .. " tries")
		end
	end

	retry()
end

---Switch to a specific profile by focusing its pinned tab
---@param profileName string The name of the profile to switch to
function M.switchProfile(profileName)
	focusDiaByPinnedTab(profileName)
end

function M.switchTab(profileName, tabName)
	focusDiaByPinnedTab(profileName)
	focusTabInWindow(hs.window.focusedWindow(), tabName)
end

function M.switchProfileAndOpenUrl(profileName, url)
	focusDiaByPinnedTab(profileName, function()
		hs.urlevent.openURL(url)
	end)
end

return M
