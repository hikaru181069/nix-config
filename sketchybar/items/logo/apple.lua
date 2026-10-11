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
