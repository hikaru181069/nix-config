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
-- 幅だけの見えない項目。共通の見た目の余白（左右 3）が付くと、島の端がその分はみ出して隣の島と重なるので 0 にする
local function spacer(name, width)
  return SBAR.add("item", name, {
    position = "right",
    width = width,
    padding_left = 0,
    padding_right = 0,
    icon = { drawing = false },
    label = { drawing = false },
    background = { drawing = false, padding_left = 0, padding_right = 0 },
  })
end

-- 島と島の間を空ける
local gaps = 0
local function gap()
  gaps = gaps + 1
  spacer("island.gap." .. gaps, 10)
end

-- 島: add_items で項目を足し（右端から順に）、それらを角丸の背景で囲む。両端に少し余白を入れる
local function island(name, add_items)
  local pad_right = spacer(name .. ".pad_right", 6)
  local members = add_items()
  local pad_left = spacer(name .. ".pad_left", 6)
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
