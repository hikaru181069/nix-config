local helpers_path = os.getenv("CONFIG_DIR") .. "/helpers/"
-- アプリ名 → アイコンの対応表（スペース番号と同じもの）
local app_icons = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/icon_map.lua")

-- 名前とアイコンの色。テーマのファイルに frontApp があればその色（home.nix が palette.lua に足す）、なければバーのほかの文字と同じ
local text_color = COLORS.front_app or COLORS.subtext0

-- 矢印の見た目: 今のアプリは、スペースより1段明るい帯（bg_band）に入れて、スペースのアイコンと見分けやすくする
-- 帯の始まりの三角は、アイコンより先に足す（左から順に並ぶため）
if BAR_STYLE == "arrows" then
  local PL = require("helpers.powerline")
  local start = PL.arrow(PL.R, COLORS.bg_bar, COLORS.bg_band)
  start.display = "active"
  SBAR.add("item", "front_app.start", start)
end

-- 今のアプリのアイコン（旧設定は名前だけだった）。名前とは別の項目にして、押したときの動きを分ける:
-- アイコンを押すと、スペース番号とアプリのメニューが入れ替わる（旧設定のスイッチの代わり）
-- アプリのメニューを出している間もアイコンは残るので、もう一度押すと元に戻る
local front_app_icon = SBAR.add("item", "front_app.icon", {
  display = "active",
  padding_right = 0,
  icon = {
    font = "sketchybar-app-font:Regular:15.0",
    color = text_color,
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
  label = { color = text_color },
  updates = true,
  click_script = helpers_path .. "sketchymenu/app_menu.sh toggle",
})

front_app:subscribe("front_app_switched", function(env)
  front_app_icon:set({ icon = { string = app_icons[env.INFO] or ":default:" } })
  front_app:set({ label = { string = env.INFO } })
end)

-- 矢印の見た目: アイコンとアプリ名を明るい帯（bg_band）に入れ、最後に三角で帯を閉じる
if BAR_STYLE == "arrows" then
  local PL = require("helpers.powerline")
  front_app_icon:set({
    padding_left = 0,
    icon = { padding_left = 8, padding_right = 4 },
    background = PL.block(COLORS.bg_band),
  })
  front_app:set({
    padding_right = 0,
    label = { padding_left = 4, padding_right = 8 },
    background = PL.block(COLORS.bg_band),
  })
  SBAR.add("item", "front_app.end", PL.arrow(PL.R, COLORS.bg_band, COLORS.transparent))
end
