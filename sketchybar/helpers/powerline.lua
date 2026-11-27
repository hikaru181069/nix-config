-- 矢印の見た目（BAR_STYLE = "arrows"）で使う部品。tmux のステータスラインと同じく、Nerd Font の三角の記号を
-- 「文字の色 = 前の区切りの色、背景 = 次の区切りの色」で置いて、区切りどうしを矢印でつなぐ
local M = {}

M.R = "\u{e0b0}" -- 右向きの三角（塗り）
M.R_THIN = "\u{e0b1}" -- 右向きの三角（線だけ）
M.L = "\u{e0b2}" -- 左向きの三角（塗り）
M.L_THIN = "\u{e0b3}" -- 左向きの三角（線だけ）

-- 区切りの高さ。三角の記号の高さをこれにぴったり合わせる
-- tmux のステータスライン（ターミナルの1行）と同じ高さにする: Ghostty の font-size 18.5 × 1.32 = 24.42 を
-- Ghostty が Retina の点に丸めて 24.5。sketchybar の高さは整数なので 25
M.HEIGHT = 25
-- Nerd Font の三角の実際の高さは、文字の大きさの arrow_ratio 倍（fonts.nix で測った値）。大きさを 高さ ÷ arrow_ratio にすると、
-- 三角がちょうど背景と同じ高さになる。sketchybar は文字を上端〜下端の真ん中で縦にそろえ、三角の真ん中もそこにあるので、上下にはみ出さない
-- （前は line_ratio で割っていて、Lilex などは三角が背景より約 0.3pt 大きく、下にはみ出して見えた）
M.FONT_SIZE = M.HEIGHT / FONT.arrow_ratio

-- 区切りの背景（角を丸めず、枠もなし。隣と隙間なくつながるように）
function M.block(color)
  return {
    drawing = true,
    color = color,
    height = M.HEIGHT,
    corner_radius = 0,
    border_width = 0,
  }
end

-- 塗りの三角の画像（home.nix が palette のすべての色で作る。ファイル名は 向き_色の16進.png）
-- 文字の三角は sketchybar が背景より約 0.75pt 下に描き、帯からはみ出す（位置は 1pt 単位でしか動かせない）ので、画像で描く
local ARROW_DIR = os.getenv("HOME") .. "/.config-nix/sketchybar/arrows/"
local DIRECTION = { [M.R] = "R", [M.L] = "L" }
M.ARROW_WIDTH = 13 -- 画像の三角の幅（文字の三角と同じ）

-- 三角の画像の場所。塗りの三角でないとき（線だけの三角）や、色の画像が無いとき（透明など）は nil
local function arrow_image(glyph, color)
  if not DIRECTION[glyph] then
    return nil
  end
  local path = ARROW_DIR .. DIRECTION[glyph] .. "_" .. string.format("%06x", color & 0xffffff) .. ".png"
  local file = io.open(path, "r")
  if not file then
    return nil
  end
  file:close()
  return path
end

-- 三角の色と形を変えるときの設定（項目を作るときと、色を変えるときの両方で使う）。画像があれば画像、なければ文字で描く
function M.arrow_state(glyph, fg, bg)
  local image = arrow_image(glyph, fg)
  if image then
    return {
      width = M.ARROW_WIDTH,
      icon = { drawing = false, string = glyph, color = fg, highlight_color = fg },
      background = { color = bg, image = { drawing = true, string = image, scale = 0.5 } },
    }
  end
  return {
    width = "dynamic",
    icon = { drawing = true, string = glyph, color = fg, highlight_color = fg },
    background = { color = bg, image = { drawing = false } },
  }
end

-- 三角だけの項目の設定。fg が三角の色（前の区切りの色）、bg が背景（次の区切りの色）
-- space 型の項目は選ばれると自動で highlight_color に変わるので、両方を同じ色にしておく
function M.arrow(glyph, fg, bg)
  local state = M.arrow_state(glyph, fg, bg)
  return {
    padding_left = 0,
    padding_right = 0,
    width = state.width,
    icon = {
      drawing = state.icon.drawing,
      string = glyph,
      color = fg,
      highlight_color = fg,
      font = { family = FONT.icon_font, style = FONT.style_map["Regular"], size = M.FONT_SIZE },
      padding_left = 0,
      padding_right = 0,
      y_offset = 0,
    },
    label = { drawing = false },
    background = {
      drawing = true,
      color = bg,
      height = M.HEIGHT,
      corner_radius = 0,
      border_width = 0,
      image = { drawing = state.background.image.drawing, string = state.background.image.string or "", scale = 0.5, corner_radius = 0, border_width = 0 },
    },
  }
end

return M
