-- バー全体と、すべての項目に共通の見た目（旧設定 ~/.config/sketchybar/init.lua の compact と同じ値。色だけ palette.nix のもの）

SBAR.bar({
  color = COLORS.transparent,
  -- ノッチのある MacBook のメニューバーの高さ（38pt）。これより低いと、最大化したウィンドウの上に隙間ができる
  height = 38,
  border_width = 0,
  border_color = COLORS.surface0,
  corner_radius = 0,
  blur_radius = 0,
  shadow = { drawing = false },
  sticky = true,
  font_smoothing = true,
  padding_right = PADDINGS,
  padding_left = PADDINGS,
  y_offset = 0,
  margin = 0,
  notch_width = 200,
})

SBAR.default({
  updates = "when_shown",
  padding_left = PADDINGS,
  padding_right = PADDINGS,
  icon = {
    font = { family = FONT.icon_font, style = FONT.style_map["Bold"], size = 16.0 },
    color = COLORS.subtext0,
    padding_left = PADDINGS,
    padding_right = PADDINGS,
    background = { image = { corner_radius = 9 } },
  },
  label = {
    font = { family = FONT.label_font, style = FONT.style_map["Bold"], size = 13.0 },
    color = COLORS.subtext0,
    padding_left = PADDINGS,
    padding_right = PADDINGS,
    shadow = { drawing = false },
  },
  background = {
    height = 28,
    corner_radius = 9,
    border_width = 2,
    border_color = COLORS.surface1,
    image = { corner_radius = 9, border_color = COLORS.grey, border_width = 1 },
  },
  popup = {
    background = {
      border_width = 2,
      corner_radius = 9,
      border_color = COLORS.surface0,
      color = COLORS.base,
      shadow = { drawing = true },
    },
    blur_radius = 50,
    align = "center",
  },
  slider = {
    background = {
      height = 6,
      corner_radius = 3,
      color = COLORS.surface1,
    },
    highlight_color = COLORS.blue,
    knob = {
      string = "\u{f111}", -- 丸（Nerd Font）
      -- フォントを指定しないと sketchybar の既定のフォントになり、この記号がなく豆腐になる（旧設定は指定がなかった）
      font = { family = FONT.icon_font, style = FONT.style_map["Bold"], size = 16.0 },
      drawing = true,
      color = COLORS.lavender,
    },
  },
  scroll_texts = true,
})
