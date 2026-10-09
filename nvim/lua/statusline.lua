-- ステータスライン（lualine）。見た目は旧設定のまま、色を Nightfox（palette.nix）に置き換えた
-- 左: モード | ブランチ | 変更行数 | ファイル名 | 診断　　右: ファイルの種類 | 位置（%）| 行:列
local p = require("palette")

-- Nerd Font の記号。見えない文字なので文字コードで書く
local glyph = {
  right = "\u{e0b0}", -- 右向きの三角
  right_thin = "\u{e0b1}",
  left = "\u{e0b2}", -- 左向きの三角
  left_thin = "\u{e0b3}",
}

-- モードごとの色・アイコン・1文字の名前（\22 は矩形選択の Ctrl-V）
local modes = {
  n = { color = p.fg3, icon = "\u{f0176}", name = "N" },
  i = { color = p.cyan, icon = "\u{f040}", name = "I" },
  v = { color = p.magenta, icon = "\u{f0208}", name = "V" },
  V = { color = p.magenta, icon = "\u{f0208}", name = "V" },
  ["\22"] = { color = p.magenta, icon = "\u{f0208}", name = "V" },
  c = { color = p.yellow, icon = "\u{f4b5}", name = "C" },
  R = { color = p.red, icon = "\u{f06d4}", name = "R" },
}
local function mode()
  return modes[vim.fn.mode()] or modes.n
end

-- 今のモードの色の地に、濃い文字で表示する部品
local function mode_block(component)
  return {
    component,
    color = function()
      return { fg = p.bg0, bg = mode().color, gui = "bold" }
    end,
  }
end
-- 暗い地に、灰色の文字で表示する部品
local function dim(component)
  local c = type(component) == "table" and component or { component }
  c.color = { fg = p.comment, bg = p.bg0, gui = "bold" }
  return c
end
-- 区切りの記号。color は固定の色か、モードで変わる色を返す関数
local function sep(char, color)
  return {
    function()
      return char
    end,
    color = color,
    padding = 0,
  }
end
local function mode_sep(char)
  return sep(char, function()
    return { fg = mode().color, bg = p.bg0 }
  end)
end
local thin_right = sep(glyph.right_thin, { fg = p.comment, bg = p.bg0 })
local thin_left = sep(glyph.left_thin, { fg = p.comment, bg = p.bg0 })

require("lualine").setup({
  options = {
    theme = "auto",
    component_separators = "",
    section_separators = "",
    -- ツリーと no-neck-pain の余白の下には出さない
    disabled_filetypes = { statusline = { "NvimTree", "no-neck-pain" } },
  },
  sections = {
    lualine_a = {
      mode_block(function()
        return mode().icon .. " " .. mode().name
      end),
      mode_sep(glyph.right),
    },
    lualine_b = {
      dim("branch"),
      thin_right,
      dim({
        "diff",
        symbols = { added = "\u{f0fe} ", modified = "\u{f14b} ", removed = "\u{f146} " },
      }),
      thin_right,
      dim("filename"),
      thin_right,
    },
    lualine_c = { dim("diagnostics") },
    lualine_x = { thin_left, dim("filetype") },
    lualine_y = {},
    lualine_z = {
      thin_left,
      dim("progress"),
      mode_sep(glyph.left),
      mode_block("location"),
    },
  },
})

-- ツリーのウィンドウは、lualine の代わりに出る標準のステータスラインも空にする（旧設定と同じ）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.wo.statusline = " "
  end,
})
