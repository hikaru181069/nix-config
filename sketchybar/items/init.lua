-- 表示する項目。左側は左から順に、右側は右端から順に並ぶ
-- 左右とも旧設定（~/.config/sketchybar/items/init.lua）と同じ項目・同じ順番。色だけ palette.nix のもの
-- （右側を3つの島にまとめる形も試したが、やめて旧設定の形に戻した。docs/log.md 参照）

-- 右側の項目のまとまりの間を空ける（旧設定と同じ。見えない幅だけの項目）
-- 矢印の見た目では、Neovim のステータスラインと同じ細い三角（）で区切る。
-- フォントの記号（e0b3）は線が太い（Maple Mono NF で文字の 0.086 倍 ≒ 1.6pt）ので、Ghostty が tmux で描くのと同じ
-- 線の太さ 1pt・1文字ぶんの大きさ（幅 11・高さ 25）の画像（images/sep_thin_left.png、色は palette の fg3）を置く。
-- 画像の作り方: magick -size 22x50 xc:none -fill none -stroke '#7c6f64' -strokewidth 2 -draw "polyline 21,-1 1,25 21,51" sep_thin_left.png
-- name を付けたものは、隣の項目と一緒に隠す（items/toggle_stats/toggle_stats.lua・items/git/git.lua）
local function right_gap(name)
  if BAR_STYLE ~= "arrows" then
    SBAR.add("item", { position = "right", width = 10 })
    return
  end
  local PL = require("helpers.powerline")
  -- 幅を決めた項目には左右の余白（padding）が効かないので、見えない余白の項目ではさむ
  local function pad(suffix)
    local pad_props = { position = "right", width = 5 }
    if name then
      SBAR.add("item", "rsep." .. name .. "." .. suffix, pad_props)
    else
      SBAR.add("item", pad_props)
    end
  end
  local props = {
    position = "right",
    width = 11,
    padding_left = 0,
    padding_right = 0,
    icon = { drawing = false },
    label = { drawing = false },
    background = {
      drawing = true,
      color = COLORS.transparent,
      border_width = 0,
      height = PL.HEIGHT,
      image = {
        string = os.getenv("CONFIG_DIR") .. "/images/sep_thin_left.png",
        scale = 0.5,
        corner_radius = 0,
        border_width = 0,
      },
    },
  }
  pad("pad_r")
  if name then
    SBAR.add("item", "rsep." .. name, props)
  else
    SBAR.add("item", props)
  end
  pad("pad_l")
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
right_gap("git")
require("items.git.git")
right_gap("stats.cpu")
require("items.monitor.cpu")
right_gap("stats.mem")
require("items.monitor.mem")
right_gap("stats.net")
require("items.monitor.netspeed")
