-- 表示する項目。左側は左から順に、右側は右端から順に並ぶ
-- 左右とも旧設定（~/.config/sketchybar/items/init.lua）と同じ項目・同じ順番。色だけ Nightfox

-- 右側の項目のまとまりの間を空ける（旧設定と同じ。見えない幅だけの項目）
local function right_gap()
  SBAR.add("item", { position = "right", width = 10 })
end

-- 左
require("items.logo.apple")
require("items.menus.menus")
require("items.spaces.spaces")
require("items.front_app.front_app")

-- 右
require("items.calendar.calendar")
right_gap()
require("items.battery.battery")
right_gap()
require("items.monitor.wifi")
right_gap()
require("items.volume.volume")
right_gap()
require("items.toggle_stats.toggle_stats")
right_gap()
require("items.docker.docker")
right_gap()
require("items.git.git")
right_gap()
require("items.monitor.cpu")
right_gap()
require("items.monitor.mem")
right_gap()
require("items.monitor.netspeed")
