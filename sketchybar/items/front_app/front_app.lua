local helpers_path = os.getenv("CONFIG_DIR") .. "/helpers/"
-- アプリ名 → アイコンの対応表（スペース番号と同じもの）
local app_icons = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/icon_map.lua")

-- 今のアプリのアイコン（旧設定は名前だけだった）。名前とは別の項目にして、押したときの動きを分ける:
-- アイコンを押すと、スペース番号とアプリのメニューが入れ替わる（旧設定のスイッチの代わり）
-- アプリのメニューを出している間もアイコンは残るので、もう一度押すと元に戻る
local front_app_icon = SBAR.add("item", "front_app.icon", {
  display = "active",
  padding_right = 0,
  icon = {
    font = "sketchybar-app-font:Regular:15.0",
    color = COLORS.cyan,
  },
  label = { drawing = false },
  updates = true,
})

front_app_icon:subscribe("mouse.clicked", function(_)
  SBAR.trigger("swap_menus_and_spaces")
end)

-- 今のアプリの名前。押すと、そのアプリのメニューを小さなウィンドウ（ポップアップ）で出す（旧設定と同じ）
local front_app = SBAR.add("item", "front_app", {
  display = "active",
  padding_left = 0,
  icon = { drawing = false },
  label = { color = COLORS.subtext0 },
  updates = true,
  click_script = helpers_path .. "sketchymenu/app_menu.sh toggle",
})

front_app:subscribe("front_app_switched", function(env)
  front_app_icon:set({ icon = { string = app_icons[env.INFO] or ":default:" } })
  front_app:set({ label = { string = env.INFO } })
end)
