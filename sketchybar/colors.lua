-- 色。palette.nix から作られた palette.lua（home.nix が ~/.config-nix/sketchybar に置く）を読み、
-- sketchybar の書き方（0xAARRGGBB の数）に直す
local palette = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/palette.lua")

local colors = {}
for name, hex in pairs(palette) do
  colors[name] = tonumber("0xff" .. hex:sub(2))
end

colors.transparent = 0x00000000

-- 透明度を付けた色を作る（alpha は 0〜1）
function colors.with_alpha(color, alpha)
  return (color & 0x00ffffff) | (math.floor(alpha * 255) << 24)
end

return colors
