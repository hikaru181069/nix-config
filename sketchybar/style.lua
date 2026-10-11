-- バー全体と、すべての項目に共通の見た目
-- バー自体は透明にして、項目のまとまりごとに角の丸い「島」を浮かべる（島は items/island.lua）
local colors = require("colors")

-- ノッチのある MacBook のメニューバーの高さ（38pt）。これより低いと、最大化したウィンドウの上に隙間ができる
sbar.bar({
  height = 38,
  color = colors.transparent,
  padding_left = 8,
  padding_right = 8,
  notch_width = 200,
  sticky = true,
  shadow = false,
})

sbar.default({
  updates = "when_shown",
  padding_left = 2,
  padding_right = 2,
  icon = {
    font = { family = "Maple Mono NF", style = "Bold", size = 14.0 },
    color = colors.fg2,
    padding_left = 6,
    padding_right = 4,
  },
  label = {
    font = { family = "Maple Mono NF", style = "Bold", size = 13.0 },
    color = colors.fg2,
    padding_left = 4,
    padding_right = 6,
  },
  background = { height = 24, corner_radius = 8 },
})
