-- 画面まわり（開いているファイルのタブ、コマンド入力・通知の見た目）。設定は旧設定から、色を palette.nix のものにした
local p = require("palette")
local transparent = require("theme").transparent

-- 開いているファイル（バッファ）をタブのように上に並べる
-- 旧設定の見た目に合わせ、すべての部品の背景を揃える。選んでいるタブは通常の背景（bg）で1枚のタブに見せ、
-- ほかのタブと余白は暗い背景（bg_bar）にする。部品ごとに背景を指定しないと、名前だけ明るくなるなどまだらになる
local function bufferline_highlights(defaults)
  local hl = {}
  for name, attrs in pairs(defaults.highlights) do
    hl[name] = vim.tbl_extend("force", attrs, { bg = name:match("_selected$") and p.bg or p.bg_bar })
  end
  -- 文字の色（旧設定と同じ考え方: ほかのタブは暗め、見えているタブは明るめ、変更ありは黄色）
  -- ほかのタブの名前と番号は tab_inactive_fg（palette.nix。テーマが darkenBarInactive のときは、ほかの「選んでいないもの」と同じだけ暗い）
  local fg = {
    background = p.tab_inactive_fg,
    buffer_visible = p.fg_bright,
    -- 選んでいるタブの名前は、sketchybar の右側・tmux の5つのアイコン（入っているとき）と同じ情報の文字の色
    buffer_selected = p.text_fg_dim,
    numbers = p.tab_inactive_fg,
    numbers_visible = p.fg_dim,
    modified = p.yellow,
    modified_visible = p.yellow,
    -- 斜めの区切りは余白と同じ色にして、選んでいるタブの形だけを見せる
    separator = p.bg_bar,
    separator_visible = p.bg_bar,
    separator_selected = p.bg_bar,
  }
  for name, color in pairs(fg) do
    hl[name].fg = color
  end
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

-- 半透明: ツリーの上の見出し。色を決めないと、ツリーの背景の色になり、塗られないテーマがある
if transparent then
  vim.api.nvim_set_hl(0, "TreeHeader", { fg = p.fg, bg = p.bg_bar })
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
    -- 左端に余白と同じ暗い色のマスを1つ置く。Ghostty は左の余白を最初のマスの色で塗るので、ないと余白にタブの色の四角が出る
    custom_areas = {
      left = function()
        return { { text = " ", link = "BufferLineFill" } }
      end,
    },
    -- ファイルツリーを開いているときは、その上を空けて見出しを出す
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = " ", highlight = transparent and "TreeHeader" or nil },
    },
  },
})
-- ほかのタブの、ファイルの種類のアイコン（色付き）を暗くする（palette.nix の tab_inactive_darken。0 なら何もしない）
-- bufferline は種類ごとに BufferLineDevIcon<種類>（ほかのタブ用）と …Selected（選んでいるタブ用）を作るので、
-- ほかのタブ用の色を、元の色からバーの地に寄せた色に置きかえる。新しい種類のファイルを開くと作られるので、そのたびに付け直す
if (p.tab_inactive_darken or 0) > 0 then
  local original = {} -- 置きかえる前の色（何度も暗くしないように覚えておく）
  local function mix(a, b, t)
    local out = 0
    for shift = 16, 0, -8 do
      local x, y = math.floor(a / 2 ^ shift) % 256, math.floor(b / 2 ^ shift) % 256
      out = out + math.floor(x + (y - x) * t + 0.5) * 2 ^ shift
    end
    return out
  end
  local bar = tonumber(p.bg_bar:sub(2), 16)
  local function darken_icons()
    for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
      if name:match("^BufferLineDevIcon") and not name:match("Selected$") and hl.fg then
        original[name] = original[name] or hl.fg
        local fg = mix(original[name], bar, p.tab_inactive_darken)
        if hl.fg ~= fg then
          hl.fg = fg
          -- bufferline は「既定の色」（default）として登録しているので、その印を外して上書きする（付いたままだと上書きされない）
          hl.default = nil
          vim.api.nvim_set_hl(0, name, hl)
        end
      end
    end
  end
  vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufWinEnter" }, { callback = vim.schedule_wrap(darken_icons) })
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      original = {} -- テーマを読みこみ直すと元の色も作り直されるので、覚えた色を捨てる
      vim.schedule(darken_icons)
    end,
  })
end

vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "次のバッファ" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "前のバッファ" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "バッファを閉じる" })

-- 通知を右上に出す（noice がメッセージをここに送る）
require("notify").setup({
  stages = "fade_in_slide_out",
  timeout = 1000,
  background_colour = p.bg,
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
