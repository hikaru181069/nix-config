-- 矢印の見た目（BAR_STYLE = "arrows"）で使う部品。tmux のステータスラインと同じく、Nerd Font の三角の記号を
-- 「文字の色 = 前の区切りの色、背景 = 次の区切りの色」で置いて、区切りどうしを矢印でつなぐ
local M = {}

M.R = "\u{e0b0}" -- 右向きの三角（塗り）
M.R_THIN = "\u{e0b1}" -- 右向きの三角（線だけ）
M.L_THIN = "\u{e0b3}" -- 左向きの三角（線だけ）

-- 区切りの高さ。三角の記号の高さをこれにぴったり合わせる
-- tmux のステータスライン（ターミナルの1行）と同じ高さにする: Ghostty の font-size 18.5 × 1.32 = 24.42 を
-- Ghostty が Retina の点に丸めて 24.5。sketchybar の高さは整数なので 25
M.HEIGHT = 25
-- Maple Mono NF の三角は、文字の上端（ascent 1020）から下端（descent 300）まで、ちょうど 1.32 文字ぶんの高さ。
-- sketchybar は文字をこの上端〜下端の真ん中で縦にそろえるので、大きさを 高さ ÷ 1.32 にすると背景と同じ高さになる
M.FONT_SIZE = M.HEIGHT / 1.32

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

-- 三角だけの項目の設定。fg が三角の色（前の区切りの色）、bg が背景（次の区切りの色）
-- space 型の項目は選ばれると自動で highlight_color に変わるので、両方を同じ色にしておく
function M.arrow(glyph, fg, bg)
  return {
    padding_left = 0,
    padding_right = 0,
    icon = {
      string = glyph,
      color = fg,
      highlight_color = fg,
      font = { family = FONT.icon_font, style = FONT.style_map["Regular"], size = M.FONT_SIZE },
      padding_left = 0,
      padding_right = 0,
      y_offset = 0,
    },
    label = { drawing = false },
    background = M.block(bg),
  }
end

return M
