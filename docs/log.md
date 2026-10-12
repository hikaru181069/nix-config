# 環境構築の記録

Nix で開発環境を作り直す作業の記録。新しいものが上。
全体の計画は `/Users/Shared/nix-env-plan.md`。

---

## 2026-10-12

### Docker Desktop から OrbStack へ乗り換えた（Step 5 の残り）

- `brew install --cask orbstack`（計画どおり、nix-darwin までは GUI アプリは Homebrew の cask）。`docker` の接続先（context）は `orbstack` に切り替わった。旧環境・新環境どちらの zsh でも同じ OrbStack を使う
- 乗り換え前に kind のクラスタ（`coffee-app`）を削除し、動いていたコンテナをすべて止めた（kind の中のデータは消えてよい、とユーザーが判断）
- OrbStack の移行機能（`orb docker migrate`）は途中で止まった。手元でビルドしたイメージをレジストリから取ってこようとして失敗するため。移ったボリュームも中身が足りず（開発用 MongoDB が 43 ファイル中 18 ファイル）、移ったコンテナはネットワークがなく起動できなかった
- そのため手で移した:
  - 名前付きボリューム6つ（coffee-app の開発用・本番相当の MongoDB と Grafana、mlb-app と study-log の MongoDB）: Docker Desktop 側を読み取り専用でつなぎ、tar で OrbStack 側へコピー。ファイル数が一致することを確認
  - 手元でビルドしたイメージ9つ（coffee-app と mlb-app）: `docker save` → `docker load`。1回でまとめて渡すと失敗したので1つずつ
  - 公開されているイメージ（node・redis など）、名前なしのボリューム（node_modules の保護用）、ビルドキャッシュは移していない
- 確認: OrbStack で開発用の MongoDB を compose で起動し、件数が Docker Desktop と同じ（記録21件・ユーザー4件など）
- kind のクラスタを作り直し（3ノード Ready）、本番用イメージ3つを読み込んだ。マニフェストの適用はまだ（作業中の変更があるため、ユーザーが行う）
- 続き（同じ日）:
  - 本番相当の一式を OrbStack で起動。8コンテナとも動き、http://localhost:8080 が応答、本番相当の MongoDB のデータ（記録17件など）も残っていた。Prometheus は backend 3台と fastapi を集められている
  - kind にマニフェストを適用（namespace・secret・configmap・mongodb・fastapi・backend・frontend）。Pod はすべて Running で、worker 2台に分かれた。DB は空なので `npm run seed`・`seed:demo` を入れ直した。http://localhost:8081 が応答
  - Docker Desktop を終了した。自動起動はもともと無効（`AutoStart: false`、ログイン項目にもない）。アプリは消さずに残している（戻すときは Docker Desktop を開いて `docker context use desktop-linux`）
  - OrbStack もログイン時には起動しない設定（`app.start_at_login: false`、既定のまま）。Docker を使うときは OrbStack を開く
  - `~/coffee-app/backend/.env`（Git 管理外）の `MONGO_URI` を手元の MongoDB（27018）に変えた。Atlas の行はコメントにして残した
  - coffee-app の PR #2 を作った（`chore/mac-native-dev`）
- 困ったこと: gh（Go 製）だけ GitHub の API に `TLS handshake timeout` でつながらない（curl・git push は通る。サンドボックスの外でも同じ、`GODEBUG=tlsmlkem=0` でも同じ）。OrbStack を入れた後に起きたが、関係はまだわからない。PR は `gh auth token` のトークンで curl から API を呼んで作った
  - 調べた結果（同じ日）: OrbStack は関係なさそう。失敗するのは Nix の gh（2.102.0、Go 1.27.1 で作られている）だけで、Homebrew の gh（2.92.0、Go 1.26.2）・kubectl（Go 1.24）・curl・openssl はつながる
  - 試したがだめだったこと: `GODEBUG` で ML-KEM（`tlsmlkem=0`・`tlssecpmlkem=0`）や HTTP/2 を止める、証明書ファイルの指定、Go の名前解決への切り替え、サンドボックスの外での実行。IPv6・MTU（大きな最初の通信）の問題でもなかった（openssl で確認）
  - gh 2.102 は Go 1.27 が必須で、Go 1.26 で作り直すことはできない
  - 今のネットワークは学内（`josai.jp`）。Go 1.27 の通信だけをネットワーク側が止めている可能性もあるので、別のネットワークでも試す

### coffee-app を Mac 上で動かせるか確かめた（Step 5 の残り）

- アプリ本体（frontend・backend・fastapi）は Mac 上（devShell）で、MongoDB だけ Docker で動かす形を、実際に起動して確認した
  - 作業中のブランチ（`feat/k8s-bootstrap`）に触らないよう、main から `chore/mac-native-dev` を作り、別のフォルダ `~/coffee-app-mac`（git worktree）で作業した
  - `direnv allow` → `npm ci` で、手元に `node_modules` と `.venv` ができる（Neovim の LSP が型を読める）
  - 登録・ログイン・記録一覧の API、画面、FastAPI が応答。テスト（backend 580件、frontend lint・build・368件、pytest 10件）もすべて通った
- 見つかったずれ: `backend/.env.example` の MongoDB の番号が 27017（mlb-app の MongoDB）になっていて、Docker の MongoDB（27018）につながらなかった → 27018 に直し、README と IMPLEMENTATION.md に追記してコミット（58cd918。push はまだ）
- Prometheus・Grafana は、コンテナ名でアプリを見に行く設定のため、この形では使わない（メトリクスを見るときは全部 Docker で起動する）
- 注意: `~/coffee-app/backend/.env`（Git 管理外）は MongoDB Atlas を指している。このまま Mac 上で動かすと Atlas のデータを読み書きする

---

## 2026-10-11

### sketchybar をゼロから作り直し始めた（Step 5.5）

**決めたこと**（ユーザーと相談）
- 出すもの: 左に Apple ロゴ・スペース番号・今のアプリ・アプリのメニュー、右に日付と時刻・バッテリー・Wi-Fi・音量・CPU とメモリ・git ブランチ・Docker
- 形: バー自体は透明にして、項目のまとまりごとに角の丸い「島」を浮かべる
- 計画どおり、項目は1つずつ足す。旧設定（テンプレートを元にした Lua の設定、ヘルパーの C プログラムや常駐の統計プログラムあり）は参考にするだけ

**やったこと**（1回目: 土台と3項目）
- sketchybar を Nix（home-manager の `programs.sketchybar`、Lua と SbarLua）で入れ、起動も Nix に移した。設定は `~/nix-config/sketchybar`（編集したら `sketchybar --reload`）
- 土台: 透明なバー（高さ 38。ノッチの MacBook のメニューバーと同じ）、島（bg0 の地に bg3 の細い枠、角丸 10）、文字は Maple Mono NF
- 色は palette.nix から Lua のファイル（`~/.config-nix/sketchybar/palette.lua`）を作って読む
- スペース番号（1〜10）: 今いるスペースは番号を青く、背景を選択範囲の色に。中のアプリのアイコンを並べる（yabai に聞く）。押すとそのスペースへ
- 今のアプリ: アイコンと名前
- 日付と時刻: `10/11 日 22:05` の形。30 秒ごとに更新
- アプリのアイコンは sketchybar-app-font を nixpkgs から入れた（`~/Library/Fonts/HomeManager`）。アプリ名からアイコンを引く表（icon_map.lua）も同じパッケージのものを使い、フォントと版を揃えた
- Homebrew の起動設定（`homebrew.mxcl.sketchybar`）と、旧設定の統計プログラム（`com.sketchybar.stats-provider`）は止めて、`launchctl disable` で次のログインでも起動しないようにした（plist は残している）

**確認したこと**
- 項目がすべて登録され、スペース1に Ghostty などのアイコン、今のアプリに Ghostty、時刻に今の日時が入っている。エラーのログは空

**注意**
- 起動時に `--config` で設定を指定する。指定しないと旧環境の `~/.config/sketchybar` を読む
- 旧環境に戻すとき: `launchctl enable gui/$(id -u)/homebrew.mxcl.sketchybar`（stats-provider も）→ `brew services start sketchybar`。そのうえで home.nix から sketchybar を外す

### sketchybar の右側を3つの島にした（Step 5.5）→ やめた

- 島どうしがくっついて見える不具合（幅だけの項目に共通の余白が付いていた）を直したあと、島の表示はやめて、右側を旧設定の形（並びも旧設定の順番）に戻した（同じ日、ユーザーの判断）。以下は試したときの記録

- 右側の形を、見比べのページ（今のまま・項目ごとの島・左と同じ枠・1つの島、と島の分け方4通り）でユーザーが選んだ: B2（3つの島）
  - 左から [開発: git ブランチ・Docker] [統計: 切り替え・CPU・メモリ・通信量] [いつも見るもの: 音量・Wi-Fi・電池・日付と時刻]
  - 統計の表示切り替えのボタンは、押すと隠れるもの（CPU・メモリ・通信量）と同じ島に入れた（旧設定では Docker の隣だった）
- 島は bg0 の地に bg3 の細い枠、角丸 10、高さ 32。島の両端に 4 の余白、島の間は 10 空ける
- 島に入れるため、日付と時刻の項目に名前を付けた（`calendar.date`・`calendar.time`。旧設定は名前なし）
- 島の中の項目どうしの間は、旧設定の 10 の空きをなくした（島で囲むので）

### JankyBorders を入れた（Step 5.5）→ やめた

- 入れてみたが、枠線はいらないということで外した（同じ日）。以下は入れたときの記録

- 選んでいるウィンドウに枠線を付ける（sketchybar と同じ作者）。home-manager の `services.jankyborders`
- 色は palette.nix から: 選んでいるウィンドウは Gruvbox の aqua（`cyan`。今のアプリのアイコンや tmux の prefix 中と同じ色）、選んでいないウィンドウは枠なし。太さ 5、角丸
- home-manager の起動設定は設定ファイルを渡さず、launchd から起動すると旧環境の `~/.config/borders` を見に行くので、設定を起動の引数で直接渡している

### sketchybar の git ブランチと統計プログラムを直した（Step 5.5）

**git ブランチ**
- 旧設定は WezTerm 専用（WezTerm に今のペインのフォルダを聞く）で、Ghostty では出なかった
- Ghostty にはそれを聞く方法がないので、tmux に聞くようにした: Nix 側（`$TMPDIR/tmux-501`）と旧環境（`/tmp/tmux-501`）の両方の tmux から、いちばん最近使ったクライアントの今のペインのフォルダを使う。ターミナルは tmux の中で使う前提
- Ghostty か WezTerm が前面のときに出す。押すと Ghostty を開く（旧設定は WezTerm）

**統計プログラム（CPU・メモリ・通信量の数値）**
- joncrangle/sketchybar-system-stats（Rust）を Nix でビルドした（nixpkgs にない）。版は旧環境と同じ 0.9.0（最新は 0.9.2）
- home-manager の launchd（`org.nix-community.home.sketchybar-stats`）で、旧環境と同じ引数で起動する。ログは `~/Library/Logs/sketchybar/stats.*.log`
- 一時的に戻していた旧環境の Homebrew 版（`com.sketchybar.stats-provider`）は、また止めて `launchctl disable` した
- 確認: Nix 版が動き、sketchybar の CPU の数値が更新される

### Neovim のステータスラインの形を旧環境と同じにした（Step 5.5）

- 旧環境と表示が違っていた。最初に移したときに旧設定をそのまま使わず書き直したため、モードの前後の空白・右側の見えない区切りなどが変わっていた
- 旧設定（`~/.config/nvim/lua/ui/lualine.lua`）と同じ作り（部品の関数・余白・左右の並び）にして、色だけ palette.nix のものにした（色は今のものがよいというユーザーの希望）
  - 色の名前（`C.dark` など）は旧設定のまま、値を palette.nix の色にした。モードの色と横の三角の色は、それまでの新しいもの（三角は地と同じ色）
  - 外したのは Copilot の表示だけ
- アイコンと区切りの記号は、旧設定と同じ13個（文字コードで書いた）

### テーマを Nightfox から Gruvbox Dark Hard に変えた（Step 5.5）

**決めたこと**（ユーザー）
- Nightfox に飽きたので、比較ページ（Ghostty 同梱のテーマの色で描いたもの）で見比べて、Gruvbox Dark Hard にした
- Gruvbox は、基本の Gruvbox（Dark / Dark Hard）がいちばん対応が広い。Dark と Dark Hard は同じテーマのコントラストの設定違い

**やったこと**
- palette.nix を Gruvbox Dark Hard の値にした（Ghostty の Gruvbox Dark Hard と、Neovim の gruvbox.nvim の hard の値）。tmux・sketchybar・starship・lazygit・fzf・delta の背景は、これで自動で変わる
  - 名前（bg0〜bg4 など）は Nightfox の頃の役割の名前のまま。bg1 が通常の背景 `#1d2021`、bg0 はバーなどの少しだけ違う背景 `#282828`
  - 差分の背景: 行の中で変わった部分は gruvbox.nvim の DiffAdd / DiffDelete と同じ色、行全体はそれより控えめな色
- Ghostty: テーマを `Gruvbox Dark Hard` に
- Neovim: nightfox.nvim をやめて gruvbox.nvim（ellisonleao）に。`contrast = "hard"`
- delta: 構文の色は bat に最初から入っている `gruvbox-dark`（nightfox.tmTheme を入れていた設定は外した）

**確認したこと**
- Neovim の背景が `#1d2021`（Ghostty と同じ）。delta の出力の色が Gruvbox（追加 `#343722`・削除 `#3e2624`、構文は黄・aqua・緑）
- sketchybar は読み込み直して新しい色に

**注意**
- 開いている tmux・Ghostty・Neovim は、読み込み直すまで前の色のまま（tmux は prefix + r、Ghostty は ⌘⇧,、Neovim は開き直す）
- Claude Code は自由な配色の設定がない。`/config` のテーマで「ANSI の色だけを使う」ダークを選ぶと、ターミナル（Ghostty）の16色になる

### sketchybar の右側も、いったん旧環境と同じにした（Step 5.5）

- 右側をどう作り直すかイメージしにくいので、まず旧設定の右側をそのまま持ってきて、色だけ Nightfox にした（ユーザーの希望）。見てから直す
- 項目と順番は旧設定と同じ: 日付と時刻・バッテリー・Wi-Fi・音量・統計の表示切り替え・Docker・git ブランチ・CPU・メモリ・通信量。最初に作った時刻の島（clock.lua・island.lua）は外した
- 音量を押したときの出力先の切り替えに使う SwitchAudioSource は nixpkgs から（switchaudio-osx）
- CPU・メモリ・通信量の数値を送る常駐の統計プログラム（sketchybar-system-stats の `stats_provider`）は nixpkgs にない。とりあえず旧環境の Homebrew 版と起動設定（`com.sketchybar.stats-provider`）を、止めていたのを戻して使っている。→ 2026-10-11 に Nix でビルドして切り替えた

**注意**
- git ブランチの項目は旧設定のまま WezTerm 専用（WezTerm に今のペインのフォルダを聞く）。Ghostty では表示されない
- Docker の項目は `/usr/local/bin/docker`（Docker Desktop が置くもの）を使う。OrbStack に移るときに見直す

### sketchybar の左側を旧環境と同じにした（Step 5.5）

**やったこと**
- ユーザーの希望で、左側（Apple ロゴ・アプリのメニュー・スペース番号・今のアプリ）は、ゼロから作り直すのをやめ、旧設定（`~/.config/sketchybar`）のファイルをそのまま持ってきた。変えたのは色だけ
  - 色: 旧設定のコードは Catppuccin の色の名前（`subtext0` など）を使っているので、名前はそのままにして、同じ役割の Nightfox の色を割り当てた（`sketchybar/colors.lua`。tmux と同じ対応）
  - ファイルの場所を指す行だけ直した（`$CONFIG_DIR/helpers/menus/bin/menus` → `sketchybar-menus`、`~/.config/sketchybar/helpers` → `$CONFIG_DIR/helpers`）。それ以外は旧設定と1文字も違わない
  - バー全体と共通の見た目（高さ・余白・枠など）も旧設定の compact と同じ値にした
- アプリのメニューを読む小さなプログラム（`helpers/menus/menus.c`）は、旧設定では起動のたびに `make` していたが、Nix でビルドする（`sketchybar-menus`）。アクセシビリティの許可が要る
- 右側の島の形は、今のところ時刻だけ残している

**旧設定から変えたところ**（ユーザーの希望）
- アプリのアイコン: 旧設定の sketchybar-app-font-bg（背景付きのアイコン）ではなく、最初に作った版と同じ nixpkgs の sketchybar-app-font と、同じパッケージの対応表を使う。旧設定のフォントでは正しく表示されなかった（原因は特定できていない。フォントの中には対応表の名前が入っていた）
- 今のアプリ: 旧設定は名前だけだったが、名前の左にアプリのアイコンを出す
- スペース番号とアプリのメニューを入れ替えるスイッチは外し、代わりに今のアプリのアイコンを押すと入れ替わるようにした。アイコンと名前は別の項目にして、名前を押したときは旧設定と同じくメニューのポップアップが出る

**確認したこと**
- アイコンを押すとスペース番号が消えてアプリのメニュー（Ghostty・File など）が並び、もう一度押すと戻る。メニューを出している間もアイコンは残る

### yabai と skhd を Nix に移した（Step 5.5）

**やったこと**
- yabai（7.1.25）と skhd（0.3.9）を、本体・設定・起動ともに Nix（home-manager）で管理するようにした。版は Homebrew と同じ
- 設定は `~/nix-config/yabai/yabairc` と `~/nix-config/skhd/skhdrc`。中身は旧設定と同じ（コメントだけ日本語にした）
- 起動は home-manager の launchd の起動設定（`org.nix-community.home.yabai` / `.skhd`）。ログは `~/Library/Logs/yabai`・`~/Library/Logs/skhd`
- Homebrew の起動設定（`com.asmvik.yabai` / `com.koekeishiya.skhd`）は止めて、`launchctl disable` で次のログインでも起動しないようにした。plist は消していない
- skhd の再起動キー（`ctrl+alt+r` / `ctrl+alt+s`）は、旧設定の `--restart-service`（Homebrew の起動設定が対象）から、新しい起動設定を `launchctl kickstart -k` で再起動するものに変えた

**なぜこうしたか**
- デスクトップは1つなので、tmux や Neovim のように旧環境と Nix 環境で分けることはできない。どちらのタブでも、この yabai・skhd が動く。設定の中身は同じなので、体感は変わらない
- 計画では「envswitch で常駐ツールを選んだ側の設定で再起動する」としていたが、設定が同じなのに切り替えるのは手間だけなのでやめた
- 起動時に `-c` で設定を指定する。指定しないと、launchd から起動したとき旧環境の `~/.config/yabai`・`~/.config/skhd` を読む
- yabairc・skhdrc の中で yabai コマンドを呼ぶので、起動設定に Nix のコマンドの PATH を入れた。skhd のキーのコマンドは `$SHELL` で動くので、`SHELL=/bin/sh` にした（zsh だと ~/.zshenv の envswitch まで読むため）

**確認したこと**
- Nix の yabai・skhd が動いている。yabai の設定値（bsp・隙間 8・alt でドラッグ・ルール 8 件）が旧設定と同じ
- 新しい本体に「アクセシビリティ」の許可を出したあと、skhd がエラーなく動き続けている

**注意**
- Nix で yabai・skhd の版が上がると、本体の場所（/nix/store/...）が変わるので、アクセシビリティの許可を出し直す必要がある
- Homebrew に戻すとき: `launchctl enable gui/$(id -u)/com.asmvik.yabai`（skhd も同じ）→ `yabai --start-service`。そのうえで home.nix から yabai・skhd を外す

### 配色の統一の残り: delta・fzf・lazygit・starship（Step 5.5 の始め）

**やったこと**（nix 環境だけ）
- delta: 構文の色を Nightfox に（nightfox.nvim に付いている `nightfox.tmTheme` を bat に入れ、delta はそれを使う）。追加・削除の行の背景は Neovim の差分と同じ色にした
- fzf・lazygit・starship: 色を palette.nix から当てた（どの部品に何色を使うかは、それぞれの既定と同じ考え方）
- palette.nix に差分の背景の色（diff_add など。nightfox.nvim の DiffAdd などと同じ値）を足した
- bat も入った（delta が配色を読むため）。bat の設定とキャッシュは nix 環境の場所（`~/.config-nix/bat`・`~/.cache/bat`）で、旧環境には bat がない

**なぜこうしたか**
- starship・lazygit は、もともと端末の16色（Ghostty の Nightfox）で表示されていたので、見た目はほぼ Nightfox だった。ただ、色の定義を palette.nix の1か所に集めるため、明示した
- 本当に揃っていなかったのは delta だった（構文は Monokai、背景は256色の暗い赤・緑で固定）。fzf も一部で16色以外の色を使っていた

**確認したこと**
- delta の出力の色を数えると、追加 `#26343c`・削除 `#2f2837`、構文は `#63cdcf`（cyan）・`#81b29a`（green）など Nightfox の色
- lazygit が起動し、枠が palette の色になる（前回のように設定の誤りで起動しないことがないか、起動まで確かめた）

**注意**
- `delta --show-config` で配色が「Catppuccin Macchiato」と出るが、nightfox.nvim の `nightfox.tmTheme` の中の名前が誤ってそうなっているだけで、中身の色は Nightfox

## 2026-10-10

### mlb-app は devShell の対象外にした（Step 5）

- coffee-app と同じ構成（Node 20・Python 3.13）だったが、devShell は置かないことにした（ユーザーの判断）。mlb-app には何も変更していない

### gh を Nix で管理した（Step 5）

- nix 環境では設定の置き場所が `~/.config-nix` に変わるので、gh が旧環境の `~/.config/gh` を読まず、ログインしていない扱いになっていた
- `programs.gh` で入れた。トークンはファイルではなく macOS のキーチェーンにあるので、`hosts.yml` にユーザー名を書くだけで旧環境と同じトークンが使われる（ログインし直しは不要）
- 接続は SSH（`git_protocol: ssh`）。旧設定の別名 `gh co`（`pr checkout`）も引き継いだ
- git の HTTPS の認証にも gh を使うようにした（`gh auth git-credential`）。coffee-app のように HTTPS のリモートでも、nix 環境の git から push できる
- 確認: nix 環境で `gh auth status` がログイン済み、`gh api user` が通る、coffee-app のリモートに git でつながる。旧環境の gh はこれまでどおり（HTTPS）

### bufferline の見た目を旧環境に合わせた（Step 4 の手直し）

- 旧環境と比べると、選んでいるタブは名前の部分だけ背景が明るく、まわりの余白・アイコン・区切りは暗いままで、まだらに見えていた
  - 旧環境では Catppuccin の「背景を透明にする」設定と、アイコンの背景を揃える細工（`after/plugin/highlights.lua`）で揃っていたが、どちらも移していなかった
- bufferline の全部品の背景を揃えた: 選んでいるタブは通常の背景（bg1）、ほかのタブと余白は暗い背景（bg0）。斜めの区切りは bg0 の色で、タブの形だけが見える
- 確認: 旧環境と今の Neovim を並べて開き、タブの行の色を1文字ずつ取り出して比べた

### プロジェクトごとの環境: direnv と coffee-app の devShell（Step 5 の始め）

**やったこと**
- nix 環境に direnv と nix-direnv を入れた。プロジェクトのフォルダに入ると、その `.envrc`（flake.nix の devShell）の環境に自動で切り替わる
  - 旧環境には direnv がないので、プロジェクトに `.envrc` を置いても旧環境の動きは変わらない
- coffee-app に `flake.nix`・`flake.lock`・`.envrc` を置いた（PR #1 でマージ済み、`46cc0c4`。CI も Node 22 で通過）
  - devShell: Node.js 22・Python 3.13・uv・mongosh。MongoDB などのサービスは Docker Compose のまま
  - `.envrc` は `.venv` がなければ uv で作り、`fastapi-service/requirements-dev.txt` を入れる
- coffee-app の Dockerfile（frontend・backend）と CI の Node.js を 20 から 22 に上げた

**なぜこうしたか**
- 開発環境の定義はプロジェクトに置いた（プロジェクトと一緒に版が管理され、clone すれば同じ環境になる）
- Node.js 20 は 2026-04 にサポートが終わり、nixpkgs からも削除されていた。devShell だけ 22 にすると手元と本番で版がずれるので、Docker・CI も 22 に揃えた
- coffee-app は作業中のブランチ（feat/k8s-bootstrap、未コミットの変更あり）だったので、触らずに git worktree で main から別のフォルダを作って作業した

**確認したこと**（devShell の Node 22 で、coffee-app の CLAUDE.md が求めるテスト）
- backend: 型チェック成功、テスト 580 件成功 / frontend: lint・テスト 368 件・ビルド成功 / fastapi: pytest 10 件成功
- Docker: backend・frontend の dev・prod の4イメージが Node 22 でビルドできた
- direnv: `direnv allow` で `.venv` が作られ、node と python が Nix の版になる

**注意**
- coffee-app の既存のコミットは旧環境の設定（icloud のアドレス・署名なし）。nix 環境でコミットすると noreply のアドレス・署名ありになる
- ~/coffee-app の `.venv` は、pyenv の Python で作られ、スクリプトが mlb-app の `.venv` を指していた（mlb-app からコピーされたもの）。マージ後に Nix の Python 3.13 で作り直した。旧環境の pyright もこの `.venv` を読むが、Python の場所が変わっただけなのでそのまま使える
- この `.venv` の Python は Nix のストアにある。~/coffee-app で direnv が一度動くまでは、ガベージコレクション（`nix-collect-garbage`）から守られていない。作業ブランチ（feat/k8s-bootstrap）には `.envrc` がないので、main を取り込んで `direnv allow` するまで、ガベージコレクションはしない
- nix 環境の gh はログイン情報を見つけられない（設定の置き場所が `~/.config-nix` に変わるため。ログイン情報は旧環境の `~/.config/gh` にある）。PR は `GH_CONFIG_DIR=~/.config/gh` を付けて作った。→ 2026-10-11 に gh を Nix で管理して解消

## 2026-10-09

### Neovim に nvim-ts-autotag を入れた（Step 4）

- HTML・JSX のタグを自動で閉じ、開きタグを書き換えると閉じタグも揃える（vim.pack）
- 確認: HTML で `<p>` → `<p></p>`、TSX で `<div>` を `<section>` に変えると `</div>` も `</section>` になる
- これで計画の Neovim のプラグインはすべて入った

### Neovim にインデント表示・treesitter-context・ccc・zen-mode・no-neck-pain を入れた（Step 4）

**やったこと**（nix 環境だけ。どれも vim.pack）
- インデントの縦線: 旧設定と同じく snacks.nvim の indent を使う（snacks のほかの機能は使わない）。今いるかたまりの線は目立たせる
- treesitter-context: 画面上部に、今いる関数やブロックの見出しを出す（最大3行、低いウィンドウでは出さない。旧設定と同じ）
- ccc: `#ff0000` などの色コードをその色で表示。`<space>cp` で色を選んで書き換える
- zen-mode（`<space>tz`）: 1つのウィンドウを中央に大きく出す。設定は旧設定と同じ
- no-neck-pain（`<space>tn`）: 左右に余白を足して本文を中央に寄せる。余白の色は Nightfox の bg0
- which-key に「表示」（`<space>t`）のグループを足した

**なぜこうしたか**
- Neovim 0.12 から、LSP が返す色の表示が標準で付いた。ccc（LSP の色も表示する）と二重になるので、標準のほうを止めた
- zen-mode の twilight 連携は、計画どおり twilight を使わないので切った

**確認したこと**
- palette.nix を開くと、22色すべてに色が付く
- 関数の途中までスクロールすると、上に `require("gitsigns").setup({` と `on_attach = function(bufnr)` が出る
- `<space>tn` で左右に余白が出て、`<space>tz` で中央に大きく出る

**注意**
- treesitter-context は、画面の一番上とカーソルの間に見出しを出す。カーソルが画面の一番上にあると出ない（最初、これを知らずに「動かない」と調べてしまった）

### Neovim に bufferline・noice・which-key・trouble・lazygit.nvim を入れた（Step 4）

**やったこと**（nix 環境だけ。どれも vim.pack）
- bufferline: 開いているファイルを上にタブのように並べる。`<Tab>` / `<S-Tab>` で切り替え、`<space>bd` で閉じる。見た目は旧設定のまま色を Nightfox に
- noice（と nui・nvim-notify）: コマンド入力を画面中央に出し、メッセージは右上の通知にする。アイコンと位置は旧設定と同じ
- which-key: `<space>` などを押して少し待つと、続けて押せるキーの一覧が出る。グループ名は日本語にした
- trouble: 診断・参照・シンボルの一覧を右側に出す。キー（`<space>xx` など）は旧設定と同じ
- lazygit.nvim: `<space>gg` で lazygit、`<space>gf` でこのファイルの履歴
- 長い設定（bufferline・noice）は `nvim/lua/ui.lua` に分けた

**なぜこうしたか**
- 関数の引数の説明は blink.cmp が出しているので、noice では出さないようにした（二重になる）
- 旧設定の fugitive（`<space>gs` など）は計画どおり入れない。git の操作は lazygit と gitsigns に任せる
- noice がコマンド入力の色付けに regex のパーサを使うので、treesitter の言語に足した

**直したこと**
- lazygit が起動していなかった。lazygit を入れたときに書いた設定（`git.pagers`）は古い名前で、lazygit 0.66 は `git.diffRenderers` を使う。lazygit は設定を自動で書き直そうとするが、Nix が置いた設定は書き込めないのでエラーで止まっていた。名前を直した
  - 入れたときは版の確認しかしておらず、起動までは確かめていなかった

**確認したこと**（実際の画面で）
- 2つのファイルを開くと上にタブが出る。`:` で中央に入力欄が出る。`<space>` で一覧が出る。`<space>xx` で型エラーの一覧が出る。lazygit が開き、diff は delta で出る

### Neovim に conform・gitsigns・lualine・autopairs を入れた（Step 4）

**やったこと**（nix 環境だけ。どれも vim.pack）
- conform: 保存時に整形する。prettier（JS/TS/JSON/CSS/HTML/Markdown/YAML）、ruff（Python）、stylua（Lua）。ないものは LSP の整形。`<space>f` で手動整形
  - prettier と stylua は nixpkgs から入れた（Neovim の中だけで見える）。プロジェクトの node_modules に prettier があれば、そちらが使われる
- gitsigns: 行の左に git の変更を表示。記号とキー（`]h` `[h`、`<space>h` + s / r / S / R / p / b / d / D）は旧設定と同じ
  - 旧設定の `next_hunk` などは古い書き方なので `nav_hunk` に直した。`<space>hu`（ステージの取り消し）は、`<space>hs` をもう一度押すことで取り消せるようになったのでなくした
- lualine: 旧設定の見た目（モードで色が変わる左右の三角、ブランチ・変更行数・ファイル名・診断・種類・位置）をそのままに、色を Nightfox にした。長いので `nvim/lua/statusline.lua` に分けた
  - 色は palette.nix から Lua のファイル（`~/.local/share/nvim-nix/site/lua/palette.lua`）を作り、`require("palette")` で読む。色の定義は palette.nix の1か所のまま
  - 旧設定の Copilot の表示は計画どおり外した
- autopairs: 括弧や引用符を自動で閉じる

**確認したこと**
- TS・Python・Lua の崩したファイルを保存すると、それぞれ整形される
- 変更した行に `▎` が出て、ステータスラインに変更行数と診断の数が出る
- `print(` で `print()` になる

**注意**
- autopairs は文字列の中でも括弧を閉じる。旧設定の `check_ts`（文字列の中では閉じない）は、今の nvim-treesitter では効いていなかったので外した

### Neovim に nvim-tree を入れた（Step 4）

**やったこと**（nix 環境だけ）
- ファイルツリーの nvim-tree と、アイコンの nvim-web-devicons を vim.pack で入れた
- 旧設定と同じ: `<space>e` で開閉、右側、幅 25、中身が1つだけのフォルダは1行にまとめる
- 標準のファイル一覧（netrw）は止めた（`:Ex` は使えなくなる。`nvim .` では nvim-tree が開く）

**なぜこうしたか**
- `<space>e` で開いていたのに何も起きず不便だったため
- nvim-tree の説明書どおり、netrw は起動の最初に止める。止めないと両方が動いてしまうことがある
- 旧設定の色の上書き（`after/plugin/highlights.lua`）は Catppuccin 用なので持ってこない。Nightfox は nvim-tree の色を持っている

### Neovim に補完（blink.cmp）を入れた（Step 4）

**やったこと**（nix 環境だけ）
- blink.cmp を入れた。候補は LSP・スニペット・パス・バッファの単語。候補の説明と、関数の引数の説明も出る
- スニペット集 friendly-snippets を vim.pack で入れた
- キー: Enter で確定、Tab / S-Tab で候補を上下（スニペットの中では次・前の入力欄へ）、C-Space で開く、C-e で閉じる

**なぜこうしたか**
- 旧設定の nvim-cmp は部品が8つ（cmp-nvim-lsp・cmp-buffer・cmp-path・cmp-cmdline・LuaSnip・cmp_luasnip・lspkind など）に分かれていた。blink.cmp は1つでこれらを持っていて、計画どおり置き換えた
- blink.cmp はあいまい検索の部品が Rust で、コンパイル済みのものが要る。treesitter と同じく nixpkgs から入れた（vim.pack だと GitHub からダウンロードする）
- 候補の1つ目が選ばれた状態で開くので、Enter だけで1つ目を確定できる（VS Code と同じ）。旧設定では Tab で1つ目に移っていたが、今は Tab で2つ目に移る

**確認したこと**
- `:checkhealth blink.cmp`: コンパイル済みの部品が読み込まれている
- TypeScript で `console.lo` と打つと `log` などの候補と MDN の説明が出て、Enter で `log()` が入り、引数の説明が出る

### Neovim に LSP を入れた（Step 4）

**やったこと**（nix 環境だけ）
- 言語サーバーを nixpkgs から入れた（`programs.neovim.extraPackages`。Neovim の中だけで見え、シェルの PATH には出ない）
  - vtsls（TypeScript）、vscode-langservers-extracted（HTML・CSS・JSON・ESLint）、tailwindcss、emmet、basedpyright と ruff（Python）、lua_ls、nixd（Nix）
- 起動方法の定義は nvim-lspconfig（vim.pack）から取り、`vim.lsp.config` / `vim.lsp.enable` で有効にした
- 旧設定から変えたもの:
  - ts_ls → vtsls、pyright → basedpyright（計画どおり。どちらも VS Code に近い機能）。basedpyright の型チェックは旧設定と同じ basic に下げた
  - ruff と nixd を新しく足した。ruff の説明（K）は basedpyright と重なるので切った
  - サーバーの設定は、既定と同じ値を書き写していたものを消し、違うところだけ残した（tailwind の classFunctions など）
- キー: Neovim 0.11 から既定で使えるもの（K・grn・gra・grr・gri・[d ]d など）は自分では割り当てない。旧設定の gr / gi / `<leader>rn` / `<leader>ca` はこれに置き換わる。残したのは gd・gD・`<leader>gl`
- 診断: 印のアイコンは旧設定と同じ（Nerd Font。文字コードで書いた）。浮かぶウィンドウは `winborder` で角の丸い枠にした

**確認したこと**（試しのファイルを開いて、サーバーがつながり診断が出るか）
- TypeScript: vtsls が型エラーを出す / Python: basedpyright と ruff / Lua: lua_ls / Nix: nixd / HTML・CSS・JSON: それぞれのサーバー
- ESLint は ESLint の設定があるプロジェクトでだけ動く

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
