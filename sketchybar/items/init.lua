-- 表示する項目。左側は左から順に、右側は右端から順に並ぶ
-- 左側は旧設定（~/.config/sketchybar/items/init.lua）と同じ項目・同じ順番。色だけ palette.nix のもの
-- 右側は、旧設定の項目を3つの島にまとめた（2026-10-11、ユーザーが見比べて選んだ B2）:
--   [開発: git ブランチ・Docker]  [統計: 切り替え・CPU・メモリ・通信量]  [いつも見るもの: 音量・Wi-Fi・電池・日付と時刻]

-- 左
require("items.logo.apple")
require("items.menus.menus")
require("items.spaces.spaces")
require("items.front_app.front_app")

-- 右
-- 島と島の間を空ける（見えない幅だけの項目）
local function gap()
  SBAR.add("item", { position = "right", width = 10 })
end

-- 島: add_items で項目を足し（右端から順に）、それらを角丸の背景で囲む。両端に少し余白を入れる
local function island(name, add_items)
  local pad_right = SBAR.add("item", name .. ".pad_right", { position = "right", width = 4 })
  local members = add_items()
  local pad_left = SBAR.add("item", name .. ".pad_left", { position = "right", width = 4 })
  table.insert(members, 1, pad_right.name)
  table.insert(members, pad_left.name)
  SBAR.add("bracket", name, members, {
    background = {
      color = COLORS.bg0,
      border_color = COLORS.bg3,
      border_width = 1,
      corner_radius = 10,
      height = 32,
    },
  })
end

island("island.always", function()
  require("items.calendar.calendar")
  require("items.battery.battery")
  require("items.monitor.wifi")
  require("items.volume.volume")
  return { "calendar.date", "calendar.time", "battery", "wifi", "widgets.volume" }
end)
gap()
island("island.stats", function()
  require("items.monitor.netspeed")
  require("items.monitor.mem")
  require("items.monitor.cpu")
  require("items.toggle_stats.toggle_stats")
  return { "widgets.download_speed", "widgets.upload_speed", "widgets.ram", "widgets.cpu", "separator_right" }
end)
gap()
island("island.dev", function()
  require("items.docker.docker")
  require("items.git.git")
  return { "docker", "git_branch" }
end)
