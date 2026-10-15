-- Padding item required because of bracket
SBAR.add("item", { width = 5 })

local apple = SBAR.add("item", {
  icon = {
    font = { size = 22.0 },
    string = ICONS.apple,
    color = COLORS.red,
    padding_right = 8,
    padding_left = 8,
  },
  label = { drawing = false },
  padding_left = 1,
  padding_right = 1,
  click_script = "sketchybar-menus -s 0",
})

-- 矢印の見た目: 赤いりんごを、tmux のセッション名と同じ背景（bg0。バーと同じ色）に置く。
-- 右の帯も bg0 なのでひと続きになり、矢印は見えない（tmux の選んでいないウィンドウと同じく、場所だけ取る）
if BAR_STYLE == "arrows" then
  local PL = require("helpers.powerline")
  apple:set({
    padding_left = 0,
    padding_right = 0,
    icon = { font = { size = 18.0 }, color = COLORS.red, padding_left = 16, padding_right = 4 },
    background = PL.block(COLORS.bg0),
  })
  SBAR.add("item", "apple.arrow", PL.arrow(PL.R, COLORS.bg0, COLORS.bg0))
end
