-- CPU の使用率。アイコンと「%」だけ（前はグラフだったが、ほかの項目と形をそろえた）
-- ふだんは文字と同じ色で、使いすぎのときだけ赤くする
local cpu = SBAR.add("item", "widgets.cpu", {
  position = "right",
  icon = {
    string = ICONS.cpu,
    color = COLORS.subtext0,
    font = { size = 15.0 },
  },
  label = {
    string = "??%",
    color = COLORS.subtext0,
    font = { size = 13.0 },
  },
  padding_right = PADDINGS,
})

cpu:subscribe({ "system_stats" }, function(env)
  local usage = tonumber(env.CPU_USAGE) or 0
  local color = usage >= 80 and COLORS.red or COLORS.subtext0
  cpu:set({
    icon = { color = color },
    label = { string = string.format("%d%%", usage), color = color },
  })
end)

cpu:subscribe("mouse.clicked", function(env)
  SBAR.exec("open -a 'Activity Monitor'")
end)
