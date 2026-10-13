-- 日付と時刻。カレンダーのアイコン + 1行（例: 10/13 22:05）
-- 参考: falleco/dotfiles の sketchybar（2026-10-13、ユーザーが選んだ）。旧設定は日付と時刻（秒まで）の2段だった
local cal = SBAR.add("item", "calendar", {
  position = "right",
  update_freq = 30,
  icon = {
    string = "\u{f073}", -- カレンダー（Nerd Font）
    color = COLORS.mauve,
  },
  label = {
    color = COLORS.subtext0,
    font = { size = 13.0 },
  },
  padding_left = 4,
  padding_right = 6,
  click_script = "open -a Calendar",
})

cal:subscribe({ "forced", "routine", "system_woke" }, function()
  cal:set({ label = { string = os.date("%m/%d %H:%M") } })
end)
