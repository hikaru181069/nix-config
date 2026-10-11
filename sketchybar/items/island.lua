-- 項目のまとまりを、角の丸い「島」で囲む
-- 使い方: island("名前", { "項目の名前", ... }, "left" か "right")
local colors = require("colors")

return function(name, members, position)
  sbar.add("bracket", name, members, {
    background = {
      color = colors.bg0,
      border_color = colors.bg3,
      border_width = 1,
      corner_radius = 10,
      height = 30,
    },
  })
  -- 島と島の間を空ける（幅だけの見えない項目）
  sbar.add("item", name .. ".gap", {
    position = position or "left",
    width = 8,
  })
end
