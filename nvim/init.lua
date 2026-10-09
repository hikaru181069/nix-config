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
  "https://github.com/EdenEast/nightfox.nvim",
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
})

vim.cmd.colorscheme("nightfox")

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
