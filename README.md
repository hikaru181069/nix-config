# nix-config

自分の Mac（Apple Silicon）の開発環境を、Nix でまとめて管理するための設定です。
[nix-darwin](https://github.com/nix-darwin/nix-darwin) で Mac 全体を、[home-manager](https://github.com/nix-community/home-manager) でユーザーのツールと設定を管理しています。

## 中身

| ファイル | 内容 |
|---|---|
| `flake.nix` | 入口。nixpkgs・nix-darwin・home-manager を読み込む |
| `darwin.nix` | Mac 全体の設定（macOS の設定、Homebrew の cask、Nix 本体、Mac の名前、自動の掃除） |
| `home.nix` | ユーザーの設定（zsh・starship・git・tmux・Ghostty・CLI ツールなど） |
| `palette.nix` | 配色（Gruvbox Dark Hard）。各ツールにここから色を配る |
| `nvim/` | Neovim の設定（Lua。`vim.pack` と `vim.lsp` を使い、素の状態から1つずつ足したもの） |
| `sketchybar/` | メニューバーの代わりのバー（Lua） |
| `yabai/`・`skhd/` | ウィンドウ管理とキー操作 |
| `docs/log.md` | 作業の記録（なぜそうしたかも書いている） |

各プロジェクトの Node.js・Python などは、ここではなく、それぞれのリポジトリの `flake.nix`（devShell）と direnv で用意しています。

## 使い方

```sh
# 設定を反映する（zsh のエイリアス rebuild と同じ）
sudo darwin-rebuild switch --flake ~/nix-config

# 中身を新しくする
nix flake update --flake ~/nix-config

# 1つ前の状態に戻す
sudo darwin-rebuild --rollback
```

古い世代は、毎週日曜の朝に自動で掃除されます（14 日より前の状態には戻せなくなります）。
