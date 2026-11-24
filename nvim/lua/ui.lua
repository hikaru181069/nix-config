-- 画面まわり（開いているファイルのタブ、コマンド入力・通知の見た目）。設定は旧設定から、色を palette.nix のものにした
local p = require("palette")
local transparent = require("theme").transparent

-- 開いているファイル（バッファ）をタブのように上に並べる
-- 旧設定の見た目に合わせ、すべての部品の背景を揃える。選んでいるタブは通常の背景（bg1）で1枚のタブに見せ、
-- ほかのタブと余白は暗い背景（bg0）にする。部品ごとに背景を指定しないと、名前だけ明るくなるなどまだらになる
local function bufferline_highlights(defaults)
  local hl = {}
  for name, attrs in pairs(defaults.highlights) do
    hl[name] = vim.tbl_extend("force", attrs, { bg = name:match("_selected$") and p.bg1 or p.bg0 })
  end
  -- 文字の色（旧設定と同じ考え方: ほかのタブは暗め、見えているタブは明るめ、変更ありは黄色）
  local fg = {
    background = p.fg3,
    buffer_visible = p.fg0,
    numbers = p.fg3,
    numbers_visible = p.fg2,
    modified = p.yellow,
    modified_visible = p.yellow,
    -- 斜めの区切りは背景と同じ色にして、選んでいるタブの形だけを見せる
    separator = p.bg0,
    separator_visible = p.bg0,
    separator_selected = p.bg1,
  }
  for name, color in pairs(fg) do
    hl[name].fg = color
  end
  -- 区切りは、暗い背景（bg0）の上にタブの色の三角を描く（下の sep_chars も参照）
  hl.separator_selected.bg = p.bg0
  -- 半透明: 選んでいるタブを本文と同じく塗らない
  if transparent then
    for name, attrs in pairs(hl) do
      if name:match("_selected$") then
        attrs.bg = "NONE"
      end
    end
  end
  return hl
end

-- 斜めの区切りの記号を裏返しにする（順番は右・左）。既定はタブの色の地に余白の色の三角で、Ghostty が上の余白を
-- マスの背景の色（タブの色）で塗るため、区切りの上だけ隙間のように見えた
require("bufferline.constants").sep_chars.slant = { "\u{e0b8}", "\u{e0ba}" }

-- 半透明: ツリーの上の見出し。色を決めないと、ツリーの背景の色になり、塗られないテーマがある
if transparent then
  vim.api.nvim_set_hl(0, "TreeHeader", { fg = p.fg1, bg = p.bg0 })
end

require("bufferline").setup({
  highlights = bufferline_highlights,
  options = {
    -- 半透明: 三角の記号は透かせず、選んでいるタブと色が合わないので、区切りのない四角いタブにする
    separator_style = transparent and { "", "" } or "slant",
    indicator = transparent and { style = "none" } or nil,
    -- LSP の診断の数をタブに出す
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    -- 半透明: 左端に暗い色のマスを1つ置く（Ghostty は左の余白を最初のマスの色で塗る。最初が塗らない区切りだと、余白だけ透ける）
    custom_areas = transparent and {
      left = function()
        return { { text = " ", link = "BufferLineFill" } }
      end,
    } or nil,
    -- ファイルツリーを開いているときは、その上を空けて見出しを出す
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = true, highlight = transparent and "TreeHeader" or nil },
    },
  },
})
-- 左の三角の隣の空白は、三角の背景（bg0）を引きついで暗い長方形に見えるので、三角の直後からタブの色にする
local bufferline = _G.nvim_bufferline
function _G.nvim_bufferline()
  return (bufferline():gsub("%%#BufferLineSeparatorSelected#\u{e0ba}", "%0%%#BufferLineBufferSelected#"))
end
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "次のバッファ" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "前のバッファ" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "バッファを閉じる" })

-- 通知を右上に出す（noice がメッセージをここに送る）
require("notify").setup({
  stages = "fade_in_slide_out",
  timeout = 1000,
  background_colour = p.bg1,
})

-- コマンド入力を画面の中央に出し、メッセージは通知にする
require("noice").setup({
  lsp = {
    -- 関数の引数の説明は blink.cmp が出すので、noice では出さない（二重になる）
    signature = { enabled = false },
  },
  cmdline = {
    view = "cmdline_popup",
    -- Nerd Font のアイコン。見えない文字なので文字コードで書く
    format = {
      cmdline = { icon = "\u{f054}" },
      search_down = { icon = "\u{f002} \u{f103}" },
      search_up = { icon = "\u{f002} \u{f102}" },
      filter = { icon = "$" },
      lua = { icon = "\u{e620}" },
      help = { icon = "\u{f128}" },
    },
  },
  messages = {
    view = "notify",
    view_error = "notify",
    view_warn = "notify",
    view_history = "messages",
    view_search = "virtualtext",
  },
  presets = {
    -- 長いメッセージは分割したウィンドウに出す
    long_message_to_split = true,
    -- ホバーなどの説明に枠を付ける
    lsp_doc_border = true,
  },
  views = {
    cmdline_popup = {
      position = { row = "40%", col = "50%" },
      size = { width = 60, height = "auto" },
      border = { style = "rounded", padding = { 0, 1 } },
    },
    popupmenu = {
      relative = "editor",
      position = { row = "48%", col = "50%" },
      size = { width = 60, height = 10 },
      border = { style = "rounded", padding = { 0, 1 } },
    },
  },
})
