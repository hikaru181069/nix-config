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
})

vim.cmd.colorscheme("nightfox")
