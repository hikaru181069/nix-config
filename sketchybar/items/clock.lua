-- 日付と時刻（tmux やプロンプトからは時刻を外したので、ここに出す）
-- 例: 10/11 土 22:05
local colors = require("colors")
local island = require("items.island")

local weekdays = { "日", "月", "火", "水", "木", "金", "土" }

local clock = sbar.add("item", "clock", {
  position = "right",
  icon = { string = "\u{f017}", color = colors.blue, padding_left = 10 }, -- 時計のアイコン（Nerd Font）
  label = { color = colors.fg1, padding_right = 10 },
  -- 30 秒ごとに表示を更新する（分の切り替わりから最大 30 秒遅れる）
  update_freq = 30,
})

local function update()
  local now = os.date("*t")
  clock:set({
    label = string.format("%d/%d %s %02d:%02d", now.month, now.day, weekdays[now.wday], now.hour, now.min),
  })
end

clock:subscribe({ "routine", "forced", "system_woke" }, update)
update()

island("clock.island", { clock.name }, "right")
