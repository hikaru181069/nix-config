local helpers_path = os.getenv("CONFIG_DIR") .. "/helpers/"
-- アプリ名 → アイコンの対応表（スペース番号と同じもの）
local app_icons = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/icon_map.lua")

-- 帯と、名前・アイコンの色。tmux のユーザー名のブロックと同じ（地は fg_dim、文字は暗い bg_bar）
local band_color = COLORS.block_fg_dim -- fg_dim をバーの地に寄せて暗くした色（palette.nix）
local text_color = COLORS.bg_bar

-- 矢印の見た目: 今のアプリは、tmux のユーザー名と同じ色の帯（band_color）に入れて、スペースのアイコンと見分けやすくする
-- 帯の始まりの三角は、アイコンより先に足す（左から順に並ぶため）
if BAR_STYLE == "arrows" then
  local PL = require("helpers.powerline")
  local start = PL.arrow(PL.R, COLORS.bg_bar, band_color)
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
  -- 太字（tmux のユーザー名と同じ。sketchybar のほかの文字はふつうの太さ）
  label = { color = text_color, font = { style = FONT.style_map["Bold"] } },
  updates = true,
  click_script = helpers_path .. "sketchymenu/app_menu.sh toggle",
})

front_app:subscribe("front_app_switched", function(env)
  front_app_icon:set({ icon = { string = app_icons[env.INFO] or ":default:" } })
  front_app:set({ label = { string = env.INFO } })
end)

-- 矢印の見た目: アイコンとアプリ名を帯（band_color）に入れ、最後に三角で帯を閉じる
if BAR_STYLE == "arrows" then
  local PL = require("helpers.powerline")
  front_app_icon:set({
    padding_left = 0,
    icon = { padding_left = 8, padding_right = 4 },
    background = PL.block(band_color),
  })
  front_app:set({
    padding_right = 0,
    label = { padding_left = 4, padding_right = 8 },
    background = PL.block(band_color),
  })
  SBAR.add("item", "front_app.end", PL.arrow(PL.R, band_color, COLORS.transparent))
end
