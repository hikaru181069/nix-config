-- 画面まわり（開いているファイルのタブ、コマンド入力・通知の見た目）。設定は旧設定から、色を Nightfox にした
local p = require("palette")

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
    -- 斜めの区切りは背景と同じ色にして、タブの形だけを見せる
    separator = p.bg0,
    separator_visible = p.bg0,
    separator_selected = p.bg0,
  }
  for name, color in pairs(fg) do
    hl[name].fg = color
  end
  return hl
end

require("bufferline").setup({
  highlights = bufferline_highlights,
  options = {
    separator_style = "slant",
    -- LSP の診断の数をタブに出す
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    -- ファイルツリーを開いているときは、その上を空けて見出しを出す
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = true },
    },
  },
})
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
