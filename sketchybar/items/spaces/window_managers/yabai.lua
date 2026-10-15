local sbar_utils = require("helpers.spaces_util.sbar_util")

--- yabai-backed window manager. Unlike macos_native (keyboard shortcuts) and
--- aerospace, this drives real yabai space focus/destroy commands, and adds
--- a middle-click space-preview popup that neither of the other backends has.
--- Requires the yabai service to be running (`yabai --start-service`) and
--- Accessibility permission granted to the yabai binary.
local Window_Manager = {
	events = {
		window_change = "space_windows_change",
		focus_change = "space_change",
	},
	space_popups = {},
}

--- Initialize space items in SketchyBar
function Window_Manager:init()
	for i = 1, 10 do
		local space = sbar_utils:add_space_item(i, i)

		-- Intentional exception to the shared popup style (init.lua's
		-- SBAR.default() popup block): this is a space-preview image, not a
		-- text row, so it keeps its own thicker frame.
		space:set({
			popup = { background = { border_width = 5, border_color = COLORS.surface2 } },
		})
		self.space_popups[i] = SBAR.add("item", {
			position = "popup." .. space.name,
			padding_left = 0,
			padding_right = 0,
			background = {
				drawing = true,
				image = { corner_radius = 6, scale = 0.2 },
			},
		})

		space:subscribe(self.events.focus_change, function(env)
			sbar_utils:highlight_focused_space(space, env.SELECTED == "true")
		end)

		space:subscribe("mouse.clicked", function(env)
			self:perform_switch_desktop(env.BUTTON, env.SID, space)
		end)

		space:subscribe("mouse.exited", function(_)
			space:set({ popup = { drawing = false } })
		end)

		-- 矢印の見た目では、アイコンが番号とは別の項目なので、押したときの動きを同じにする
		local parts = sbar_utils.parts[space.name]
		if parts then
			parts.apps:subscribe("mouse.clicked", function(env)
				self:perform_switch_desktop(env.BUTTON, tostring(i), space)
			end)
		end
	end
end

function Window_Manager:start_watcher()
	-- See macos_native.lua for why this is a single global observer instead
	-- of a per-space subscription.
	local watcher = SBAR.add("item", {
		drawing = false,
		updates = true,
	})

	watcher:subscribe(self.events.window_change, function(env)
		self:update_space_label(env.INFO.space, env.INFO.apps)
	end)
end

--- @param button string the mouse button clicked
--- @param sid string clicked space's id
--- @param space SketchybarItem the clicked space item (for the preview popup)
function Window_Manager:perform_switch_desktop(button, sid, space)
	if button == "other" then -- middle click
		self.space_popups[tonumber(sid)]:set({ background = { image = "space." .. sid } })
		space:set({ popup = { drawing = "toggle" } })
	else
		local op = (button == "right") and "--destroy" or "--focus"
		SBAR.exec("yabai -m space " .. op .. " " .. sid)
	end
end

--- @param space number The ID of the space to update
--- @param apps table<string, any> List of application names in this space
function Window_Manager:update_space_label(space, apps)
	local apps_list = {}
	for app_name, _ in pairs(apps) do
		table.insert(apps_list, app_name)
	end
	sbar_utils:update_space(space, apps_list)
end

return Window_Manager
