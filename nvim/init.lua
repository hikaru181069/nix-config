-- Neovim の設定。素の状態から始め、不便を感じたものだけ足す（足した理由をコメントに残す）
-- このファイルは ~/nix-config/nvim にあり、~/.config-nix/nvim-nix からリンクしている（編集するとすぐ反映される）

vim.g.mapleader = " "

-- 標準のファイル一覧（netrw）は使わず nvim-tree に任せる。起動の早い段階で止めないと両方が動いてしまう
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 表示
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
-- 診断や git の印が出たり消えたりしても、本文が左右にずれないようにする
vim.o.signcolumn = "yes"
-- ファイルの終わりより下に出る ~ を消す
vim.opt.fillchars = { eob = " " }

-- インデントは2スペース
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- ヤンクとペーストを macOS のクリップボードと共有する
vim.o.clipboard = "unnamedplus"

vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<cr>", { desc = "検索のハイライトを消す" })

-- プラグインは Neovim 標準の vim.pack で入れる。版はこのディレクトリの nvim-pack-lock.json に記録される
vim.pack.add({
  -- 配色（tmux・Ghostty などと揃える）
  "https://github.com/ellisonleao/gruvbox.nvim",
  -- C-hjkl で Neovim の分割と tmux のペインを区別なく移動（tmux 側にも同じプラグインがある）
  "https://github.com/christoomey/vim-tmux-navigator",
  -- ファイル・文字列・バッファなどを絞り込んで探す（plenary は telescope が使う部品）
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  -- 各言語サーバーの起動方法（コマンド・対象のファイル・ルートの探し方）の定義集
  "https://github.com/neovim/nvim-lspconfig",
  -- 各言語のスニペット集（VS Code 形式。blink.cmp が読む）
  "https://github.com/rafamadriz/friendly-snippets",
  -- ファイルツリー（devicons はファイルの種類のアイコン）
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-tree/nvim-tree.lua",
  -- 保存時の整形（prettier・ruff・stylua を呼ぶ）
  "https://github.com/stevearc/conform.nvim",
  -- 行の左に git の変更を表示し、変更のかたまり（hunk）単位で操作する
  "https://github.com/lewis6991/gitsigns.nvim",
  -- ステータスライン
  "https://github.com/nvim-lualine/lualine.nvim",
  -- 括弧や引用符を自動で閉じる
  "https://github.com/windwp/nvim-autopairs",
  -- 開いているファイルのタブ表示
  "https://github.com/akinsho/bufferline.nvim",
  -- コマンド入力・メッセージ・通知の見た目（nui は noice が使う部品）
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/rcarriga/nvim-notify",
  "https://github.com/folke/noice.nvim",
  -- <space> などを押して少し待つと、続けて押せるキーの一覧を出す
  "https://github.com/folke/which-key.nvim",
  -- 診断・参照・シンボルの一覧
  "https://github.com/folke/trouble.nvim",
  -- Neovim の中で lazygit を開く
  "https://github.com/kdheepak/lazygit.nvim",
  -- インデントの縦線（snacks.nvim のうち indent だけ使う）
  "https://github.com/folke/snacks.nvim",
  -- 画面上部に、今いる関数やクラスの見出しを出す
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  -- #ff0000 などの色コードをその色で表示し、色を選んで書き換える
  "https://github.com/uga-rosa/ccc.nvim",
  -- 集中モード（zen-mode は1つのウィンドウを中央に大きく、no-neck-pain は左右に余白を足して中央に寄せる）
  "https://github.com/folke/zen-mode.nvim",
  "https://github.com/shortcuts/no-neck-pain.nvim",
  -- HTML・JSX のタグを自動で閉じ、開きタグを書き換えると閉じタグも揃える
  "https://github.com/windwp/nvim-ts-autotag",
})

-- Gruvbox の背景を暗いほう（hard）にする（Ghostty の Gruvbox Dark Hard と同じ背景 #1d2021）
-- 左端の列（git や診断の印が出る列）と、その上の印の背景を、Gruvbox の既定（本文より明るい色）から本文と同じ色にする
local body = require("palette").bg1
local same_as_body = { bg = body }
require("gruvbox").setup({
  contrast = "hard",
  overrides = {
    SignColumn = same_as_body,
    FoldColumn = same_as_body,
    GruvboxRedSign = same_as_body,
    GruvboxGreenSign = same_as_body,
    GruvboxYellowSign = same_as_body,
    GruvboxBlueSign = same_as_body,
    GruvboxPurpleSign = same_as_body,
    GruvboxAquaSign = same_as_body,
    GruvboxOrangeSign = same_as_body,
    -- カーソル行は、左端もカーソル行の色にして帯が途切れないようにする
    CursorLineSign = { bg = require("palette").bg3 },
  },
})
vim.cmd.colorscheme("gruvbox")

-- telescope: 入力欄を上に置き、結果も上から並べる（旧設定と同じ）
require("telescope").setup({
  defaults = {
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
  },
  pickers = {
    -- シェルの fzf（Ctrl-T）と同じく、隠しファイルは出し、.git の中と .gitignore にあるものは出さない
    find_files = {
      find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
    },
  },
})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "ファイルを探す" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "文字列で探す（ripgrep）" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "開いているバッファ" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "ヘルプ" })

-- ファイルツリー（旧設定と同じく右側、幅 25、中身が1つだけのフォルダはまとめて1行にする）
require("nvim-tree").setup({
  view = { width = 25, side = "right" },
  renderer = { group_empty = true },
})
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "ファイルツリーを開閉" })

-- ステータスライン（長いので lua/statusline.lua に分けた）
require("statusline")

-- 保存時に整形する。整形ツールのない言語は LSP の整形を使う
require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },
    python = { "ruff_format" },
    lua = { "stylua" },
  },
  format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
})
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "整形" })

-- git の変更の表示（記号は旧設定と同じ。追加・変更は細い縦線、削除は三角）
local bar, deleted = "\u{258e}", "\u{f0da}"
local git_signs = {
  add = { text = bar },
  change = { text = bar },
  delete = { text = deleted },
  topdelete = { text = deleted },
  changedelete = { text = bar },
  untracked = { text = bar },
}
require("gitsigns").setup({
  signs = git_signs,
  signs_staged = git_signs,
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end
    map("]h", function() gs.nav_hunk("next") end, "次の変更へ")
    map("[h", function() gs.nav_hunk("prev") end, "前の変更へ")
    -- ステージ済みの変更でもう一度押すと、ステージを取り消す（旧設定の <leader>hu の代わり）
    map("<leader>hs", gs.stage_hunk, "変更をステージ / 取り消し")
    map("<leader>hr", gs.reset_hunk, "変更を元に戻す")
    map("<leader>hS", gs.stage_buffer, "ファイル全体をステージ")
    map("<leader>hR", gs.reset_buffer, "ファイル全体を元に戻す")
    map("<leader>hp", gs.preview_hunk, "変更の中身を見る")
    map("<leader>hb", function() gs.blame_line({ full = true }) end, "この行を最後に変えたコミット")
    map("<leader>hd", gs.diffthis, "差分を並べて見る")
    map("<leader>hD", function() gs.diffthis("~") end, "1つ前のコミットとの差分を見る")
  end,
})

-- 括弧や引用符を自動で閉じる
-- （旧設定の check_ts は、今の nvim-treesitter では文字列の中でも閉じてしまい効いていなかったので外した）
require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})

-- タブ表示・コマンド入力・通知（長いので lua/ui.lua に分けた）
require("ui")

-- キーの一覧（旧設定と同じく、少し待つと出る）
require("which-key").setup({ preset = "modern", delay = 300 })
require("which-key").add({
  { "<leader>f", group = "探す" },
  { "<leader>x", group = "診断" },
  { "<leader>h", group = "git の変更" },
  { "<leader>g", group = "git" },
  { "<leader>c", group = "コード" },
  { "<leader>b", group = "バッファ" },
  { "<leader>t", group = "表示" },
})

-- 診断・参照・シンボルの一覧（旧設定と同じく右側に出し、選ぶと中身を見せる）
require("trouble").setup({
  focus = true,
  win = { position = "right", size = 40 },
  auto_preview = true,
})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "診断の一覧" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "このファイルの診断" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "シンボルの一覧" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false<cr>", { desc = "定義・参照の一覧" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "ロケーションリスト" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "quickfix リスト" })

-- lazygit（シェルと同じ Nix 版。diff は delta で出る）。fugitive は計画どおり使わない
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "lazygit" })
vim.keymap.set("n", "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", { desc = "このファイルの lazygit" })

-- インデントの縦線。今いるかたまり（関数など）の線は目立たせる
require("snacks").setup({
  indent = { enabled = true, animate = { enabled = false }, scope = { enabled = true } },
})

-- 今いる関数などの見出しを上に出す（旧設定と同じく最大3行、低いウィンドウでは出さない）
require("treesitter-context").setup({
  max_lines = 3,
  min_window_height = 20,
  multiline_threshold = 5,
})

-- 色コードの表示（LSP が返す色も含む）。<space>cp で色を選ぶ
require("ccc").setup({ highlighter = { auto_enable = true, lsp = true } })
vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<cr>", { desc = "色を選ぶ" })
-- Neovim 0.12 から LSP の色の表示が標準で付いたが、ccc と二重になるので止める
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.document_color.enable(false, { bufnr = args.buf })
  end,
})

-- 集中モード（設定は旧設定と同じ。twilight は計画どおり使わない）
require("zen-mode").setup({
  window = {
    backdrop = 0.9,
    width = 95,
    height = 1,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      cursorline = false,
      cursorcolumn = false,
      foldcolumn = "0",
      list = false,
    },
  },
  plugins = {
    options = { enabled = true, ruler = false, showcmd = false },
    twilight = { enabled = false },
  },
})
vim.keymap.set("n", "<leader>tz", "<cmd>ZenMode<cr>", { desc = "集中モード（zen-mode）" })

local palette = require("palette")
vim.api.nvim_set_hl(0, "NoNeckPainBg", { bg = palette.bg0 })
require("no-neck-pain").setup({
  width = 110,
  buffers = {
    colors = { background = palette.bg0, blend = 0 },
    bo = { filetype = "no-neck-pain" },
    wo = { winfixwidth = true, winhighlight = "Normal:NoNeckPainBg,EndOfBuffer:NoNeckPainBg" },
  },
})
vim.keymap.set("n", "<leader>tn", "<cmd>NoNeckPain<cr>", { desc = "中央に寄せる（no-neck-pain）" })

-- 浮かぶウィンドウ（ホバー・診断の詳細など）を角の丸い枠で囲む
vim.o.winborder = "rounded"

-- 診断（エラー・警告）の表示。行末への文字表示は既定で出ないので、印と下線で示す
vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      -- Nerd Font のアイコン。見えない文字なので文字コードで書く
      [vim.diagnostic.severity.ERROR] = "\u{f057}",
      [vim.diagnostic.severity.WARN] = "\u{f071}",
      [vim.diagnostic.severity.INFO] = "\u{f05a}",
      [vim.diagnostic.severity.HINT] = "\u{f0335}",
    },
  },
  float = { source = true },
})

-- LSP のキー。Neovim 0.11 から次は最初から使える（旧設定の gr / gi / <leader>rn / <leader>ca などは、これに置き換え）
--   K 説明 / grn 名前の変更 / gra コードアクション / grr 参照 / gri 実装 / grt 型の定義
--   gO シンボル一覧 / [d ]d 前後の診断 / <C-w>d 行の診断 / 挿入モードの <C-s> 引数の説明
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "定義へ移動")
    map("gD", vim.lsp.buf.declaration, "宣言へ移動")
    map("<leader>gl", vim.diagnostic.open_float, "行の診断を表示")
  end,
})

-- 補完（blink.cmp。home.nix で入れている）。LSP・スニペット・パス・バッファの単語を候補に出す
-- LSP に「補完ができる」と伝える設定は blink.cmp が自動で行う
require("blink.cmp").setup({
  keymap = {
    -- Enter で確定、C-Space で開く、C-e で閉じる、C-n / C-p でも上下
    preset = "enter",
    -- 旧設定と同じく、Tab / S-Tab で候補を上下する（スニペットの中では次・前の入力欄へ）
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },
  completion = {
    -- 候補の説明を横に出す
    documentation = { auto_show = true },
  },
  -- 関数の引数を入力している間、引数の説明を出す
  signature = { enabled = true },
})

-- 言語サーバーの設定（旧設定から、既定と違うところだけ残した）
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      -- Neovim の設定を書くとき、vim.* の補完と型が効くようにする
      runtime = { version = "LuaJIT" },
      workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.config("basedpyright", {
  settings = {
    -- 既定の "recommended" は厳しすぎるので、旧設定（pyright の basic）に合わせる
    basedpyright = { analysis = { typeCheckingMode = "basic" } },
  },
})
vim.lsp.config("ruff", {
  on_attach = function(client)
    -- 説明（K）は basedpyright に任せる
    client.server_capabilities.hoverProvider = false
  end,
})
vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
      -- この関数の引数の中でもクラス名を補完する
      classFunctions = { "clsx", "cn", "cva", "tv", "tw", "twMerge" },
    },
  },
})
vim.lsp.config("emmet_language_server", {
  -- JS / TS の中では出さない（HTML・CSS・JSX だけ）
  filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
})
vim.lsp.enable({
  "vtsls", -- 旧設定の ts_ls から変更（VS Code と同じ TypeScript の機能）
  "eslint",
  "html",
  "cssls",
  "jsonls",
  "tailwindcss",
  "emmet_language_server",
  "basedpyright", -- 旧設定の pyright から変更（pyright に機能を足したもの）
  "ruff", -- 新規（Python の lint）
  "lua_ls",
  "nixd", -- 新規（この設定の home.nix などを書くため）
})

-- treesitter で色付けする（パーサとプラグインは home.nix で入れている）
-- nvim-treesitter は自動では有効にしないので、ファイルを開いたときに始める。パーサがない言語では何もしない
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
