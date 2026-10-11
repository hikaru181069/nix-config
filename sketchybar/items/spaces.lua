-- スペース番号（yabai のスペース 1〜10）。今いるスペースを目立たせ、中のアプリのアイコンを並べる
-- 押すとそのスペースへ移る
local colors = require("colors")
local island = require("items.island")
-- アプリ名 → アイコン（sketchybar-app-font の文字）の対応表。フォントと同じパッケージのものを使う
local icon_map = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/icon_map.lua")

local names = {}
local spaces = {}

for i = 1, 10 do
  local space = sbar.add("space", "space." .. i, {
    -- 存在しないスペース（作っていない番号）は自動で隠れる
    space = i,
    icon = {
      string = tostring(i),
      color = colors.fg3,
      highlight_color = colors.blue,
      padding_left = 8,
      padding_right = 4,
    },
    label = {
      font = { family = "sketchybar-app-font", style = "Regular", size = 14.0 },
      color = colors.fg3,
      highlight_color = colors.fg1,
      padding_right = 8,
      y_offset = -1,
    },
    background = { color = colors.transparent },
    click_script = "yabai -m space --focus " .. i,
  })
  spaces[i] = space
  names[#names + 1] = space.name

  -- 今いるスペースは、番号を青く、アプリのアイコンを明るくし、背景を選択範囲の色にする
  space:subscribe("space_change", function(env)
    local selected = env.SELECTED == "true"
    space:set({
      icon = { highlight = selected },
      label = { highlight = selected },
      background = { color = selected and colors.sel0 or colors.transparent },
    })
  end)
end

island("spaces", names)

-- 各スペースのアプリのアイコンを、yabai に聞いて並べ直す
local function update_app_icons()
  sbar.exec("yabai -m query --windows", function(windows)
    local apps = {}
    for _, window in ipairs(windows) do
      if not window["is-minimized"] and not window["is-hidden"] then
        apps[window.space] = apps[window.space] or {}
        apps[window.space][window.app] = true
      end
    end
    for i, space in pairs(spaces) do
      local icons = ""
      for app in pairs(apps[i] or {}) do
        icons = icons .. (icon_map[app] or ":default:")
      end
      -- アプリがないスペースは、番号だけにする
      space:set({ label = { string = icons, drawing = icons ~= "" } })
    end
  end)
end

-- ウィンドウの出入りやアプリの切り替えで並べ直す（イベントを受けるだけの見えない項目）
local observer = sbar.add("item", "spaces.observer", { drawing = false, updates = true })
observer:subscribe({ "space_windows_change", "front_app_switched", "space_change" }, update_app_icons)
update_app_icons()
