-- メモリの使用率。アイコンと「%」だけ（前はグラフだったが、ほかの項目と形をそろえた）
-- macOS はメモリをたくさん使うのがふつうなので、赤くするのは 90% から
local ram = SBAR.add("item", "widgets.ram", {
  position = "right",
  icon = {
    string = ICONS.ram,
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

ram:subscribe({ "system_stats" }, function(env)
  local usage = tonumber(env.RAM_USAGE) or 0
  local color = usage >= 90 and COLORS.red or COLORS.subtext0
  ram:set({
    icon = { color = color },
    label = { string = string.format("%d%%", usage), color = color },
  })
end)
