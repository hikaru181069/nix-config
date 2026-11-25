-- 全体の設定（旧設定 ~/.config/sketchybar/settings.lua から、今使うものだけ持ってきた。値は同じ）

--- @type "macos_native" | "aerospace" | "yabai"
WINDOW_MANAGER = "yabai"

-- バーの見た目
-- "arrows": 左は tmux のウィンドウ一覧のように矢印でつなぎ、右は Neovim のステータスラインのように細い三角で区切る
-- "islands": 前の見た目（項目ごとの枠と、すき間）
--- @type "arrows" | "islands"
BAR_STYLE = "arrows"

-- ターミナル（Ghostty）と同じフォント。font コマンドで選んだもの（home.nix が font.lua に書き出す）
local font = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/font.lua")
FONT = {
  icon_font = font.family,
  label_font = font.family,
  -- 文字の上端〜下端の高さ（文字の大きさの何倍か）。三角の大きさの計算に使う（helpers/powerline.lua）
  line_ratio = font.lineRatio,
  style_map = {
    ["Regular"] = "Regular",
    ["Semibold"] = "SemiBold",
    ["Bold"] = "Bold",
    ["Black"] = "ExtraBold",
  },
}

SPACES = {
  --- @type "greek_uppercase" | "greek_lowercase" | nil
  ID_STYLE = nil, -- ギリシャ文字ではなく、ふつうの数字（1〜10）
  ITEM_PADDING = 12,
}

PADDINGS = 3
GROUP_PADDINGS = 5

-- 右側の項目で、設定を見るもの（旧設定と同じ値）
MODULES = {
  battery = { enable = true, style = "icon" },
}
