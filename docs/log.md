# 環境構築の記録

Nix で開発環境を作り直す作業の記録。新しいものが上。
全体の計画は `/Users/Shared/nix-env-plan.md`。

---

## 2026-10-09

### Git を SSH 接続・コミット署名・delta にした（Step 3 の残り）

**やったこと**（nix 環境だけ）
- GitHub との通信を SSH にした。鍵は既存の `~/.ssh/id_ed25519`（認証用として GitHub に登録済みだった）
  - SSH の設定は `~/.config-nix/ssh/config` に置き、git の `core.sshCommand` で指定
  - パスフレーズは macOS のキーチェーンに保存し、nix 環境のシェル起動時に ssh-agent へ読み込む
  - このリポジトリのリモートを `git@github.com:hikaru181069/nix-config.git` に変更
- コミットとタグに、同じ鍵で署名するようにした（`gpg.format = ssh`）。GitHub に Signing key として登録
  - 手元で検証するための一覧 `allowed_signers` を置いた。公開鍵はリポジトリの `keys/` に入れた
- delta: `git diff` / `log` / `show` の表示を見やすくした（`n` / `N` で次・前のファイルへ移動）

**なぜこうしたか**
- `~/.ssh/config` は旧環境と共有なので、home-manager の `programs.ssh` は使わず、別の場所に置いた
- キーチェーン連携（UseKeychain）は macOS 標準の ssh だけが対応しているので、`/usr/bin/ssh` を使う
- 認証と署名を1つの鍵にまとめ、管理するものを増やさない

**注意**
- nix 環境では全コミットに署名するので、鍵が ssh-agent にないとコミットが失敗する。そのときは `/usr/bin/ssh-add --apple-load-keychain`
- 旧環境は今までどおり（HTTPS + gh、署名なし）
- delta の色はまだ既定。テーマ統一（Step 5.5）で合わせる

### シェルまわりを整えた（Step 3 の残り）

**やったこと**（nix 環境だけ。old 環境は変わらない）
- zsh:
  - 補完、入力中に履歴から候補を薄く表示する機能（autosuggestions）、コマンドの色分け（syntax-highlighting）
  - 履歴は 10 万件。全タブで共有し、重複を除き、実行時刻も残す
  - Ctrl-X Ctrl-E で、入力中のコマンドをエディタで編集できる
- starship: 表示はディレクトリ・git ブランチ/状態・nix shell・実行時間（2 秒以上のときだけ）・成否で色の変わる `❯` だけにした
- eza: `ls` `ll` `la` `lt` `lt3` `lta` を eza にした（アイコン付き）。`tree` `tree2` `tree3` `treei` の別名はやめた
- fzf を追加: Ctrl-R で履歴検索、Ctrl-T でファイル検索、Alt-C でディレクトリ移動
- zoxide はそのまま続投（`z`）

**なぜこうしたか**
- 今までは macOS の既定設定のままで、履歴が約 1000 件で消えていき、補完の初期化（compinit）もされていなかった
- 時刻やホスト名はプロンプトに出さず、tmux / sketchybar に任せる（計画どおり）
- ツリー表示が `tree` と `eza --tree` の2通りあったので eza に揃えた
- 行編集は Emacs 式と明示した。EDITOR に nvim を設定すると、zsh が勝手に vi 式に変わるため

**確認したこと**
- nix 側: eza / fzf / zoxide / starship / git は Nix 版。Ctrl-R が fzf、Ctrl-X Ctrl-E がエディタ編集、履歴の設定も入っている
- old 側: eza・git は Homebrew 版のまま、`ll` も今までどおり

**注意**
- 履歴は old と nix で別のファイル（nix は `~/.config-nix/zsh/.zsh_history`）。nix 側は空から始まる
- プロンプトの色はまだ starship の既定。Nightfox への色合わせはテーマ統一（Step 5.5）でまとめて行う

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
