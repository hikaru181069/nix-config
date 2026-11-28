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
-- 左右の分割の線も消す（マスは残るので、ファイルツリーと同じ背景にする。fill_panel）
vim.opt.fillchars = { eob = " ", vert = " " }

-- インデントは2スペース
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- ヤンクとペーストを macOS のクリップボードと共有する
vim.o.clipboard = "unnamedplus"

vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<cr>", { desc = "検索のハイライトを消す" })

-- ノーマル・ビジュアルのモードでは日本語入力を使えなくする（理由と仕組みは lua/ime.lua）
require("ime")

-- プラグインは Neovim 標準の vim.pack で入れる。版はこのディレクトリの nvim-pack-lock.json に記録される
vim.pack.add({
  -- 配色（tmux・Ghostty などと揃える）。どちらを使うかは ~/nix-config/theme.nix で決める
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/navarasu/onedark.nvim",
  -- リポジトリの名前が nvim なので、名前を catppuccin にして入れる
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  -- リポジトリの名前が neovim なので、名前を rose-pine にして入れる
  { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
  "https://github.com/gbprod/nord.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/neanias/everforest-nvim",
  "https://github.com/marko-cerovac/material.nvim",
  "https://github.com/savq/melange-nvim",
  "https://github.com/projekt0n/github-nvim-theme",
  "https://github.com/cocopon/iceberg.vim",
  "https://github.com/kepano/flexoki-neovim",
  "https://github.com/bluz71/vim-moonfly-colors",
  "https://github.com/bluz71/vim-nightfly-colors",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/Aejkatappaja/sora",
  -- C-hjkl で Neovim の分割と tmux のペインを区別なく移動（tmux 側にも同じプラグインがある）
  "https://github.com/christoomey/vim-tmux-navigator",
  -- ファイル・文字列・バッファなどを絞り込んで探す（plenary は telescope が使う部品）
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  -- 各言語サーバーの起動方法（コマンド・対象のファイル・ルートの探し方）の定義集
  "https://github.com/neovim/nvim-lspconfig",
  -- 各言語のスニペット集（VS Code 形式。blink.cmp が読む）
  "https://github.com/rafamadriz/friendly-snippets",
  -- ファイルツリー（material-icon はファイルの種類のアイコン。VS Code の Material Icon 風で、nvim-web-devicons の代わりにそのまま使える）
  "https://github.com/DaikyXendo/nvim-material-icon",
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
  -- 囲む文字（かっこ・引用符・タグ）を足す・変える・消す（ysiw" / cs"' / ds" など。選択中は S）。設定は要らない
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.x") },
})

-- 配色。どのテーマを使うかは ~/nix-config/theme.nix で決める（home.nix が theme.lua に書き出す）
local theme = require("theme").nvim
-- 使うときだけ読みこむテーマ（数が多いので、使わないものは読みこまない）。名前がそのまま colorscheme の名前
-- src: プラグイン（書いていないものは、上でもう入れてあるプラグインの別の種類）。name: 入れるときの名前（リポジトリの名前が
-- nvim・vim のように分かりにくいもの）。colorscheme: colorscheme の名前がテーマの名前と違うもの
-- setup: 先に呼ぶ設定。diff: 差分の背景が明るすぎるので、palette の色にする。highlights: colorscheme のあとに上書きする色
local extra_themes = {
  vague = { src = "vague-theme/vague.nvim" },
  ["kanso-zen"] = { src = "webhooked/kanso.nvim" },
  ["kanso-ink"] = { src = "webhooked/kanso.nvim" },
  ["solarized-osaka"] = { src = "craftzdog/solarized-osaka.nvim", setup = { "solarized-osaka", { transparent = false } } },
  oxocarbon = { src = "nyoom-engineering/oxocarbon.nvim" },
  cyberdream = { src = "scottmckendry/cyberdream.nvim" },
  vesper = { src = "datsfilipe/vesper.nvim" },
  lackluster = { src = "slugbyte/lackluster.nvim" },
  poimandres = { src = "olivercederborg/poimandres.nvim", setup = { "poimandres", {} }, diff = true },
  dracula = { src = "Mofiqul/dracula.nvim", diff = true },
  ["monokai-pro"] = { src = "loctvl842/monokai-pro.nvim", setup = { "monokai-pro", { filter = "pro", devicons = false, disabled_plugins = { "akinsho/bufferline.nvim" } } } },
  ["night-owl"] = { src = "oxfist/night-owl.nvim", diff = true },
  ["ayu-dark"] = { src = "Shatur/neovim-ayu" },
  ["gruvbox-material"] = { src = "sainnhe/gruvbox-material" },
  sonokai = { src = "sainnhe/sonokai" },
  nordic = { src = "AlexvZyl/nordic.nvim" },
  ["modus-vivendi"] = { src = "miikanissi/modus-themes.nvim", colorscheme = "modus_vivendi" },
  mellifluous = { src = "ramojus/mellifluous.nvim" },
  miasma = { src = "xero/miasma.nvim", diff = true },
  oldworld = { src = "dgox16/oldworld.nvim" },
  embark = { src = "embark-theme/vim", name = "embark", diff = true },
  everblush = { src = "Everblush/nvim", name = "everblush" },
  mellow = { src = "mellow-theme/mellow.nvim", diff = true },
  jellybeans = { src = "WTFox/jellybeans.nvim" },
  ["doom-one"] = { src = "NTBBloodbath/doom-one.nvim" },
  -- Synthwave 系。fluoromachine は光る効果（glow。背景に色が付く）を切る
  fluoromachine = { src = "maxmx03/fluoromachine.nvim", setup = { "fluoromachine", { glow = false, theme = "fluoromachine", transparent = false } } },
  synthweave = { src = "samharju/synthweave.nvim" },
  laserwave = { src = "lettertwo/laserwave.nvim" },
  -- Xcode の公式の配色（dark）
  xcodedark = { src = "lunacookies/vim-colors-xcode" },
  -- 高いコントラスト版。バーの色をこのテーマの浮かぶ窓の黒にしたので、関数の帯（treesitter-context）は前のバーの色にする（お試し）
  xcodedarkhc = { src = "lunacookies/vim-colors-xcode", highlights = { TreesitterContext = { bg = "#17171b" } } },
  xcodewwdc = { src = "lunacookies/vim-colors-xcode" }, -- WWDC の配色
  -- 自作の配色（nvim/lua/outrun.lua。VS Code の Outrun Meets Synthwave の色を参考にした）
  ["outrun-night"] = {},
  ["outrun-electric"] = {},
  -- 上で入れてあるプラグインの、別の種類
  ["catppuccin-macchiato"] = {},
  ["catppuccin-frappe"] = {},
  ["tokyonight-storm"] = {},
  ["tokyonight-moon"] = {},
  ["rose-pine-moon"] = {},
  -- Kanagawa の wave。dragon と同じく、左端の列を本文と同じ背景にする
  ["kanagawa-wave"] = { setup = { "kanagawa", { colors = { theme = { all = { ui = { bg_gutter = "none" } } } } } } },
  terafox = {},
  duskfox = {},
  -- OneDark の dark（Atom の元祖 One Dark）。onedark.nvim は colorscheme の名前が onedark で、種類は setup で決める
  ["onedark-atom"] = { setup = { "onedark", { style = "dark" } }, colorscheme = "onedark" },
  github_dark = {},
  github_dark_colorblind = {},
}

if theme == "gruvbox" then
  -- Gruvbox の背景を暗いほう（hard）にする（Ghostty の Gruvbox Dark Hard と同じ背景 #1d2021）
  -- 左端の列（git や診断の印が出る列）と、その上の印の背景を、Gruvbox の既定（本文より明るい色）から本文と同じ色にする
  local same_as_body = { bg = require("palette").bg }
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
    },
  })
  vim.cmd.colorscheme("gruvbox")
elseif theme == "catppuccin" then
  -- Catppuccin Mocha。左端の列は、最初から本文と同じ背景
  require("catppuccin").setup({ flavour = "mocha" })
  vim.cmd.colorscheme("catppuccin")
elseif theme == "rose-pine" then
  -- Rosé Pine の main（いちばん暗い種類）
  require("rose-pine").setup({ variant = "main" })
  vim.cmd.colorscheme("rose-pine")
elseif theme == "nord" then
  -- Nord（公式の色）
  require("nord").setup({})
  vim.cmd.colorscheme("nord")
elseif theme == "tokyonight" then
  -- Tokyo Night の night（いちばん暗い種類）
  require("tokyonight").setup({ style = "night" })
  vim.cmd.colorscheme("tokyonight-night")
elseif theme == "kanagawa" then
  -- Kanagawa の dragon（いちばん暗い種類）
  -- 左端の列（git や診断の印が出る列）は、既定では本文より明るいので、本文と同じ背景にする
  require("kanagawa").setup({
    theme = "dragon",
    background = { dark = "dragon" },
    colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
  })
  vim.cmd.colorscheme("kanagawa-dragon")
elseif theme == "everforest" then
  -- Everforest の hard。Ghostty の Everforest Dark Hard は背景が bg_dim（#1e2326）で、Neovim の hard の背景（#272e33）より暗いので、
  -- Neovim の背景を Ghostty に合わせる（Neovim を開いたところだけ明るく見えないように）
  require("everforest").setup({
    background = "hard",
    colours_override = function(palette)
      palette.bg0 = require("palette").bg
    end,
  })
  vim.cmd.colorscheme("everforest")
elseif theme == "material-darker" or theme == "material-deep-ocean" then
  -- Material の darker / deep ocean（どちらにするかは vim.g.material_style で決める）
  vim.g.material_style = theme == "material-darker" and "darker" or "deep ocean"
  -- material.nvim はカーソルに色を付ける（ターミナルにカーソルの色を頼む）。閉じるときに色を戻すが、Ghostty はそのときの
  -- 設定の色を覚えたままになり、あとでテーマを替えてもカーソルの色が変わらなくなったので、切る（ほかのテーマと同じく、ターミナルの色）
  -- async_loading: 後から読みこまれて、半透明の背景や分割の線のマスが塗り直されないよう、最初に全部読みこむ
  require("material").setup({ disable = { colored_cursor = true }, async_loading = false })
  vim.cmd.colorscheme("material")
elseif theme == "melange" then
  -- Melange の dark（暗い背景か明るい背景かは background で決まる）
  vim.o.background = "dark"
  vim.cmd.colorscheme("melange")
elseif theme == "github_dark_dimmed" or theme == "github_dark_default" then
  -- GitHub の Dark Dimmed / Dark Default（名前がそのまま colorscheme の名前）
  -- Dark Default のカーソル行は、プラグインの色（#484f58）だと明るすぎるので、Dark Dimmed と同じ決め方（背景に文字の色を1割混ぜる）の色にする
  require("github-theme").setup({
    groups = { github_dark_default = { CursorLine = { bg = "#23272d" } } },
  })
  vim.cmd.colorscheme(theme)
elseif theme == "iceberg" then
  -- Iceberg の dark。左端の列（行番号・印）は本文より明るい背景なので、本文と同じ背景にする
  vim.o.background = "dark"
  vim.cmd.colorscheme("iceberg")
  for _, name in ipairs({
    "LineNr",
    "SignColumn",
    "FoldColumn",
    "GitGutterAdd",
    "GitGutterChange",
    "GitGutterChangeDelete",
    "GitGutterDelete",
    "DiagnosticSignError",
    "DiagnosticSignWarn",
    "DiagnosticSignInfo",
    "DiagnosticSignHint",
    "DiagnosticSignOk",
  }) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    hl.bg = tonumber(require("palette").bg:sub(2), 16)
    vim.api.nvim_set_hl(0, name, hl)
  end
  -- タブ行とステータスラインは、色を反転する指定（reverse）で書かれている。bufferline の色がその上に重なると、
  -- 文字と背景の色が入れかわってしまうので、反転を使わず、入れかえた色で書き直す（見た目は同じ）
  for _, name in ipairs({ "TabLineFill", "StatusLine", "StatusLineNC" }) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    vim.api.nvim_set_hl(0, name, { fg = hl.bg, bg = hl.fg })
  end
elseif theme == "flexoki" then
  -- Flexoki の dark
  vim.cmd.colorscheme("flexoki-dark")
elseif theme == "nightfox" or theme == "carbonfox" then
  -- Nightfox / Carbonfox（同じプラグイン。名前がそのまま colorscheme の名前）
  vim.cmd.colorscheme(theme)
elseif theme == "aura-dark" then
  -- Aura（dark）。いろいろなアプリ用の大きなリポジトリなので、このテーマのときだけ読みこみ、中の Neovim 用のフォルダを使う
  vim.pack.add({ "https://github.com/daltonmenezes/aura-theme" })
  vim.opt.rtp:append(vim.pack.get({ "aura-theme" })[1].path .. "/packages/neovim")
  vim.cmd.colorscheme("aura-dark")
  -- 細かい色分けが古い名前（TS〜）で書かれているので、今の Neovim の名前からつなぐ
  for new, old in pairs({
    ["@variable"] = "TSVariable",
    ["@variable.parameter"] = "TSParameter",
    ["@variable.member"] = "TSField",
    ["@property"] = "TSProperty",
    ["@constructor"] = "TSConstructor",
    ["@function.method"] = "TSMethod",
    ["@keyword.function"] = "TSKeywordFunction",
    ["@punctuation.bracket"] = "TSPunctBracket",
    ["@tag"] = "TSTag",
    ["@tag.delimiter"] = "TSTagDelimiter",
  }) do
    vim.api.nvim_set_hl(0, new, { link = old })
  end
  -- カーソル行は背景と同じ色で見えず、選択範囲と差分は色の反転で明るすぎるので、決め直す
  local p = require("palette")
  for name, hl in pairs({
    CursorLine = { bg = "#312e46" }, -- 公式の VS Code 版のカーソル行（紫を2割混ぜた色）
    Visual = { bg = p.search },
    DiffAdd = { bg = p.diff_add },
    DiffDelete = { bg = p.diff_delete },
    DiffChange = { bg = p.diff_change },
    DiffText = { bg = p.diff_text },
    Added = { fg = p.green },
    Removed = { fg = p.red },
    Changed = { fg = p.yellow },
    NormalFloat = { fg = p.fg, bg = p.bg_bar },
  }) do
    vim.api.nvim_set_hl(0, name, hl)
  end
elseif theme == "onedark_dark" then
  -- One Dark Pro の onedark_dark（背景が真っ黒の種類）
  -- onedark.nvim と同じ onedark という名前の配色を持っていて、一緒に読みこむと OneDark darker の色が変わるので、このテーマのときだけ読みこむ
  vim.pack.add({ "https://github.com/olimorris/onedarkpro.nvim" })
  require("onedarkpro").setup({ options = { cursorline = true } })
  vim.cmd.colorscheme("onedark_dark")
elseif extra_themes[theme] then
  local extra = extra_themes[theme]
  if extra.src then
    vim.pack.add({ { src = "https://github.com/" .. extra.src, name = extra.name } })
  end
  vim.o.background = "dark"
  if extra.setup then
    require(extra.setup[1]).setup(extra.setup[2])
  end
  vim.cmd.colorscheme(extra.colorscheme or theme)
  -- テーマが決めたタブの色（BufferLine〜）は消し、lua/ui.lua の共通の見た目にする
  for _, name in ipairs(vim.fn.getcompletion("BufferLine", "highlight")) do
    vim.api.nvim_set_hl(0, name, {})
  end
  for name, hl in pairs(extra.highlights or {}) do
    vim.api.nvim_set_hl(0, name, hl)
  end
  if extra.diff then
    local p = require("palette")
    for name, bg in pairs({ DiffAdd = p.diff_add, DiffDelete = p.diff_delete, DiffChange = p.diff_change, DiffText = p.diff_text }) do
      vim.api.nvim_set_hl(0, name, { bg = bg })
    end
  end
elseif theme == "sora" then
  -- Sora
  vim.cmd.colorscheme("sora")
elseif theme == "moonfly" or theme == "nightfly" then
  -- Moonfly / Nightfly（同じ作者。名前がそのまま colorscheme の名前）
  vim.cmd.colorscheme(theme)
else
  -- OneDark の darker。左端の列は、onedark.nvim では最初から本文と同じ背景なので、上書きはいらない
  require("onedark").setup({ style = "darker" })
  require("onedark").load()
end

-- カーソル行の帯を、左端の印の列と行番号までつなげる（どのテーマでも、Gruvbox と同じ形にそろえる）
-- 本文のカーソル行（CursorLine）の背景を、行番号（CursorLineNr）・印の列（CursorLineSign）・折りたたみの列（CursorLineFold）にも付ける
-- 文字の色はテーマのまま。テーマを読み込み直したとき（ColorScheme）も付け直す
local function extend_cursorline()
  local bg = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false }).bg
  for _, name in ipairs({ "CursorLineNr", "CursorLineSign", "CursorLineFold" }) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    hl.bg = bg
    vim.api.nvim_set_hl(0, name, hl)
  end
end
extend_cursorline()
vim.api.nvim_create_autocmd("ColorScheme", { callback = extend_cursorline })

-- 半透明（home.nix の transparent）: メインの背景色（palette の bg）だけを塗らず、Ghostty の背景を透かす。ほかの色はそのまま
if require("theme").transparent then
  local function clear_background()
    local bg = tonumber(require("palette").bg:sub(2), 16)
    for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
      if hl.bg == bg and not hl.reverse then
        hl.bg = nil
        vim.api.nvim_set_hl(0, name, hl)
      end
    end
    -- 塗らないタブの下に隠れていた、タブの行の下地の色が出ないようにする
    vim.api.nvim_set_hl(0, "TabLineFill", {})
  end
  clear_background()
  vim.api.nvim_create_autocmd("ColorScheme", { callback = clear_background })
end

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
-- ツリー・左右の分割の線のマス・no-neck-pain の余白を、同じ背景にする（本文と同じ色のマスがあると、カーソル行の帯が途中で欠けて見える）
-- 色はバー（tmux・sketchybar・タブの行の空き）と同じ bg_bar。nvim-tree が色を決めたあと（setup のあと）に行う
local function fill_panel()
  local palette = require("palette")
  for _, name in ipairs({ "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer", "NvimTreeSignColumn" }) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    vim.api.nvim_set_hl(0, name, { fg = hl.fg or (name:find("Normal") and palette.fg or nil), bg = palette.bg_bar })
  end
  for _, name in ipairs({ "WinSeparator", "NvimTreeWinSeparator", "NoNeckPainBg" }) do
    vim.api.nvim_set_hl(0, name, { bg = palette.bg_bar })
  end
  -- テーマがツリーの部品（フォルダのアイコンなど）の背景を本文の色で決めていると、ツリーの中にその1マスだけ本文の色が見える。
  -- 背景を消してツリーの色を見せる。ツリーのカーソル行が本文の色のテーマ（Gruvbox Material）は、本文のカーソル行の色にする
  local main = tonumber(palette.bg:sub(2), 16)
  for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
    if name:find("^NvimTree") and not hl.link and hl.bg == main then
      hl.bg = name == "NvimTreeCursorLine" and vim.api.nvim_get_hl(0, { name = "CursorLine", link = false }).bg or nil
      vim.api.nvim_set_hl(0, name, hl)
    end
  end
end
fill_panel()
vim.api.nvim_create_autocmd("ColorScheme", { callback = vim.schedule_wrap(fill_panel) })
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
require("no-neck-pain").setup({
  width = 110,
  buffers = {
    colors = { background = palette.bg_bar, blend = 0 },
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
  "rust_analyzer", -- Rust。本体は Nix ではなく rustup で入れる（ツールチェーンと版を合わせるため）
})

-- treesitter で色付けする（パーサとプラグインは home.nix で入れている）
-- nvim-treesitter は自動では有効にしないので、ファイルを開いたときに始める。パーサがない言語では何もしない
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
