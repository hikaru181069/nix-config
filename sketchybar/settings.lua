-- 全体の設定（旧設定 ~/.config/sketchybar/settings.lua から、今使うものだけ持ってきた。値は同じ）

--- @type "macos_native" | "aerospace" | "yabai"
WINDOW_MANAGER = "yabai"

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
