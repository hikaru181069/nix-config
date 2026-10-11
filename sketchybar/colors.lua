-- 色。palette.nix から作られた palette.lua（home.nix が ~/.config-nix/sketchybar に置く）を読み、
-- sketchybar の書き方（0xAARRGGBB の数）に直す
--
-- 旧設定（~/.config/sketchybar）から持ってきた項目は Catppuccin Mocha の色の名前（subtext0 など）を使っている。
-- コードはそのままにして色だけ変えるため、Catppuccin の名前に、同じ役割の Nightfox の色を割り当てる
-- （tmux のステータスラインと同じ対応）
local palette = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/palette.lua")

local function color(hex)
  return tonumber("0xff" .. hex:sub(2))
end

local colors = {}
for name, hex in pairs(palette) do
  colors[name] = color(hex)
end

local catppuccin = {
  -- 文字（明るい順）
  text = palette.fg0,
  subtext1 = palette.fg1,
  subtext0 = palette.fg2,
  overlay2 = palette.fg2,
  overlay1 = palette.comment,
  overlay0 = palette.fg3,
  grey = palette.fg3,
  -- 背景・枠（明るい順）
  surface2 = palette.sel1,
  surface1 = palette.bg4,
  surface0 = palette.bg3,
  base = palette.bg1,
  mantle = palette.bg0,
  crust = palette.bg0,
  -- 色
  rosewater = palette.pink,
  flamingo = palette.pink,
  pink = palette.pink,
  mauve = palette.magenta,
  red = palette.red,
  maroon = palette.red,
  peach = palette.orange,
  yellow = palette.yellow,
  green = palette.green,
  teal = palette.cyan,
  sky = palette.cyan,
  sapphire = palette.blue,
  blue = palette.blue,
  lavender = palette.blue,
}
for name, hex in pairs(catppuccin) do
  colors[name] = color(hex)
end

colors.transparent = 0x00000000

-- 透明度を付けた色を作る（alpha は 0〜1。範囲外なら元の色のまま。旧設定と同じ）
function colors.with_alpha(c, alpha)
  if alpha > 1.0 or alpha < 0.0 then
    return c
  end
  return (c & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
end

return colors
