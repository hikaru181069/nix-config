-- 表示する項目。左側は左から順に、右側は右端から順に並ぶ
-- 左右とも旧設定（~/.config/sketchybar/items/init.lua）と同じ項目・同じ順番。色だけ palette.nix のもの
-- （右側を3つの島にまとめる形も試したが、やめて旧設定の形に戻した。docs/log.md 参照）

-- 右側の項目のまとまりの間を空ける（旧設定と同じ。見えない幅だけの項目）
-- 矢印の見た目では、Neovim のステータスラインと同じ細い三角（）で区切る。
-- フォントの記号（e0b3）は線が太い（Maple Mono NF で文字の 0.086 倍 ≒ 1.6pt）ので、Ghostty が tmux で描くのと同じ
-- 線の太さ 1pt・1文字ぶんの大きさ（幅 11・高さ 25）の画像（sep_thin_left.png）を置く。
-- 画像は home.nix がテーマの fg3 の色で作り、~/.config-nix/sketchybar に置く
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
        string = os.getenv("HOME") .. "/.config-nix/sketchybar/sep_thin_left.png",
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
-- 通信速度の左にも区切りを置く（stats を隠すと一緒に隠れる）
right_gap("stats.net_left")

-- 矢印の見た目では、右側全体の背景を左側と同じ色（bg0）にする。項目ごとではなく、まとめて1枚で囲む
-- （間の区切りや余白の項目も隙間なく塗るため）。隠した項目（stats や git）は囲みから外れ、背景もそのぶん縮む
if BAR_STYLE == "arrows" then
  local PL = require("helpers.powerline")
  SBAR.add("bracket", "right.bg", {
    "calendar",
    "battery",
    "wifi",
    "widgets.volume",
    "separator_right",
    "/rsep\\..*/",
    "git_branch",
    "widgets.cpu",
    "widgets.ram",
    "widgets.upload_speed",
    "widgets.download_speed",
  }, { background = PL.block(COLORS.bg0) })
  -- 右側の左端を、左側の終わり（front_app.end）と同じく三角で尖らせる。最後に足すので、いつも右側のいちばん左に来る
  local start = PL.arrow(PL.L, COLORS.bg0, COLORS.transparent)
  start.position = "right"
  -- 三角の平らな辺が文字の枠の右端に少し届かず、背景との間に細い隙間が見えるので、1 だけ背景に重ねる
  start.padding_right = -1
  SBAR.add("item", "right.start", start)
end
