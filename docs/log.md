# 環境構築の記録

Nix で開発環境を作り直す作業の記録。新しいものが上。
全体の計画は `/Users/Shared/nix-env-plan.md`。

---

## 2026-10-09

### ターミナルを Ghostty に切り替え

- WezTerm から Ghostty（1.3.1）に移行。本体は `/Applications/Ghostty.app` のまま、設定だけ `home.nix` の `programs.ghostty` で管理
- 引き継いだ設定（`~/.config/wezterm/wezterm.lua` から）: フォント Maple Mono NF（＋CN）、サイズ 18.5、起動時 130×38、余白 10、タイトルバーなし、スクロールバーなし
- テーマは Catppuccin Mocha から Nightfox（Ghostty 同梱）に変更。WezTerm で Catppuccin 用に調整していたカーソル色は引き継がず、Nightfox の初期値に任せた
- フォールバックの Noto Color Emoji は入っていないので外した（絵文字は macOS 標準の Apple Color Emoji が使われる）
- 設定ファイルは `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` に置く
  - Ghostty は Dock から起動するので `~/.config-nix` を見ない。また old / nix どちらのシェルでも同じ Ghostty を使う
  - home-manager の初期値（`~/.config-nix/ghostty/config`）は使わず、生成した設定をこの場所に置くようにした
  - 元からあった空の `config.ghostty`（0 バイト）は消して置き換えた
- WezTerm の設定はそのまま残している。反映は Ghostty の再読み込み（⌘⇧,）か再起動で

### GitHub に保存

- `~/nix-config` をコミットし、GitHub に非公開リポジトリとして push（https://github.com/hikaru181069/nix-config）
- コミットのメールは GitHub の noreply（このリポジトリだけの設定）
- ブランチ名は `main`（今の環境の git の初期値が `master` だったので直した。新しい環境では `main` が初期値）
- 公開にするかは未定。あとから変更できる

### 新しい環境を有効化し、切り替えコマンド `envswitch` を用意した

**やったこと**
- `~/nix-config` を作成（`flake.nix` + `home.nix`）。中身は最小限: git / zsh / starship
- home-manager で適用。置かれたファイル:
  - `~/.config-nix/`（git, zsh, nix の設定）… 新しい環境の設定置き場
  - `~/.zshenv` … 切り替えスイッチ（中身は `envswitch/zshenv`）
  - `~/.local/bin/envswitch` … 切り替えコマンド
- 既存のファイルは何も上書きしていない（適用前に確認済み）

**使い方**
- `envswitch nix` → 次に開いたタブから新しい環境
- `envswitch old` → 次に開いたタブから今までの環境
- `envswitch` → 今どちらかを表示
- 開いているタブはそのまま。切り替えは新しく開いたタブから
- 万一おかしくなったら `~/.zshenv` を消せば完全に元どおり

**なぜこうしたか**
- 今までの環境（`~/.config` の dotfiles、`~/.zshrc`）は毎日の開発で使うので、一切触らずに残したい
- そこで新しい環境の設定は別の場所 `~/.config-nix` に置き、どちらを読むかだけを切り替える
- `~/.zshenv` はどのシェルでも最初に読まれるので、ここに分岐を置いた
- home-manager は最初「常に新しい環境を読む」`~/.zshenv` を置こうとしていた。そのままだと全部のタブが新しい環境になるので、分岐する中身に差し替えた
- old のときは Nix の PATH を外す。Nix を入れると、どのシェルにも Nix のツールが優先して入るため（今までの環境で Nix 版 git などが使われてしまう）
- git は `~/.gitconfig`（今までの設定）も読んでしまうので、新しい環境では `GIT_CONFIG_GLOBAL` で読む先を1つに絞った

**確認したこと**
- old: `git` `nvim` は Homebrew 版、`node` は nvm 版、メールは今までのもの、PATH に Nix なし
- nix: `git` `starship` は Nix 版、メールは GitHub の noreply、flakes 有効
- old 側で出る「gitstatus failed」は p10k が端末なしのテストで出すもので、今回の変更とは無関係（`~/.zshenv` なしでも同じ）

**注意**
- old のときは `nix` コマンドも見えない（Nix を入れる前と同じ状態にするため）。設定を適用するときは `envswitch nix` のタブで行う

### Nix 本体をインストール

- 公式インストーラ（マルチユーザー版）で Nix 2.35.2 を導入
- `/nix` は専用の APFS ボリューム。`/etc/zshrc` と `/etc/bashrc` に Nix 読み込みの行が追加された（元は `*.backup-before-nix` として残っている）
- インストール前から開いていたターミナルでは `nix` が見つからない。新しいタブを開けば使える

### 進め方を決め直した

- 別の macOS ユーザーで作る案はやめた（手間がかかるため）
- 代わりに、1つのユーザーの中で今までの環境と新しい環境を並べて置き、コマンドで自由に行き来できるようにする
- 作ってあった `Hikaru` ユーザーは使わない

## 2026-10-08

- Nix で環境を作り直すと決め、計画を立てた（flake + home-manager + nix-darwin + devShell/direnv）
- テーマは Nightfox に決定
