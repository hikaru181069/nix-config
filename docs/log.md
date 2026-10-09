# 環境構築の記録

Nix で開発環境を作り直す作業の記録。新しいものが上。
全体の計画は `/Users/Shared/nix-env-plan.md`。

---

## 2026-10-09

### Neovim に telescope を入れた（Step 4）

**やったこと**（nix 環境だけ）
- telescope（と、それが使う plenary）を vim.pack で入れた
- キーは旧設定と同じ: `<space>ff` ファイル、`<space>fg` 文字列（ripgrep）、`<space>fb` バッファ、`<space>fh` ヘルプ
- 見た目も旧設定と同じ: 入力欄が上、結果も上から並ぶ

**なぜこうしたか**
- ファイル一覧はシェルの fzf（Ctrl-T）と同じ fd のコマンドで作る。旧設定は `hidden = true` だけで、`.git` の中のファイルまで出ていた
- 旧設定は lazy.nvim で「使うときに読み込む」にしていたが、telescope は使うときまで中身を読み込まないので、そのまま起動時に入れている

**確認したこと**
- `:checkhealth telescope`: plenary・rg・fd が見つかる
- 実際に `<space>ff` を開くと、このリポジトリの 10 ファイルが出て、`.git` の中は出ない。プレビューも出る

### Neovim に treesitter を入れた（Step 4）

**やったこと**（nix 環境だけ）
- 構文に沿った色付けを treesitter で行うようにした
- 言語: bash, css, html, javascript, json, lua, markdown, markdown_inline, nix, python, tsx, typescript, vim, vimdoc（旧設定の13言語に、この設定を書くための nix を足した）
- ファイルを開いたときに `vim.treesitter.start` を呼ぶ。パーサのない言語では何もしない

**なぜこうしたか**
- パーサはコンパイル済みのものを nixpkgs から取る（`nvim-treesitter.withPlugins`）。旧設定のように Neovim の中でビルドすると、コンパイラや tree-sitter CLI が要り、版も固定されない。LSP と同じく Mason は使わない方針
- nvim-treesitter のクエリはパーサの版と合わせる必要があるので、これだけは vim.pack ではなく Nix で入れた
- home-manager は Nix で入れたプラグインへのリンクを `~/.local/share/nvim/site/pack/hm` に作る。ここは旧環境の Neovim のデータ置き場で、旧環境の Neovim にも読み込まれてしまう。`NVIM_APPNAME` に合わせて `~/.local/share/nvim-nix/site/pack/hm` に移した

**確認したこと**
- 14言語すべてでパーサとハイライトが読み込まれる。home.nix・flake.lock・init.lua で色付けが有効
- `:checkhealth nvim-treesitter` の「tree-sitter-cli not found」は、Neovim の中でパーサをビルドするときにだけ要るもので、問題ない
- 旧環境の `~/.local/share/nvim/site/pack` には何も足していない

**注意**
- 環境変数を足したときは、新しく開いたシェルにしか入らない。tmux の既存のペインでは `NVIM_APPNAME` がなく、素の Neovim が起動した。新しいペインで確かめる

### Neovim の土台を作った（Step 4）

**やったこと**（nix 環境だけ）
- Neovim 0.12.5 を `programs.neovim` で入れた。`EDITOR` / `VISUAL` も nvim にした
- 設定はゼロから作り直す。`~/nix-config/nvim/init.lua` に書き、`~/.config-nix/nvim-nix` からリンクしている（編集するとすぐ反映される）
- 旧設定から引き継いだオプション: 行番号（相対）、カーソル行、signcolumn、`~` を消す、2スペースインデント、クリップボード共有、`<leader>nh` で検索ハイライトを消す
  - 引き継がなかったもの: termguicolors（0.10 から既定で有効）、completeopt（補完は blink.cmp を入れるときに決める）、updatetime（gitsigns などを入れるときに決める）
- プラグインは Neovim 標準の `vim.pack` で入れる。版は `nvim/nvim-pack-lock.json` に記録され、リポジトリで管理する
  - nightfox.nvim（配色）
  - vim-tmux-navigator（tmux のペインと C-hjkl で行き来するため。tmux 側の設定がこれを前提にしている）

**なぜこうしたか**
- `NVIM_APPNAME=nvim-nix` にして、設定・データ・状態・キャッシュをまとめて旧環境と分けた
  - 計画では「XDG_CONFIG_HOME の切り替えで自然に分かれる」としていたが、分かれるのは設定だけだった。データ（`~/.local/share/nvim`）には旧環境の lazy・mason・treesitter のパーサがあり、共有するとパーサなどが混ざる
- home-manager が作る設定（provider の無効化など）は init.lua に書かせず、起動時に読ませる（`sideloadInitLua`）。init.lua を自分の設定だけにするため

**確認したこと**
- nix 側: nvim は Nix 版、設定は `~/.config-nix/nvim-nix`、データは `~/.local/share/nvim-nix`、配色は nightfox、プラグイン2つが入った
- old 側: `NVIM_APPNAME` / `EDITOR` / `VISUAL` は envswitch で外す。旧環境の nvim はこれまでどおり `~/.config/nvim` を読む

### tmux を移した（Step 4）

**やったこと**（nix 環境だけ）
- `~/.config/tmux` の設定を `programs.tmux` に移した。prefix は C-a のまま
- 残したもの: マウス、vi 式コピーモード（v で選択、y / Enter で pbcopy）、prefix + hjkl で移動・HJKL でサイズ変更、`-` `|` で分割、`m` でズーム、`r` で再読み込み、C-hjkl で Neovim と行き来、escape-time 0、RGB、resurrect + continuum（30 分ごとに保存、起動時に復元）
- 削ったもの: tmux の既定と同じキー（1〜9、`[`、p / n、copy-mode の q）、分割キーの連打（`-r`）、tmux-sensible、tpm
  - tmux-sensible が実際に変えていた設定（focus-events、aggressive-resize、表示時間 4 秒、コマンド入力は Emacs 式）は直接書いた
- プラグインは tpm ではなく nixpkgs の tmuxPlugins。vim-tmux-navigator は手書きの設定をやめてプラグインにした
- ステータスラインは見た目をそのままに、色を Nightfox に置き換えた
  - 色の定義を `palette.nix` に作った（nightfox.nvim の値）。ほかのツールもここから色を取る
  - コピーモードの選択範囲の色だけは、背景と同じ色で見えにくかったので、Nightfox の選択色（sel0）にした

**旧環境と分けるためにしたこと**
- tmux のサーバーは1ユーザーに1つ（`/tmp/tmux-501/default`）なので、そのままだと旧環境で動いている tmux につながる。nix 環境では `TMUX_TMPDIR` を `$TMPDIR` にして、別のサーバーにした
- tmux 3.7 は `~/.tmux.conf`・`$XDG_CONFIG_HOME/tmux/tmux.conf`・`~/.config/tmux/tmux.conf` のうち、あるものを**全部**読む。旧環境の設定まで読まれていたので、tmux 本体をラップして `-f` で1つに絞った
- resurrect の保存先を `~/.local/share/tmux/resurrect-nix` に分けた
- continuum は「ほかに tmux のプロセスがあると自動保存しない」。旧環境と同時に動かすとどちらも保存しなくなるので、nix 側の tmux はプロセス名を `nix-tmux` にし、nix 側の continuum は `nix-tmux` だけを数えるように書き換えた

**確認したこと**
- nix 側: 別のソケット、読む設定は1つだけでエラーなし、自動保存も有効、保存先は resurrect-nix、キー割り当ても上のとおり
- old 側: 旧環境の tmux サーバー（セッション 4 / MLB-App / coffee-app）はそのまま。プロセス名も `tmux` のまま

- 実際に起動すると、ペインで Nix 版のツールが使われなかった。tmux はペインに `ZDOTDIR` を渡すので、zsh が `~/.zshenv`（envswitch の分岐）を飛ばして `~/.config-nix/zsh/.zshenv` を直接読み、旧環境向けの印（`__ETC_PROFILE_NIX_SOURCED`）が残って Nix の PATH が足されなかった。tmux の設定で `set-environment -gu ZDOTDIR` として、ペインが必ず `~/.zshenv` を通るようにした

- ステータスラインの区切りの三角（Nerd Font の U+E0B0 など）が、設定を書くときに空文字として抜け落ちていて、旧環境と形が違っていた。見えない文字なので、`builtins.fromJSON` で文字コードから作るようにした

**注意**
- 旧環境の tmux と Nix の tmux は別物で、互いのセッションは見えない
- 設定の再読み込みは prefix + r で行う。tmux の外から `tmux source-file` を実行すると、continuum がそのプロセスを「別のサーバー」と数え、自動保存が止まる（ps がコマンド名を `nix-tmux -f /Use` までしか出さず、`source` を除外できないため）。止まったら tmux を起動し直す
- tmux の外から `tmux new-window` などを実行すると、実行したシェルの環境変数がそのウィンドウに混ざる（テストのときに旧環境の PATH が混ざって紛らわしかった）
- tmux の中で開くペインも、開いた時点の envswitch のモードに従う。nix の tmux を使っている途中で `envswitch old` にすると、そのあと開いたペインは旧環境になる

### ripgrep・fd・jq・lazygit を移した（Step 4 の始め）

**やったこと**（nix 環境だけ）
- ripgrep: `--smart-case`（小文字だけで検索すると大文字小文字を区別しない）
- fd・jq: 設定なしでそのまま
- fzf: ファイル・ディレクトリの一覧を fd で作るようにした（Ctrl-T / Alt-C）。.gitignore にあるものは出さず、隠しファイルは出す
- lazygit: diff を delta で表示

**なぜこうしたか**
- 旧環境ではどれも設定ファイルがなく、Brewfile のコメントによると telescope.nvim と lazygit.nvim のために入れていた。Neovim を移すときにも使う
- fzf は既定だと `find` で一覧を作るので、.git や node_modules の中まで出てしまう

**確認したこと**
- nix 側: rg / fd / jq / lazygit / delta は Nix 版。lazygit の設定は `~/.config-nix/lazygit` から読まれる（`XDG_CONFIG_HOME` が効くため）
- old 側: どれも Homebrew 版のまま。lazygit は今までどおり `~/Library/Application Support/lazygit` を読む

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
