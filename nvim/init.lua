-- Neovim の設定。素の状態から始め、不便を感じたものだけ足す（足した理由をコメントに残す）
-- このファイルは ~/nix-config/nvim にあり、~/.config-nix/nvim-nix からリンクしている（編集するとすぐ反映される）

vim.g.mapleader = " "

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

-- treesitter で色付けする（パーサとプラグインは home.nix で入れている）
-- nvim-treesitter は自動では有効にしないので、ファイルを開いたときに始める。パーサがない言語では何もしない
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
