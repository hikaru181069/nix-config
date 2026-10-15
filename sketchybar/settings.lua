-- 全体の設定（旧設定 ~/.config/sketchybar/settings.lua から、今使うものだけ持ってきた。値は同じ）

--- @type "macos_native" | "aerospace" | "yabai"
WINDOW_MANAGER = "yabai"

-- バーの見た目
-- "arrows": 左は tmux のウィンドウ一覧のように矢印でつなぎ、右は Neovim のステータスラインのように細い三角で区切る
-- "islands": 前の見た目（項目ごとの枠と、すき間）
--- @type "arrows" | "islands"
BAR_STYLE = "arrows"

FONT = {
  icon_font = "Maple Mono NF",
  label_font = "Maple Mono NF",
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
