-- CPU の使用率。アイコンと「%」だけ（前はグラフだったが、ほかの項目と形をそろえた）
-- ふだんは文字と同じ色で、使いすぎのときだけ赤くする
local cpu = SBAR.add("item", "widgets.cpu", {
  position = "right",
  icon = {
    string = ICONS.cpu,
    color = COLORS.subtext0,
    font = { size = 16.0 },
  },
  label = {
    string = "??%",
    color = COLORS.subtext0,
    font = { size = 13.0 },
    -- 文字の欄の幅を決めて右に寄せる（桁数で幅が変わると、左の項目が動くので）。いちばん長い「100%」が入る幅
    -- このフォントの1文字の幅は大きさ × 0.6（13 で 7.8）。4文字 + 左右の余白 3 ずつ = 37.2
    width = 38,
    align = "right",
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
