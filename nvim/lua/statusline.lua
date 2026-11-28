-- ステータスライン（lualine）
-- 左: モード | ブランチ | 変更行数 | ファイル名 | 診断　　右: ファイルの種類 | 位置（%）| 行:列
local p = require("palette")

-- バー全体の色（両端のブロック以外）。fg は細い区切りと、選んでいないウィンドウの文字の色
-- 3つのバー（Neovim・tmux・sketchybar）で同じ決まり: 区切りと選んでいないものは comment、情報の文字とアイコンは fg_dim
local bar = { fg = p.text_comment, bg = p.bg_bar }

-- モードごとの名前とブロックの色（隣の三角も同じ色。tmux のセッション名・ユーザー名の三角と同じ）
-- 名前は、モードが変わっても幅が変わらないよう3文字にそろえる
-- ノーマル（と TER）は、tmux のユーザー名・sketchybar の今のアプリの帯と同じ fg_dim（灰色の地に暗い太字）
local normal = { name = "NOR", block = p.block_fg_dim } -- fg_dim をバーの地に寄せて暗くした色（palette.nix）
local function mode(name, color)
  return { name = name, block = color }
end
local modes = {
  n = normal,
  i = mode("INS", p.cyan),
  v = mode("VIS", p.magenta),
  V = mode("VLN", p.magenta), -- 行の選択
  ["\22"] = mode("VBL", p.magenta), -- 矩形の選択（Ctrl-V）
  c = mode("CMD", p.yellow),
  R = mode("REP", p.red),
  t = { name = "TER", block = normal.block },
}
local function current()
  return modes[vim.fn.mode()] or normal
end

-- 部品: モードの色のブロック（両端）。right は右の空き（マスの数）
local function block(component, right)
  return {
    component,
    color = function()
      return { fg = p.bg_bar, bg = current().block, gui = "bold" }
    end,
    padding = { left = 1, right = right or 1 },
  }
end

-- 部品: ブロックの隣の三角
local function arrow(glyph)
  return {
    function()
      return glyph
    end,
    color = function()
      return { fg = current().block, bg = p.bg_bar }
    end,
    padding = 0,
  }
end

-- 部品: バーの上の文字（ふつうの太さ。太字は両端のモードと行:列のブロックだけ）
local function text(component, options)
  return vim.tbl_extend("force", { component, color = { fg = p.text_fg_dim, bg = bar.bg }, padding = 1 }, options or {})
end

-- 部品: 細い区切り。left は左の空き（マスの数）。cond は出す条件（隣に中身があるときだけ出し、端に浮いた区切りを残さない）
local function separator(glyph, left, cond)
  return {
    function()
      return glyph
    end,
    color = { fg = p.block_comment, bg = bar.bg }, -- comment をバーの地に寄せて暗くした色（palette.nix。tmux・sketchybar の区切りと同じ）
    padding = { left = left or 0, right = 0 },
    cond = cond,
  }
end

-- 変更行数は gitsigns（行の左の変更の印）の数を使う（区切りを出す条件と、表示をそろえるため）
local function git_diff()
  local g = vim.b.gitsigns_status_dict
  if g then
    return { added = g.added, modified = g.changed, removed = g.removed }
  end
end
local function has_branch()
  return (vim.b.gitsigns_head or "") ~= ""
end
local function has_diff()
  local d = git_diff()
  return d ~= nil and ((d.added or 0) + (d.modified or 0) + (d.removed or 0)) > 0
end
local function has_diagnostics()
  return #vim.diagnostic.get(0) > 0
end
local function has_filetype()
  return vim.bo.filetype ~= ""
end

-- Nerd Font の記号（見えない文字なので文字コードで書く）
local RIGHT, RIGHT_THIN = "\u{e0b0}", "\u{e0b1}"
local LEFT, LEFT_THIN = "\u{e0b2}", "\u{e0b3}"

-- 部品のない真ん中と、選んでいないウィンドウも同じ色にして、1本のバーに見せる
local section = { a = bar, b = bar, c = bar }

require("lualine").setup({
  options = {
    theme = { normal = section, inactive = section },
    component_separators = "",
    section_separators = "",
    globalstatus = false,
    -- ツリーと no-neck-pain の余白の下には出さない
    disabled_filetypes = { statusline = { "NvimTree", "no-neck-pain" } },
  },
  sections = {
    lualine_a = {
      block(function()
        return (" %s "):format(current().name)
      end),
      arrow(RIGHT),
    },
    lualine_b = {
      text("branch"),
      separator(RIGHT_THIN, nil, has_branch),
      text("diff", { source = git_diff, symbols = { added = "\u{f0fe} ", modified = "\u{f14b} ", removed = "\u{f146} " } }),
      separator(RIGHT_THIN, nil, has_diff),
      text("filename"),
      separator(RIGHT_THIN, nil, has_diagnostics),
    },
    lualine_c = { text("diagnostics") },
    -- ファイルの種類のアイコンは種類ごとの色（タブの行やツリーのアイコンと同じ）。文字は fg_dim
    -- 右のかたまりの左端には区切りを置かない（tmux・sketchybar の右側と同じ）
    lualine_x = { text("filetype") },
    lualine_y = { separator(LEFT_THIN, 1, has_filetype) },
    lualine_z = {
      text("progress"),
      arrow(LEFT),
      -- 右の空きは1マス少なくする（画面の右端では、Ghostty の余白も同じ色で塗られて右だけ長く見える）
      block("location", 0),
    },
  },
})

-- ツリーのウィンドウは、lualine の代わりに出る標準のステータスラインも空にする
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.wo.statusline = " "
  end,
})

-- lualine が描かない部分（左右の分割の境目の真下の1マスと、ツリーの下の帯）も、バーの色にする
-- 決めないと標準のステータスラインの色が見える（GitHub テーマでは青）。ツリーの下は lualine が lualine_transparent の色で塗る
local function fill_statusline()
  for _, name in ipairs({ "StatusLine", "StatusLineNC", "NvimTreeStatusLine", "NvimTreeStatusLineNC", "lualine_transparent" }) do
    vim.api.nvim_set_hl(0, name, bar)
  end
end
fill_statusline()
vim.api.nvim_create_autocmd("ColorScheme", { callback = vim.schedule_wrap(fill_statusline) })
