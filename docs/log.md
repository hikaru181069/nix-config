# 環境構築の記録

Nix で開発環境を作り直す作業の記録。新しいものが上。
全体の計画は `/Users/Shared/nix-env-plan.md`。

---

## 2026-11-26

### sora の背景を、少し青寄りにして、少し暗くした

- 元の #0e1018 は色み 274°（青と紫の間）で、少し紫っぽく見えた（ユーザーの指摘）。明るさと鮮やかさはそのままで、色みだけ 250°（青寄り）にした #0b1118。文字と背景の差はほぼ同じ（12.26 → 12.24）
- テーマのファイルの bg と差分の背景、Neovim（sora の setup の on_colors で背景を上書き）、bat の背景を変えた
- 続けて、少し暗くした #070b11（明るさ 0.85 倍。文字と背景の差 12.24 → 12.73。真っ黒のバーとの差は 1.11 → 1.06 と小さくなる）
- 同じ暗さで、色みを無くした灰色 #0b0b0b も試したが、青寄りの #070b11 に決めた

### sora のバーの地を真っ黒にした

- bg_bar を #0a0c12 から #000000 にした（MacBook のノッチと境目がなくなる。ユーザーの希望）
- Xcode Dark HC と同じく、バーの上の文字も暗くする（darkenBarText）・情報の文字だけ 40% にする（barTextDarken）も試したが、取りやめた（barTextDarken の仕組みも消した）。関数の帯は、sora の浮かぶ窓の色がもともと #0a0c12 なので、上書きしなくても前のバーの色のまま
- 続けて、選んでいないもの（text_comment）と休んでいるアイコン（text_fg_muted）だけ 45% 暗くした（darkenBarInactive = true。お試し）。情報の文字とアイコンは元の色のまま
- Neovim のタブの行の、ほかのタブの名前・番号（tab_inactive_fg。ほかのバーの選んでいないもの text_comment と同じ色にそろえた）と、色付きのファイルの種類のアイコンも 45% 暗くした。アイコンは bufferline が種類ごとに作る色（BufferLineDevIcon〜。選んでいるタブ用の …Selected は除く）を、元の色からバーの地に寄せた色に置きかえる（ファイルを開くたび・テーマを読みこみ直すたびに付け直す。nvim/lua/ui.lua）。palette.nix に数（tab_inactive_darken）が入ったので、sketchybar の色の読みこみと三角の画像づくりは「#」で始まる色だけを扱うようにした

### Xcode Dark HC だけ、バーの色と関数の帯の色を入れかえた（お試し）

- 関数の帯（treesitter-context。スクロールしたとき、今いる関数の始まりの行を上に固定する部品）は、浮かぶ窓と同じ色で、Xcode では黒（#07080d）だった
- このテーマだけ、bg_bar を #07080d（黒）に、関数の帯を前の bg_bar（#17171b）にした（ユーザーの希望）。続けて bg_bar を真っ黒（#000000）にした。このテーマは文字のコントラストが高いので、バーの灰色の暗さも 0.45 → 0.55 にした（テーマのファイルに barDarken を書けるようにした。書いていないテーマは 0.45）。さらに、バーの地の上の文字とアイコン（情報の文字・選んでいないタブやデスクトップ・休んでいるアイコン）も同じだけ暗くした（darkenBarText = true。palette.nix の text_〜。書いていないテーマは元の色のまま）。Neovim のタブの行（bufferline）の文字も同じく暗くしてみたが、ほかのタブの名前がほぼ見えなくなったので、元に戻した。nvim/init.lua の extra_themes に、colorscheme のあとに上書きする色（highlights）を書けるようにした

### テーマに Xcode Dark HC・Xcode WWDC を足した（全部で66個）

- vim-colors-xcode の別の種類（xcodedarkhc・xcodewwdc）。Ghostty の Xcode Dark hc・Xcode WWDC と、背景・文字の色が一致
- 色の表・bat は前と同じやり方で作り、2つとも不透明・半透明でタブの行とツリーのカーソル行のつながりを確かめた。WWDC は、ターミナルの青が紫寄り

### テーマに Xcode Dark を足した（全部で64個）

- VS Code の macOS Modern Theme（davidbwaters/macos-modern-vscode-theme）は、コードの色分けが Xcode の配色なので、Neovim の定番の Xcode の配色（lunacookies/vim-colors-xcode の xcodedark）を足した（ユーザーの希望）
- Ghostty の Xcode Dark と背景が一致（#292a30）。色の表・bat は前と同じやり方で作り、不透明・半透明でタブの行とツリーのカーソル行のつながりを確かめた
- Xcode のターミナルの色は、水色の役が紫寄り（公式のまま）

### 自作のテーマ Outrun Electric も足した（全部で63個）

- Night より背景が暗い種類（背景 #0c0a20・バー #090819・文字 #f2f3f7）。元のテーマどうしの違いは、この3色だけ（コードの色分けは同じ）
- Neovim の配色を nvim/lua/outrun.lua に1つにまとめ、nvim/colors/outrun-night.lua・outrun-electric.lua は種類の名前を渡して呼ぶだけにした（同じことを2回書かない。色の調整も1か所）
- bat/outrun-electric.tmTheme・themes/outrun-electric.nix も、Night と同じやり方で作った

### 自作のテーマ Outrun Night を足した（全部で62個）

- VS Code の Outrun Night Meets Synthwave（edevars/outrun-meets-synthwave。2021 年で止まっていて、ライセンスのファイルが無い）の色を参考に、ファイルは写さず自分で書いた（ユーザーの希望）
- Neovim: nvim/colors/outrun-night.lua（自作の colorscheme。のちに中身を nvim/lua/outrun.lua にまとめた）。画面の部品は VS Code の画面の色、コードの色分けは VS Code の決まり（scope）を Neovim の同じ意味の色分け（treesitter の @〜 と昔からの名前）に当てはめた。カーソル行は元のテーマが背景と同じなので、背景に文字の色を 7% 混ぜた。関数の呼び出しは、元のテーマと同じく色を付けない
- bat: bat/outrun-night.tmTheme。VS Code と bat は同じ決まり（TextMate）なので、色分け57個をそのまま当てはめた
- テーマのファイル: themes/outrun-night.nix。元のテーマに本当の緑が無い（ターミナルの緑も青系）ので、緑の役には git の追加行の色（#a7da1e）、赤の役には差分の削除の赤（#e61f44）を当てた（ターミナルの赤はピンク）
- 背景がもっと暗い種類（Outrun Electric。背景 #0c0a20）もある。コードの色分けは同じ

### Synthwave 系のテーマを3つ足した（fluoromachine・synthweave・laserwave。全部で61個）

- VS Code の Outrun Meets Synthwave の Neovim 版は無かった（元のテーマも 2021 年で止まっている）ので、似た雰囲気のものを足した（ユーザーの希望。あとで自分で作るかも考える）
- fluoromachine: maxmx03/fluoromachine.nvim。光る効果（glow。背景に色が付く）は、ほかのテーマとの統一が崩れやすいので切った。青に当たる色が無いので、紫を青に当てた。コメントの色が暗い（地との差 2.2。公式のまま）
- synthweave: samharju/synthweave.nvim（VS Code の Synthwave '84 の移植）。青と水色はどちらも水色系（元も同じ）
- laserwave: lettertwo/laserwave.nvim（VS Code の LaserWave の移植）。ターミナルの赤はピンク寄り
- 3つとも Ghostty に入っていない（Ghostty の Laser は別の色）ので、palette の色を直接使う。fluoromachine と synthweave はプラグインがターミナルの色を持たないので、プラグインの色の表から当てた
- 色の表・bat は前と同じやり方で作り、3つとも不透明・半透明でタブの行とツリーのカーソル行のつながりを確かめた

### Neovim のステータスラインの細い区切りを、間にだけ出すようにした

- 右のかたまりの左端の区切りを消した（tmux・sketchybar の右側と同じく、端には区切りを置かない。ユーザーの希望）
- ほかの区切りも、隣に中身があるときだけ出す（cond）: ブランチの右（git の中だけ）・変更行数の右（変更があるときだけ）・ファイル名の右（診断があるときだけ）・ファイルの種類の右（種類があるときだけ）。前は、変更が無いと「main ›› flake.nix」のように区切りが2つ並び、診断が無いとファイル名の右に区切りが浮いていた
- 変更行数は gitsigns の数を使う（区切りの条件と表示をそろえるため）

### Neovim のステータスラインの、両端以外の文字をふつうの太さにした

- ブランチ・変更行数・ファイル名・診断・ファイルの種類・位置（%）を、太字からふつうの太さにした（ユーザーの希望。sketchybar の情報の文字と同じ）。両端のブロック（モード・行:列）は太字のまま

### 3つのバーの情報の文字とアイコン（fg_dim）も 45% 暗くしてみたが、戻した

- バーの地の上の文字なので読みにくくなり（文字と地の差が 3 未満のテーマが 0 → 25）、ユーザーの判断で元の fg_dim に戻した

### 3つのバーの灰色のブロックを、全テーマ共通で暗くした（お試し。一段階）

- palette.nix に block_fg・block_fg_dim・block_fg_muted を足した。fg・fg_dim・fg_muted をバーの地（bg_bar）に barDarken（0.15・0.3・0.4・0.45・0.5 を見比べて、0.45 に決めた）。今アクティブなものの間の三角だけさらに暗くしてみたが、間の三角（fg_bright）は左の番号のブロック（fg）とほぼ同じ明るさで（9テーマは同じ色）、2% 下げるだけで14テーマで左のブロックより暗くなったので、やめた。終わりの三角も、中身のブロックとほぼ同じ明るさのテーマがあり、下げられないだけ寄せた色で、全テーマ共通の計算
- tmux（ユーザー名・今のタブの番号とフォルダ名）、sketchybar（今のデスクトップの番号とアプリ・今のアプリの帯）、Neovim（NOR）のブロックとその三角を、この色にした。ブロックの中の文字の色はそのまま
- 暗さは palette.nix の barDarken の数字1つで変えられる（好みを探すため。ユーザーの希望）
- 細い区切りの線（tmux のタブの中・5つのアイコンの間、sketchybar のデスクトップの間・右側の項目の間、Neovim のステータスラインの間）も、同じだけ暗くした（block_comment）。選んでいないタブの文字など、線以外の comment はそのまま
- 今アクティブなもの（今のタブ・今のデスクトップ）の、ブロックより明るい三角（間の fg_bright・終わりの comment）も、同じだけ暗くした（block_fg_bright・block_comment）
- ブロックの中の文字とアイコンも同じだけ暗くした（今のタブ・今のデスクトップの番号 fg_muted → block_fg_muted、フォルダ名・アプリのアイコン fg_bright → block_fg_bright）。名札（ユーザー名・今のアプリの帯・NOR）の文字はバーの地の色なので変わらない。Claude Code の ● は意味のある色なのでそのまま

### テーマを4つ足した（atom-one-dark・doom-one・github-dark・github-dark-colorblind。全部で58個）

- GitHub Dark Dimmed に色が近いもの（Ghostty に入っている全テーマから探した）で、まだ入れていなかったもの全部（ユーザーの希望）
- atom-one-dark: onedark.nvim の dark（Atom の元祖 One Dark）。今の OneDark darker と同じプラグインで、colorscheme の名前が onedark なので、extra_themes で setup（style = "dark"）と colorscheme を書いた。Ghostty 版の背景（#21252b）を Neovim 版（#282c34）にそろえた
- doom-one: NTBBloodbath/doom-one.nvim
- github-dark・github-dark-colorblind: 今の GitHub と同じプラグインの別の種類。github-dark はプラグインの背景が #30363d（GitHub の灰色の7番目）で、Ghostty 版（#101216）とまったく違うので、Neovim 版にそろえた（ほかの GitHub の種類より明るい灰色の背景）。colorblind は赤がオレンジ寄り・緑が青寄り（赤と緑を見分けやすくした、わざとの色）
- 色の表・bat は前と同じやり方で作り、4つとも不透明・半透明でタブの行とツリーのカーソル行のつながりを確かめた

### 6つのテーマの fg_muted を、comment より暗くした

- 今アクティブなもの（tmux の今のタブ・sketchybar の今のデスクトップ）の終わりの三角（comment）は、ブロック（fg_muted）より一段明るい決まり。Carbonfox・Nightfox は comment のほうが暗く、Aura・Miasma・Modus Vivendi・Nord は同じ色で、三角が暗く見えたり見えなかったりした（ユーザーの指摘）
- この6つの fg_muted を、ほかのテーマと同じ計算（コメントの色を背景に 20% 寄せる）にした。決まりは変えていない。この6つでは、fg_muted を使う所（今のタブのフォルダ名のブロック・今のデスクトップのアプリのブロック・休んでいるアイコンなど）が少し暗くなる

### テーマを2つ足した（kanso-ink・jellybeans。全部で54個）

- sora に色が近いもの（Ghostty に入っている全テーマから、背景・文字・主な色の近さで探した）から、ユーザーが選んだ
- kanso-ink: Kanso の ink（zen より少し明るい種類）。kanso-zen と同じプラグイン
- jellybeans: WTFox/jellybeans.nvim（元の nanotech/jellybeans.vim は 2020 年で止まっているので、今の Neovim 向けに書き直したもの）。Ghostty 版の背景（#121212）が Neovim 版（#151515）と違うので、ghosttyOverride でそろえた
- 色の表・bat は、前の18個と同じやり方で作った。2つとも、不透明・半透明でタブの行とツリーのカーソル行のつながりを確かめた

### Neovim のステータスラインの NOR のブロックを fg_dim にした

- fg_muted から fg_dim にした（ユーザーの希望。全テーマ）。tmux のユーザー名・sketchybar の今のアプリの帯と同じ「灰色の地に暗い太字」の形にそろい、fg_muted の地より暗い文字が読みやすい。ほかのモードの色はそのまま

### sketchybar の今のアプリの名前とアイコンを、tmux のユーザー名の文字と同じ暗い色にした

- fg_bright から bg_bar にした（ユーザーの希望。全テーマ）。帯と合わせて、tmux のユーザー名のブロックと同じ見た目になる
- 名前も太字にした（tmux のユーザー名と同じ。sketchybar でここだけ太字）

### Neovim のステータスラインのファイルの種類のアイコンを、種類ごとの色に戻した

- 3つのバーの色をそろえたとき文字と同じ色（colored = false）にしたが、種類ごとの色にした（ユーザーの希望。タブの行やツリーのアイコンと同じ）。文字は fg_dim のまま

### sketchybar の塗りの三角を、文字から画像にした

- 文字の三角は、大きさを合わせても sketchybar が背景より約 0.75pt 下に描き、下の角が帯からはみ出していた（位置は 1pt 単位でしか動かせず、1 上げると上にはみ出す。バーの高さを 39 にしても同じ）
- home.nix が palette のすべての色で、右向き・左向きの三角の画像（26 × 50px。8 倍で描いて縮め、斜めの辺をなめらかに）を作り、sketchybar/helpers/powerline.lua が画像を帯と同じ高さに置く。線だけの三角と、画像の無い色（透明など）は、今までどおり文字で描く
- 画像はとても小さく、sketchybar が読むのは最初の1回なので、重くはならない
- 画像にしても 0.5pt 下にずれ、帯の上の角が飛び出して見えた。帯（背景）は半端な位置（6.5pt）を切り捨てて 6pt に描かれ、帯と同じ高さの画像は 6.5pt に描かれるため。画像を 1pt 高く（26pt）して三角を上の 25pt に描き、6pt の位置に置かれるようにした

### sketchybar の三角が、帯からわずかに下にはみ出していたのを直した

- 三角の大きさを「帯の高さ ÷ 行の高さ（lineRatio）」で決めていたが、Lilex・JetBrains Mono・Blex Mono は三角の記号の実際の高さが行の高さより少し大きく（Lilex: 1.314 と 1.300）、三角が帯より約 0.3pt 大きく描かれていた（ユーザーの指摘）
- fonts.nix に三角の実際の高さ（arrowRatio。fontTools で測った）を足し、それで割るようにした。三角の真ん中と行の真ん中は、4つのフォントとも同じ位置
- それでも下の角が飛び出していた。ユーザーの画像を画素で測ると、三角全体が背景より約 0.75pt（画素 1.5 個）下に描かれていた。sketchybar の位置は 1pt 単位なので、三角を 1pt 上げた（y_offset = 1。ずれは 0.25pt 上になる）
- 1pt 上げると、今度は上の角が飛び出した。バーの高さ 38 では帯の上下の余白が 6.5 と半端なのが原因とみて、バーを 39 にして試したが、三角は同じく約 0.75pt 下にずれた（画素で測った）。半端さは原因ではなかったので 38 に戻した（39 だとウィンドウが 1pt 低くなり、Ghostty が 46 行から 45 行に減る）

### tmux のホスト名の文字を、セッション名と同じ comment にした

- どちらもバーの両端の名札なので、そろえた（ユーザーの希望。全テーマ）。その前に「情報の文字は fg_dim」で fg_dim にしていた

### sketchybar の今のアプリの帯を、tmux のユーザー名のブロックと同じ色にした

- 帯（と前後の三角）を bg_band から fg_dim にした（tmux のユーザー名のブロックと同じ。ユーザーの希望。全テーマ）
- 名前とアイコンは fg_bright（今のデスクトップのアプリのアイコンと同じ「今使っているもの」の色）。一度 tmux と同じ暗い文字にしたが、文字は変えないでほしいとのことで戻した。文字の太さは sketchybar の決まり（ふつう）のまま

### テーマごとの例外（tmuxUser・frontApp・tmuxPaneBorder）を消し、全テーマ同じ決まりにした

- ユーザーの希望。tmux のユーザー名のブロックは fg_dim、sketchybar の今のアプリの名前とアイコンは fg_dim、tmux の選んでいるパネルの区切り線は bg_band（全テーマ）
- 消した例外: tmuxUser（Rose Pine・GitHub の2つ・Iceberg・Flexoki。三角が明るすぎるのを抑えていたが、三角をブロックと同じ色にしたので理由が無くなっていた）、frontApp（GitHub の2つ・Material Darker・OneDark darker。帯の上で読みにくいのを明るくしていた）、tmuxPaneBorder（GitHub Dark Default。区切り線が目立つのを暗くしていた）
- GitHub Dark Default は、アプリの名前と帯の差が 2.2 で読みにくくなり、区切り線も明るめになる（承知のうえ）。例外を読みとる仕組み（home.nix・front_app.lua）も消した

### 3つのバー（Neovim・tmux・sketchybar）の文字とアイコンの色の決まりをそろえた（全テーマ）

- 区切りの線と、選んでいないもの: comment。情報の文字とふつうのアイコン: fg_dim。意味のある色（変更行数・診断・ベル・SYNC・警告）はそのまま
- 前は、情報の文字が Neovim は comment、tmux のホスト名は fg_muted、sketchybar は fg_dim で、3つとも違っていた（区切りだけそろえて、文字は比べていなかった）
- Neovim のステータスラインのファイルの種類のアイコンも、種類ごとの色をやめて文字と同じ色にした（lualine の colored = false）

### Neovim のステータスラインの、モードのブロックの隣の三角も、ブロックと同じ色にした

- tmux のセッション名・ユーザー名の三角と同じく（ユーザーの希望。全テーマ）。前は、ノーマルは comment、ほかのモードはブロックの色を白に4割寄せた色だった（lighten を消した）

### tmux のユーザー名のブロックの右の三角も、ブロックと同じ色にした

- セッション名の三角と同じく、三角だけ明るい色（fg。テーマで決めたものは comment）だったので、ブロックと同じ色にした（ユーザーの希望。全テーマ）。テーマのファイルの tmuxUser の arrow は消した（block だけ残る）

### tmux の prefix を押している間の、セッション名の右の三角を、ブロックと同じ色にした

- ブロック（cyan）より1段明るい色（cyan_light）にしていたが、三角だけ明るく見えるので、同じ色にした（ユーザーの希望。全テーマ）。cyan_light はここだけで使っていたので、テーマのファイルから消した

### テーマを18個足した（全部で52個）

- 新しいプラグイン: gruvbox-material・sonokai・nordic・modus-vivendi・mellifluous・miasma・oldworld・embark・everblush・mellow
- 今あるプラグインの別の種類: catppuccin-macchiato・catppuccin-frappe・tokyo-night-storm・tokyo-night-moon・rose-pine-moon・kanagawa-wave・terafox・duskfox
- Neovim は extra_themes の表に足した。表に、src を書かない（もう入れてあるプラグインの別の種類）・colorscheme（名前が違うもの）・name（リポジトリの名前が nvim や vim のもの）を書けるようにした
- 色の表（themes/）は、Neovim で読みこんだ実際の色と、Ghostty のテーマ（無いものはプラグインのターミナルの色や色の表）から機械的に作った（~/.cache の作業用のスクリプト。決まった色が無いものは計算し、テーマのファイルに書いた）。Ghostty 版と Neovim 版の背景は18個とも一致。bat は Neovim の実際の色から作った
- Sonokai は水色が無くターミナルの水色がオレンジ、Mellow は水色がピンク、Mellifluous・Miasma は色が少ない。公式の色のまま
- Neovim の差分の背景が明るすぎる Miasma・Embark・Mellow は、palette の色にした（diff = true）
- Modus Vivendi は背景が真っ黒で、バーの色の計算（黒に寄せる）が背景と同じになるので、Modus の bg_dim（#1e1e1e）にした
- テーマがツリーの部品（フォルダのアイコンなど）の背景を本文の色で決めていると、ツリーの中にその1マスだけ本文の色が見えた（Everblush）。ツリーの部品で背景が本文の色のものは背景を消し、ツリーのカーソル行が本文の色のもの（Gruvbox Material）は本文のカーソル行の色にした（どのテーマにも効く。fill_panel）
- 18個 × 不透明・半透明で、タブの行・ステータスライン・ツリーを開いたときのカーソル行のつながりを確かめた。前からあるテーマも変わっていない

### tmux の状態のアイコンの色を、sketchybar とそろえた

- 入っているときの ZOOM・COPY・HIDE を fg_bright から fg_dim に（sketchybar の通信速度と同じ2段階: 休み fg_muted / 動いている fg_dim）。ベルは黄からオレンジに（sketchybar の電池 40% 以下と同じ「注意」の色）。SYNC の赤はもともと同じ

### sketchybar の電池に、残りの「%」も出すようにした

- アイコンだけだったので、右に数字を足した（ユーザーの希望）。色はアイコンと同じ（40% 以下はオレンジ、20% 以下は赤）。CPU・メモリと同じく、文字の欄の幅は「100%」が入る 38 に決めて右寄せ。数字を出すので、読む間隔を 3分から 1分にした

### sketchybar の CPU・メモリ・通信速度の表示の幅を、いつも同じにした

- 数字の桁数で幅が変わり、左の項目が左右に動いていた（ユーザーの指摘）。文字の欄の幅（label.width）を決めて右に寄せた。CPU・メモリは「100%」が入る 38、通信速度は「1023 KB/s」が入る 77（このフォントの1文字の幅は大きさ × 0.6。13 で 7.8 に、左右の余白 3 ずつ）
- 通信速度は、100 MB/s 以上は小数をやめて、いちばん長い表示を9文字までにした
- 試してやめたもの: 数字を空白で埋める（sketchybar が先頭の空白を詰める）、数字と同じ幅の空白 U+2007 で埋める（幅がほとんど無い扱いになり、やはり幅が変わった）

### sketchybar の右側: 統計を隠すボタンを消し、アイコンの大きさをそろえた

- 統計（CPU・メモリ・通信速度）を隠すボタン（items/toggle_stats）は使っていないので消した（ユーザーの希望）。右の余白だけ 10（ほかは 3）で、隣の区切りが左寄りに見えていた。ボタンの右の区切りも消し、音量の左は git の区切り（git を隠すと一緒に隠れる）になる
- アイコンの大きさを全部 16 にそろえた（CPU・メモリは 15、電池は 19、通信速度は 13 だった）。時計の左の余白だけ 1pt 広かったのは、時計の設定の左の余白が 4（ほかは 3）だったためなので、ほかと同じにした

### sketchybar の文字を、全部ふつうの太さにした

- 文字の基本が太字（style.lua の Bold 3か所）だったのを Regular にした（ユーザーの希望）。はじめはデスクトップ番号だけ tmux のタブの番号に合わせて変えたが、全部にした。大きさは同じ

### sketchybar の右側の細い区切りの色を comment にした

- 右側だけ fg_muted で、sketchybar の左側の区切りや tmux のバーの区切り（comment）と違っていた。画像（sep_thin_left.png）の線の色を変えて、2つのバーの区切りを全部同じ色にした
- ほかの役（背景・選んでいないもの・選んでいるもの・普段の文字・休んでいるもの・警告）は、もともと2つのバーで同じ色だった

### sketchybar の右側のいちばん左（通信速度の左）の区切りを消した

- 端には分ける相手がなく、始まりの三角と二重に見えるので、tmux の右側（端には区切りなし）にそろえた（ユーザーの希望）。代わりに余白だけの項目（rsep.stats.edge）を置いた

### tmux の状態の表示を、sketchybar の右側と同じ形にし、SYNC とベルを足した

- 5つ（ZOOM・COPY・HIDE・SYNC・ベル）に増えて、色の三角ではどれが何か分かりにくいので（ユーザーの希望）、バーの色の上にアイコンを細い三角で区切って並べる形にした。普段は暗い色（fg_muted）で、その状態のときだけ色が付く（ZOOM・COPY・HIDE は明るい文字の色、SYNC は赤、ベルは黄）。右端の虹は飾りとして残した。並びは左から ZOOM・COPY・HIDE・ベル・SYNC（危ない SYNC を右端に）
- SYNC: prefix + y で、打った文字をウィンドウの全パネルに入れる（synchronize-panes）
- ベル: ほかのウィンドウでベルが鳴ったとき（session_alert）。鳴ったウィンドウの番号も出す。標準ではタブの色が反転して三角の形が崩れるので、window-status-bell-style を default にした
- テーマのファイルの stateColors（虹の続きの3色）は使わなくなったので消した

### tmux の ZOOM・COPY・HIDE の印を、いつも並ぶ3つの三角にした

- 右端の虹の左に、3つの三角をいつも並べる（home.nix の tmuxStates）。その状態のときだけ、三角に続けて色の地にアイコンを出す（名前は出さない）
- 色はテーマのファイルの `stateColors`。虹の続き: 虹と同じ明るさと鮮やかさ（OKLCH の L・C の平均）で、色みを虹の最後の青から最初の赤へ、残りの弧を4等分して進めた3色。虹の6色と重ならず、普段も同じ色
- 3つの三角と虹の間は、バーの色の三角1つ分あける
- はじめは黄・紫・青で、普段は暗くし、名前も出していたが、ユーザーの希望で今の形にした

### tmux のキーを替えた: sesh は prefix + s、しまう・戻すは prefix + h / u

- ユーザーの希望。sesh は session の s（標準のセッションの一覧の代わり。g は空けた）、しまう・戻すは hide / unhide の h / u
- h（左のパネルへ移る）は customPaneNavigationAndResize の割り当てを上書きした（C-h でできる）。はじめ戻すを H にしたが、H（左へ広げる）はよく使うので、u にした

### tmux のパネルを閉じずにしまい、まとめて元の場所に戻すキー（このときは prefix + s / S）を足した

- `tmux-stash`（home.nix）。今のパネルを見えないセッション「_stash」にしまい（シェルは動いたまま）、S でこのウィンドウでしまったものを全部戻すキー。1つ目をしまう前の並び方（window_layout）とパネルの順番を覚え、戻したあとに並び方を当て、swap-pane で各パネルを元の場所に入れかえる
- しまっている間は、バーの右に HIDE の印（青）。_stash は sesh の一覧に出さない。標準の s（セッションの一覧）は prefix + g と同じ役なので替えた
- しまっている間にパネルを増やしたり減らしたりすると、並び方は戻らない（パネルは戻る）

### tmux で、どけたパネルを戻すキー（prefix + @）を足した

- prefix + ! （標準）で今のパネルを新しいウィンドウへどけ、prefix + @ で一覧から選んで今のパネルの右に戻す（join-pane）。シェルは動いたまま

### tmux のバーに、最大化（ZOOM）とコピーモード（COPY）の印を出すようにした

- 状態のときだけ、右端の虹の三角の左に出る（home.nix の tmuxState）。ZOOM は黄、COPY は紫（Neovim の選択のモードと同じ）。バーのほかの部分と同じく、三角で区切った色のブロック（色の地に暗い文字）

### ls などを打つと、tmux のタブのフォルダ名が一瞬消えるのを直した

- タブのフォルダ名は pane_current_path（tmux が動いているコマンドのフォルダを毎回 macOS に聞く）だった。すぐ終わるコマンドだと聞いた時にもう終わっていて、空になる（ls を続けて動かすと 200 回中 17 回空）
- zsh が tmux の中ではプロンプトのたびに今のフォルダを知らせ（OSC 7）、タブはそれ（pane_path）を使うようにした（200 回中 0 回）。知らせていないときは前と同じ。sketchybar の git の表示も同じにした
- Ghostty のシェルの機能も同じ知らせを送っていて、値が `kitty-shell-cwd://ホスト名/パス` の形になる。タブは最後の名前だけなので同じに見える。sketchybar は頭を取ってから使う
- 違い: Neovim などの中でフォルダを移っても、タブの名前は、シェルで最後にいたフォルダのまま

### sesh の一覧の入力欄の文字を、「セッション」から「session」にした

- `Ctrl-A` → `g` の入力欄（home.nix の sesh-pick）

## 2026-11-25

### ファイルツリーや no-neck-pain を開くと、カーソル行の帯が欠けて見えるのを直した

- 左右の分割の線のマスはツリーの背景だったが、多くのテーマではツリーの背景が本文と同じなので、帯が端の1マス手前で切れて見えた。ツリー・線のマス・no-neck-pain の余白を同じ1色（どのテーマでも、tmux・sketchybar などのバーと同じ bg_bar）にした。GitHub・Monokai Pro はもともとこの形
- Material は後から読みこんだ色で線のマスが塗り直されるので、いつも最初に全部読みこむ（async_loading = false）
- 34テーマ × 不透明・半透明で、帯がツリー・余白の端までつながることを確かめた

### テーマを12個足した（vague・kanso-zen・solarized-osaka・oxocarbon・cyberdream・vesper・lackluster・poimandres・dracula・monokai-pro・night-owl・ayu-dark）

- Neovim は、数が多いので `extra_themes` の表にまとめ、使うテーマのプラグインだけ読みこむ（前からあるテーマの読みこみは変えていない）。bat は Neovim の実際の色から作った
- Ghostty: Solarized Osaka は Ghostty 版が Tokyo Night の色、Oxocarbon は赤が水色なので、使わずに palette の色を直接使う（Cyberdream・Lackluster は、もともと入っていない）。Night Owl・Poimandres は背景を Neovim 版にそろえた（ghosttyOverride）。Vesper・Poimandres は選択の色も変えた
- Neovim の差分の背景が明るすぎる Dracula・Night Owl・Poimandres は、palette の色にした。Lackluster・Dracula・Monokai Pro はタブの色も決めていて共通の形とずれるので、消した
- btop は Dracula・Night Owl・Ayu、k9s は Dracula だけ入っているものを使う。ほかは16色と標準の見た目

### テーマに Sora（空）を足した

- `theme sora`。Aejkatappaja/sora。背景がほぼ黒（#0e1018）で、淡い水色が主役。Ghostty は palette の色を直接使う（ghostty = null）。bat は Neovim の実際の色から作った（nightfly.tmTheme の役割の名前49個を型にした。この型で nightfly を調べ直すと全部一致）。btop は16色、k9s は標準の見た目
- 差分の背景は、公式の色（#0e1c16 など）だと背景と見分けにくいので、delta・lazygit などではほかのテーマと同じ計算の色にした（Neovim の差分は公式のまま）
- 三角とアプリ名は、色の差がほかの調整なしのテーマと同じ範囲だったので、専用の調整は入れていない

### Neovim のステータスラインのコードを整理した（見た目は同じ）

- 259行 → 135行。昔の設定の呼び名（C.ice など）への読みかえをやめ、パレットの名前を直接使う。似た部品9個を4個（block・arrow・text・separator）に、モードの名前・色・三角の色の3つの表を1つにまとめた。使われていない色は消した
- 4テーマ × 9つの状態（モード7つ・左右の分割・ツリー）で、ステータスラインの行の文字・色・太字が前後で同じことを確かめた
- テーマのファイルの bg_band の説明が「カーソル行」のままだったので「帯」に直した

### パレットの色の名前を、Nightfox の番号の名前から役割の名前に変えた

- bg0→bg_bar、bg1→bg、bg2→bg_alt、bg3→bg_band、bg4→border、fg0→fg_bright、fg1→fg、fg2→fg_dim、fg3→fg_muted、sel0→selection、sel1→search（説明は palette.nix）。これより前の記録は、前の名前のまま
- `text`・`base` などは、sketchybar の読みかえの層（Catppuccin の名前。colors.lua）とぶつかって色が変わるので使わなかった
- 確かめ方: 21個のテーマで、home-manager の出来上がりを前後で比べた（違いは色の名前だけで、値は同じ）。Neovim は 21テーマ × 不透明・半透明の画面、sketchybar は全部の色が前後で同じ

### nh を入れ、rebuild と theme の中身を nh にした

- `nh darwin switch`。進み具合と、増えた・消えた・版が変わったパッケージの一覧を出す。flake の場所は programs.nh で覚えさせた（NH_FLAKE）。rebuild（別名）と theme コマンドの中身を、darwin-rebuild から nh darwin switch に替えた（font・transparent は theme を呼ぶので一緒に替わる）。打つものは同じ。nh が動かないときは `sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/nix-config`

### sesh を入れた（tmux のセッションを選んで切り替える）

- tmux の prefix + g で、浮かぶ窓にセッションの一覧を fzf で出し、選んで切り替える（sesh-pick）。下に続くのは zoxide のよく行くフォルダで、選ぶとそこで新しいセッションを作る
- prefix + s（tmux の標準の一覧）もそのまま
- 一覧のセッションの名前の右に、Claude Code の状態の ● を出す（色は tmux のバーと同じ。セッションの中でいちばん急ぐもの）

### fzf-tab を入れた（Tab の補完を fzf で絞り込む）

- 長いコマンドを打つのがだるいので。zsh-fzf-tab を、補完の準備（compinit）のあと・autosuggestions の前に読む。色は fzf の設定（テーマの色）を使う。cd の候補では、フォルダの中身を横に出す
- fzf の `**` + Tab もそのまま使える

### ファイルのアイコンを、Neovim・eza・yazi・lazygit で Material 風にそろえた

- Neovim: nvim-web-devicons を nvim-material-icon に入れかえた（同じ名前の部品を持つので、そのまま使える）
- eza（ls）・yazi・lazygit: Neovim のアイコンの一覧を取り出した icons/material.json（絵と色）から、それぞれの設定を home.nix で作る。eza はファイル名などの色は変えない。lazygit はファイルの一覧にアイコンを出すようにした（nerdFontsVersion 3）。フォルダのアイコンはそれぞれの道具のまま
- eza は名前の大文字と小文字を区別するので、Dockerfile・README.md・LICENSE などの書き方も足した
- 絵はすべて、font コマンドで選べる4つのフォントに入っている。プラグインのアイコンが変わったら、一覧を作り直す

### 半透明の透け具合も transparent コマンドで変えられるようにした

- `transparent 0.8`（0.1〜0.99。1 に近いほど透けない）。on / off はそのままで、on は最後に選んだ透け具合に戻る。値は transparent.nix（on と opacity）。余白を塗るシェーダーも同じ値を使う

### Claude Code の状態を tmux のバーに出すようにした

- herdr のような表示（どの AI が作業中か・返事待ちか）を、tmux のままで。ウィンドウの名前の右に ● を1つ出す。赤: 返事待ち、黄: 作業中、緑: 指示待ち（パネルが複数あるときは、この順で急ぐもの）。左端のセッション名の横には、ほかのセッションも含めた返事待ちの数だけ赤い ●
- 仕組み: Claude Code の hooks（~/.claude/settings.json。Nix の外）が、状態の変わり目に claude-tmux を呼び、パネルのオプション @claude に記録する。tmux のバーはそれを読む。シェルに戻っているパネルの古い記録は見ない
- 裏で動く Claude Code（デーモンにつながる形）は TMUX_PANE を持たないので、会話の番号と同じ番号の「claude attach 番号」（なければ親のプロセス）をたどり、端末（tty）が同じパネルを探す
- 記録したらすぐバーを書き換えさせる（refresh-client -S。バーの書き換えは1秒ごとなので）。許可待ちは、Notification だと遅れて来るので PermissionRequest も使う
- 返事待ちは Notification（permission_prompt・elicitation_dialog）と、質問・計画の確認（AskUserQuestion・ExitPlanMode）で付き、次の道具の実行が終わると作業中に戻る

### フォントを font コマンドで切り替えられるようにした

- `font 名前`（`font` だけで一覧）。選べるのは jetbrains・lilex・blex・maple。定義は fonts.nix、今の値は font.nix。theme コマンドと同じように rebuild し、Ghostty と sketchybar が一緒に替わる（Ghostty は開き直す）
- どれも 18.5pt で幅 22px。Lilex と Blex Mono は行の高さが 48px なので、1px 足して 49px にそろえる（余白とシェーダーは 49px で計算してある）。sketchybar の三角は、文字の高さの比率（lineRatio）で計算する
- Lilex は IBM Plex Mono に合字を足したもの。Blex Mono（IBM Plex Mono の Nerd Font 版）には合字がない

### 日本語のフォントに Moralerspace を試したが、Maple Mono のままにした

- 試し用の Ghostty で、日本語だけ Moralerspace Neon にして見比べた。設定は変えていない

### 前に使っていた Maple Mono も見比べたが、JetBrains Mono に戻した

- Ghostty（試し用のウィンドウ）と sketchybar で試した。大きさは JetBrains Mono と同じ

### Roboto Mono も試したが、JetBrains Mono に戻した

- 18.5pt での幅と高さが JetBrains Mono（22px・49px）と同じフォントを計算で探し、Roboto Mono を Ghostty と sketchybar で試した。JetBrains Mono のほうがよかった
- 同じ大きさ: Roboto Mono・Maple Mono。幅は同じで高さが 1px 低い（adjust-cell-height = 1 で同じになる）: Geist Mono・IBM Plex Mono（BlexMono）・Lilex

### SF Mono を試したが、JetBrains Mono に戻した

- Ghostty（試し用のウィンドウ）と sketchybar の文字で試し、JetBrains Mono のほうがよかった。SF Mono は nixpkgs にないので、Apple の dmg から取り出す部品を home.nix に書いて入れた（消した）
- 分かったこと: 18.5pt の SF Mono は行の高さ 44px・幅 23px。adjust-cell-height と adjust-cursor-height を 5 にすると 49px になり、余白やシェーダーの計算はそのまま使える。ライセンスは、Apple 製品向けの画面の見本を作る用途に限られている

### Dock を出さないようにした

- アプリの起動は Spotlight しか使わないので。macOS に Dock を完全に消す設定はないので、画面の端にマウスを当ててから出るまでの待ち時間（autohide-delay）を 1000 秒にした。出したいときは Option-Cmd-D

### Neovim のモードの表示を、アイコンと頭文字から3文字の略語にした

- NOR・INS・VIS・VLN（行の選択）・VBL（矩形の選択）・CMD・REP・TER。文字数がそろうので、モードが変わっても幅が変わらない。「アイコン + 空白 + 1文字」と同じ3マスなので、前とも幅は同じ。前はどれも V だった3つの選択モードが区別できる

### Neovim のステータスラインの「1:1」の右を1マス詰めた

- 画面の右端では、Ghostty の右の余白（20px）と、幅が1マスで割り切れない余り（18px）も同じ色で塗られ、右だけ長く見えた（左 66px・右 82px）。右の空きを1マス減らし、60px にした。ツリーを開いているときなど、画面の右端にないときは右が 22px になる
- 左端の「N」も1マス詰めてみたが、戻した。Neovim は tmux の右のパネルで使うことが多く、左端が区切り側（余白がつかない）なので、詰めないほうが左右そろう（44px ずつ）

## 2026-11-24

### Neovim のファイルツリーの境目と、下の帯を直した

- ツリーとの間の隙間: 分割の線がマスの真ん中にあり、右側の半マスが隙間に見えた。はじめ線をマスの右端（▕）にしたが、線がないほうがすっきりするので、左右の分割の線を全部消した（fillchars の vert を空白）。線のマスはツリーと同じ背景にした（本文の色だと、カーソル行の帯とツリーの間に1マスの隙間が見える）
- 線の真下の1マスが青い: Neovim が標準のステータスライン（StatusLine）の色で塗る所で、GitHub テーマでは青い。lualine と同じ暗い色にした
- ツリーの下の帯: メインの背景色なので半透明で透けていた。ツリー本体は別の色で抜けて見えるので、暗い色にした（不透明でも変わる）

### 半透明のとき、tmux のパネルの間に黒い線が見えるのを消した

- 選んでいないパネルの間の線は、メイン背景色と同じ色で隠していた。半透明だと背景だけ透け、線が黒く残って見えた。線に `hidden`（文字を描かない印）を付けた。選んでいるパネルのまわりの線は今までどおり

### Cmd-U で、半透明と不透明をその場で切り替えられるようにした

- Ghostty の `toggle_background_opacity`。不透明にすると、ウィンドウのいちばん後ろに Ghostty の背景色を敷くだけなので、塗っていない Neovim の本文やタブ、余白もそのまま同じ背景色に見える。rebuild も開き直しも要らない
- 押したウィンドウだけに効き、開き直すと半透明に戻る。ずっと不透明にするなら `transparent off`（壁紙も無地になる）

### Neovim のタブの作りを、不透明と半透明で同じにした

- 上の余白をシェーダー（ghostty/padding.glsl）で直せるようになったので、不透明でも同じ作りにした。bufferline の内部に手を入れていた2か所（三角の記号の差しかえ、三角の隣の空白の色）は要らなくなり、消した
- 左端の暗いマスも共通にしたので、不透明でもタブが1文字分右にずれた

### ウィンドウの高さを変えても tmux のバーが下に伸びないようにした

- `extend-always` は、高さが行の高さで割り切れない下の余りを、真上のマスの色で塗るので、tmux のバーが下に伸びて見えた。Ghostty に「上だけ広げる」設定はない
- シェーダー（ghostty/padding.glsl）で、余りだけを背景色で塗りつぶす。余りは、描くたびに今の高さから計算する（上の余白 8px と1行 49px は決め打ち。文字の大きさを変えたら直す）。最大サイズでは余りが 0 なので何も塗らない。ユーザーが、不透明・半透明の両方で見た目を確かめた。半透明のときは、背景と同じ透け具合（home.nix の backgroundOpacity）で塗る
- 試してやめたもの: `extend` に戻す（tmux で左右に分けると、Neovim のタブの上に隙間が見える）、`window-step-resize`（24.5pt の行の高さに対して 24pt ずつ変わり、割り切れない）

### ターミナルの背景を半透明にできるようにした（お試し中）

- `transparent on`・`transparent off` で切りかえる（transparent.nix を書き換え、theme コマンドで rebuild）。半透明のときは、`theme` で切りかえても壁紙を変えない。決まり: 不透明（false）のときの設定は何も変えない。透けるのはテーマのメインの背景色（bg1）だけ
- Ghostty: background-opacity 0.9・background-blur 20（終了して開き直すと効く）。background-opacity-cells は、塗った色を透けた背景に重ねて描くので約 0.99 になり、使っていない
- Neovim: 本文と同じ背景色の色をまとめて外す。選んでいるタブも塗らない
- tmux: パネルの区切りは線だけに色を付け、背景は塗らない（bg=default）。不透明でも Ghostty の背景と同じになるので、枝分かれせず共通にした
- タブの斜めの三角は透かせないので、裏返さない向き（塗らない背景の上に暗い三角）にし、区切りの上に見える余白は、シェーダー（ghostty/padding.glsl）ですぐ下の 1px と同じ色にする。はじめは四角いタブにしていた。斜めのままだと、余る 4pt を上に置けば区切りの上に隙間が、下に置けば tmux のバーの三角に段ができる（どちらも試してやめた）
- はじめは sketchybar の高さなど配置まで変えたが、不透明のときの見た目も変わってしまうのでやめた

### テーマに Aura（dark）を足した

- `theme aura-dark`。Ghostty に入っている。Neovim は公式の daltonmenezes/aura-theme（いろいろなアプリ用の大きなリポジトリで、手元では 89MB）の packages/neovim を、このテーマのときだけ読みこむ。bat は Neovim の実際の色から作った。btop は16色、k9s は標準の見た目
- Neovim 版は作りが古く、細かい色分けが TSProperty などの古い名前なので、今の名前（@property など）からつないだ。カーソル行が見えない・選択範囲と差分が反転で明るすぎるのも直した（nvim/init.lua）
- Ghostty の Aura は青と紫、緑と水色が同じ色。tmux や lazygit では、公式の別の色を水色（#82e2ff）と紫（#f694ff）に当てて見分けられるようにした

### テーマに Carbonfox を足した

- `theme carbonfox`。Nightfox と同じプラグイン（EdenEast/nightfox.nvim）の、背景がほぼ黒（#161616）の種類。Ghostty に入っている。bat は Neovim の実際の色から作った。btop は16色、k9s は標準の見た目

### sketchybar の右側の区切り（〈）が、どのテーマでも Gruvbox の色だったのを直した

- 区切りは Gruvbox だけを使っていたころに作った固定の画像（#7c6f64）で、テーマを切りかえられるようにしたとき（11/22）に直し忘れていた。home.nix がテーマの fg3 の色で作るようにし、固定の画像は消した

### sketchybar の下端に出る黒い線を消す

- Ghostty の下に隠れている Finder などの影が、ウィンドウより後ろにあるバーの上にかかって、黒い線に見えていた（線の端が Finder の位置と一致）。`topmost = "window"` でバーをウィンドウより手前にした

### Neovim のタブの斜めの区切りの上に見えた、わずかな隙間をなくした

- Ghostty は余白をマスの背景の色で塗る。区切りのマスの背景はタブの色（三角のほうが帯の色）なので、区切りの上だけタブの色になり、隙間に見えた。記号を裏返し（右 U+E0B8・左 U+E0BA）にして、背景を帯の色、三角をタブの色にした。見た目の形は同じ
- 記号は bufferline の中の表（constants.sep_chars.slant）を書きかえている
- 左の三角の隣の空白1マスが、三角の背景（帯の色）を引きついで暗い長方形に見えたので、bufferline が作る文字列（_G.nvim_bufferline）の三角の直後に、タブの色の指定を差しこんだ

### Neovim のタブの行と sketchybar の間の隙間を埋めた

- 隙間は Ghostty の上の余白（4pt）。window-padding-color = extend は、三角などの記号がある行では上下に広がらないので、本文の背景色のままだった。`extend-always` にして必ず広げる

### Ghostty の四隅を角にした

- `window-decoration = none`（枠なし）。Ghostty の説明にあるとおり角が四角くなる。Ghostty のタブは使えなくなる（tmux を使うので困らない）。試し用のウィンドウで、yabai がふつうに並べることを確かめた

### yabai の画面の端のすき間をなくした

- 最大サイズのウィンドウと画面の端の間の 8pt（top / bottom / left / right_padding）を 0 にした。ウィンドウ同士のすき間（window_gap 8）は残した
- Ghostty の全画面の高さが 2230px から 2262px に変わるので、上の余白を 12 から 4 にした（2262 − 8 = 49px × 46行で、余りが出ない）

### Neovim に nvim-surround を入れた

- 囲む文字（かっこ・引用符・タグ）を足す（ys）・変える（cs）・消す（ds）。選択中は S。既定のキーのまま（ほかの設定と重ならないことを確かめた）。安定した 4.x を使う

### テーマに Nightfox を足した

- `theme nightfox`。前に使っていたテーマ（Gruvbox に変える前）で、色と差分の値は当時のものを使った。Ghostty と k9s に入っている。Neovim は EdenEast/nightfox.nvim。bat は Neovim の実際の色から作った。btop は16色

### Iceberg で、Neovim の上のタブ（bufferline）が白や灰色になるのを直した

- Iceberg だけが TabLineFill などを「色の反転」（reverse）で定義していて、bufferline の色と重なり、文字と背景の色が入れかわっていた。反転を使わず、入れかえた色で定義し直した（StatusLine・StatusLineNC も同じ）

### ほかのテーマも、必要なものだけ三角とアプリ名の色を直した

- 全テーマの色の差（コントラスト）を調べ、直す前の GitHub の2つと同じくらい気になるものだけ直した
- 三角（tmuxUser）: Rosé Pine・Flexoki・Iceberg。アプリ名（frontApp）: Material Darker・OneDark darker
- Material の2つに三角の調整を入れると、ユーザー名が読みにくく、三角の差も大きくなるので入れていない。区切り線は、ほかのテーマは目立たないので変えていない

### GitHub Dark Dimmed にも、GitHub Dark Default と同じ微調整をした

- tmux のユーザー名のブロックと三角（tmuxUser）、sketchybar の今のアプリの名前とアイコン（frontApp）を、Dark Default と同じ役割の色にした
- カーソル行（#30363d）と tmux のパネルの区切り線（#30363d）は、もともと暗いので変えていない（GitHub の枠線の色 #444c56 にすると逆に明るくなる）

### テーマに One Dark Pro の onedark_dark を足した

- `theme onedark-dark`。OneDark darker（navarasu/onedark.nvim）とは作者が違う olimorris/onedarkpro.nvim の、背景が真っ黒の種類。Ghostty は palette の色を直接使う（ghostty = null）。bat は Neovim の実際の色から作った。btop は16色、k9s は標準の見た目
- 2つのプラグインはどちらも `onedark` という名前の配色を持っていて、一緒に読みこむと OneDark darker が標準の One Dark の色になってしまった。そこで、onedarkpro.nvim は init.lua の onedark_dark の枝の中で vim.pack.add し、このテーマのときだけ読みこむ
- カーソル行は既定で切られているので、出すようにした

### テーマに Nightfly を足した

- `theme nightfly`。Moonfly と同じ作者の、紺色の背景（#011627）のテーマ。Ghostty に入っていないので、palette の色を直接使う（ghostty = null）。Neovim は bluz71/vim-nightfly-colors。bat は Neovim の実際の色から作った。btop は16色、k9s は標準の見た目

### テーマに Moonfly を足した

- `theme moonfly`。背景がほぼ黒（#080808）。Ghostty に入っている。Neovim は bluz71/vim-moonfly-colors。bat は Neovim の実際の色から作った。btop は16色、k9s は標準の見た目
- これより暗い色を作れないので、バー（bg0）は本文より少し明るい #121212 にした（作者の tmux 用の設定も、バーは本文より明るい）

### テーマに Iceberg（dark）と Flexoki（dark）を足した

- `theme iceberg-dark`・`theme flexoki-dark`。Ghostty はどちらも入っている。Neovim は本家の cocopon/iceberg.vim と kepano/flexoki-neovim。bat は Neovim の実際の色から作った。btop は Flexoki だけ入っている。k9s はどちらも標準の見た目
- Iceberg は行番号と印の列の背景が本文より明るいので、本文と同じにした
- 行番号の色そのままだと暗く、tmux や Neovim のブロックの上の文字が読みにくいので、fg3 は少し明るい色（Iceberg は #5b6389、Flexoki は #6f6e69）にした

### GitHub Dark Default だけ、tmux のユーザー名の三角の色を Neovim のステータスラインに合わせた

- ユーザー名のブロック（fg2）の右の三角が fg1（白に近い）で、浮いて見えた（ユーザーの指摘）
- Neovim のノーマルモードと同じく、ブロックを fg3、三角を comment にした。はじめ全テーマ共通で変えたが、気になるのはこのテーマだけなので、テーマのファイルに `tmuxUser` を書いたときだけ変わるようにした（ほかのテーマは元のまま）

### GitHub Dark Default だけ、sketchybar の今のアプリの名前とアイコンを明るくした

- 明るい帯（bg3 #484f58）の上の文字が fg2（#7d8590）で読みにくかったので、明るくした。はじめ #b1bac4（gray[3]）にし、そのあと選んでいるデスクトップのアプリのアイコンと同じ色（fg0 #f0f6fc）にそろえた
- テーマのファイルに `frontApp` を書いたときだけ変わる（ほかのテーマは fg2 のまま）

### GitHub Dark Default の Neovim のカーソル行を暗くした

- プラグインの色（#484f58）が明るすぎたので、Dark Dimmed と同じ決め方（背景に文字の色を1割混ぜる）の #23272d にした（nvim/init.lua の groups）。bat の行の強調の色も合わせた
- palette の bg3 は sketchybar の帯などにも使うので、変えていない

### GitHub Dark Default だけ、tmux のパネルの区切り線を暗くした

- 選んでいるパネルのまわりの線を bg3（#484f58）から GitHub の枠線の色（#30363d）にした（さらに暗い #21262d も試したが、#30363d に決めた）。テーマのファイルに `tmuxPaneBorder` を書いたときだけ変わる

### Ghostty のまわりの細い線を消した

- 線の色を変えたいという希望。Ghostty に線の色の設定は無く、macOS が付けているものと思われる。影を消す（`macos-window-shadow = false`）と線も完全に消えた（ユーザーが確認）。線は影と一緒に付いていたと思われる。だめなら試すつもりだった JankyBorders（好きな色の線を描く）は入れていない

## 2026-11-23

### テーマに GitHub Dark Default を足した

- Dark Dimmed のほかに、サポートが多くて暗いものとして Dark Default を選んだ（High Contrast も Ghostty・Neovim・公式の VS Code にあり、手元の道具での対応の数は同じ）。`theme github-dark-default`
- 作り方は Dark Dimmed と同じ（Ghostty のカーソルは Neovim に合わせて文字の色に上書き）。bat は Neovim の実際の色から作った。Neovim の設定は Dark Dimmed と同じ枝にまとめた
- 枠線（bg4）だけは、プラグインの border.default（gray[9] #161b22）が背景とほぼ同じで見えないので、GitHub の border.default（#30363d）にした
- カーソル行（bg3 #484f58）は、このプラグインの Dark Default の決まりで、背景に対してかなり明るい

### bat に最初から入っているテーマを使っていた4つも、Neovim から作り直した

- Gruvbox Dark Hard・Catppuccin Mocha・Nord・OneDark darker は、bat に最初から入っているテーマ（gruvbox-dark・Catppuccin Mocha・Nord・OneHalfDark）を使っていたが、よく見ると Neovim と色の割り当てが違った（作った人が違う。OneDark は bat に無く、似た OneHalfDark だった）
- ほかの8つと同じやり方（Neovim で読みこんだ実際の色を取り出して当てはめる）で `bat/<テーマ名>.tmTheme` を作り、各テーマの bat をそれにした。これで12個すべてが Neovim と同じ割り当てになった
- `nord`（作ったもの）と bat の `Nord` は別のテーマとして区別されることを確かめた

### zoxide と fd を勧めたが、どちらもすでに入っていた

- 作業効率化のツールとして zoxide と fd を勧め、ユーザーが入れてほしいと言ったが、足そうとしたらどちらも home.nix にすでにあった（`programs.zoxide.enable`、`programs.fd.enable`）。勧める前の確認もれ。変更はしていない
- 使い方: `z <フォルダ名の一部>`（`zi` で候補から選ぶ）、`fd <名前>`

### bat に専用のテーマがない7つのテーマにも、bat 用のテーマを作った

- GitHub Dark Dimmed で、Neovim に合わせた bat のテーマが「思ってた以上にいい感じ」だったので、ほかの `ansi` だったテーマ（Melange・Everforest・Kanagawa Dragon・Material 2つ・Tokyo Night・Rosé Pine）にも作った
- 7つを手で読むのは大変なので、やり方を変えた: Neovim を画面なしで起動し（`--cmd` で theme・palette を差し替えて init.lua を読ませる）、各テーマを読みこんだときの実際の色（nvim_get_hl。無い役割は親の役割へさかのぼる）を取り出して、Neovim の役割49個を bat の方式（TextMate の scope）の名前に当てはめた。作ったファイルは `bat/<テーマ名>.tmTheme`
- `programs.bat.themes` は、`bat/` の中のファイルを全部自動で足すようにした（builtins.readDir）。各テーマの bat はファイル名と同じ名前にした
- bat の方式では `const x` の `x` を定数（variable.other.constant）として扱い、Neovim ではふつうの変数なので、定数の色を当てないようにした（GitHub Dark Dimmed も同じく直した）
- 色を取り出す・当てはめる小さなスクリプトは一時置き場で使っただけで、リポジトリには入れていない。テーマのプラグインが色を変えたら、同じやり方で作り直す

### テーマに GitHub Dark Dimmed を足した

- ユーザーが GitHub テーマに興味を持ち、ダークの種類（Default・High Contrast・Dimmed）から Dark Dimmed を選んだ。`theme github-dark-dimmed` で切り替えられる
- Ghostty は最初から入っている `GitHub Dark Dimmed` を使う。Neovim は projekt0n/github-nvim-theme を vim.pack に足した
- bat に入っている GitHub は明るい背景用なので使わず `ansi`。btop は `TTY`、k9s は標準の見た目
- github-nvim-theme の色の一部は、背景にほかの色を混ぜて作られる。プラグインを動かして値を出すのは止められたので、色の元データ（primitives/dark_dimmed.lua）を取ってきて、同じ式で計算した
- 差分の背景（行全体）は github-nvim-theme の決まった色をそのまま使った
- lazygit（delta）のコードの色が Neovim と違うのが残念、という話になった。bat に GitHub のダーク用が無く `ansi`（16色の割り当てを bat が決める）だったため
  - GitHub 公式の VS Code のテーマ（primer/github-vscode-theme 6.3.5、MIT）を Open VSX から取り、themes/dark-dimmed.json を bat 用の `bat/github-dark-dimmed.tmTheme` に書き直した。VS Code と bat はどちらも TextMate の方式なので、色の決まり（tokenColors 49個）をそのまま写せる
  - `programs.bat.themes` で足し、`themes/github-dark-dimmed.nix` の bat を `github-dark-dimmed` にした。delta も bat のテーマを使うので、lazygit の差分も同じ色になる
  - ただ、bat（公式の VS Code の割り当て）と Neovim（github-nvim-theme の割り当て）でかなり差があった。そこで、github-nvim-theme の色の役割の表（palette/github_dark_dimmed.lua の syntax）と細かい上書き（group/modules/treesitter.lua）を見て、bat の方式の名前に当てはめて作り直した（36個）。もとにした Neovim の役割は、ファイルの各 name に書いた
  - 読み取り方の差（Neovim は treesitter、bat は TextMate）は残るので、完全には同じにならない
  - 反映しても lazygit に `[bat warning]: Unknown theme 'github-dark-dimmed'` と出て、標準の色のままだった。rebuild のときに bat の控え（キャッシュ）を作る home-manager の処理（home.activation.batCache）が、設定の置き場所（~/.config-nix）を知らずに ~/.config/bat を見ていたため。同じ処理に `BAT_CONFIG_DIR` を足したものに置きかえた（lib.mkForce）
- カーソルが青かった。Ghostty の GitHub Dark Dimmed はカーソルが青（#539bf5）だが、github-nvim-theme（README のプレビュー）は通常の文字の色（灰色 #adbac7）。テーマのファイルに `ghosttyOverride`（Ghostty のテーマの色のうち上書きするもの）を書けるようにして、灰色に合わせた

### テーマに Melange を足した

- ユーザーが Melange（savq/melange-nvim）に興味を持ったので、`themes/melange.nix` を作った。`theme melange` で切り替えられる
- あたたかい色（こげ茶の背景・クリーム色の文字）のテーマ。dark と light しかないので dark を使う
- Ghostty は最初から入っている `Melange Dark` を使う。Neovim は melange-nvim を vim.pack に足し、`background = "dark"` にして読み込む
- bat・btop には入っていないので、ターミナルの16色をそのまま使う（bat は `ansi`、btop は `TTY`）。k9s は標準の見た目
- 色は melange-nvim の `lua/melange/palettes/dark.lua` から取った（主に明るい色の b）。バーの背景（bg0）・虹・差分の背景は、ほかのテーマと同じ計算で作った

---

## 2026-11-22

### テーマをコマンド一発で切り替えられるようにした（theme コマンド）

- 気分によってテーマを変えたい（ユーザーの希望）
- `themes/` にテーマごとのファイル（`gruvbox-dark-hard.nix`・`onedark-darker.nix`）を置いた（Gruvbox は最初 `gruvbox.nix` だったが、どの種類かわかるよう名前を変えた）。中身は色（`palette`）と、各ツールで使う最初から入っているテーマの名前（`ghostty`・`nvim`・`bat`・`btop`・`k9s`）
- `theme.nix` は、どのテーマを使うかの1行（`import ./themes/名前.nix`）だけ。`palette.nix` はそのテーマの色を返す（ほかのファイルは今までどおり `palette.nix` を読む）
- Ghostty: テーマが Ghostty に入っていればその名前（Gruvbox Dark Hard）、入っていなければ palette の色を直接決める（`ghosttyColors`）
- Neovim: gruvbox.nvim と onedark.nvim の両方を入れ、home.nix が書き出す `theme.lua` の名前で選ぶ
- `theme` コマンド（`pkgs.writeShellApplication`）: `theme` で一覧、`theme 名前` で theme.nix を書き換えて rebuild し、tmux（`source-file`）・sketchybar（`--reload`）・Ghostty（`SIGUSR2`。Ghostty 1.3.1 はこれで設定を読み込み直す）に読み込み直させる。rebuild に失敗したら theme.nix を元に戻す。Neovim は開き直す
  - 一覧と、ないテーマ名のときのエラーを試した。`$name」` のように変数の後ろに日本語が続くと、変数名の一部と読まれて止まったので、`''${name}` で囲った
  - Gruvbox を選んで組み立て、Ghostty・Neovim・tmux・bat が Gruvbox になることを確かめた（theme.nix は元に戻した）
- 新しいテーマを足すときは、`themes/` にファイルを足して `git add` する（flake は git に入っているファイルしか見ない）
- Catppuccin Mocha も足した（`themes/catppuccin-mocha.nix`）。色は公式の値で、役割ごとに Catppuccin での名前をコメントに書いた。差分の色は決まった値が無いので、green / red / blue を base に混ぜた
  - Ghostty・bat は最初から入っている「Catppuccin Mocha」。btop と k9s には入っていないので、btop は「TTY」（ターミナルの16色を使う）、k9s は標準の見た目（`k9s = null` のときはスキンを設定しない）
  - Neovim は catppuccin/nvim（リポジトリ名が nvim なので、`name = "catppuccin"` で入れた）の mocha。`--headless` で、背景 `#1e1e2e`・文字 `#cdd6f4` になることを確かめた
  - theme.nix を一時的に catppuccin-mocha にして組み立て、Ghostty・Neovim・btop・壁紙（`wallpaper-1e1e2e.png`）がそのテーマになることを確かめた（theme.nix は元に戻した）
- Rosé Pine も足した（`themes/rose-pine.nix`）。3つの種類のうち、いちばん暗い main（ユーザーの希望）。色は rose-pine/neovim の `palette.lua`
  - バー（bg0）は `_nc` `#16141f`（ほかのテーマと同じく、ターミナルの背景より少し暗い）。緑・水色・オレンジがないので、ターミナルの色の割り当て（Ghostty の Rose Pine）に合わせ、green は pine、cyan と orange は rose
  - Ghostty は「Rose Pine」、k9s は `rose-pine`（どちらも最初から入っている）。bat と btop には入っていないので、ターミナルの16色を使う `ansi`・`TTY`
  - Neovim は rose-pine/neovim（リポジトリ名が neovim なので、`name = "rose-pine"` で入れた）の main。`--headless` で、背景 `#191724`・文字 `#e0def4` になることを確かめた
  - theme.nix を一時的に rose-pine にして組み立て、Ghostty・Neovim・k9s・壁紙（`wallpaper-191724.png`）がそのテーマになることを確かめた（theme.nix は元に戻した）
  - tmux のステータスバーの右端の三角が、ピンク・黄・青緑を行ったり来たりしてちぐはぐだった（ユーザーの指摘）。テーマのファイルに `rainbow`（6色）を書けるようにし、Rosé Pine は love → iris → foam の間をなめらかにつないだ色にした。書いていないテーマは今までどおり赤 → 青
- Nord も足した（`themes/nord.nix`）。暗くした Nord（nordic）と迷ったが、ユーザーの希望で公式の Nord（背景 `#2e3440`。ほかのテーマより明るい）
  - バー（bg0）は Nord に無いので、nord0 を黒に 15% 寄せた `#272c36`（ほかのテーマと同じく、ターミナルの背景より少し暗い）。ステータスラインの文字は、Nord と同じく nord4
  - Ghostty・bat は `Nord`、btop・k9s は `nord`（どれも最初から入っている）。Neovim は gbprod/nord.nvim。`--headless` で、背景 `#2e3440`・文字 `#d8dee9` になることを確かめた
  - theme.nix を一時的に nord にして組み立て、Ghostty・Neovim・tmux・k9s・壁紙（`wallpaper-2e3440.png`）がそのテーマになることを確かめた（theme.nix は元に戻した）
- Tokyo Night（night）・Kanagawa（dragon）・Everforest（dark hard）も足した。どれもいちばん暗い種類。色は各 Neovim のテーマの色の一覧（tokyonight.nvim・kanagawa.nvim・everforest-nvim）から取り、公式の値が無いところ（差分の _emph、Everforest のバー）だけ混ぜて作った
  - Ghostty は最初から入っているもの（TokyoNight Night・Kanagawa Dragon・Everforest Dark Hard）。btop も3つとも入っている。k9s は Kanagawa・Everforest だけ（Tokyo Night は標準の見た目）。bat はどれも入っていないので `ansi`
  - Kanagawa: 左端の列が既定では本文より明るいので、`bg_gutter = "none"` で本文と同じにした
  - Everforest: Ghostty の Everforest Dark Hard は背景が bg_dim（`#1e2326`）で、Neovim の hard の背景（`#272e33`）より暗い。`colours_override` で Neovim の背景を palette の bg1 に合わせた
  - `--headless` で、3つとも Neovim の背景がターミナルと同じになることを確かめた。theme.nix を一時的にそれぞれにして組み立て、Ghostty・Neovim・btop・k9s・壁紙がそのテーマになることを確かめた（theme.nix は元に戻した）
- OneDark darker の Neovim で、カーソル行の左端の印の列にだけ色が付き、行番号で帯が途切れて見えた（ユーザーの指摘）。Gruvbox のときの `CursorLineSign` の上書きをまねていたため。ほかの多くのテーマ（Catppuccin・Rosé Pine・Nord・Tokyo Night・Kanagawa・Everforest）と同じく、帯は本文のところだけにする（上書きを消した）
  - そのあと、ユーザーの希望で、逆に全部のテーマを Gruvbox と同じ形（帯が印の列・行番号までつながる）にそろえた。テーマごとに書かず、テーマを読み込んだあと（と `ColorScheme` のとき）に、CursorLine の背景を CursorLineNr・CursorLineSign・CursorLineFold にも付ける共通の処理（`extend_cursorline`）にした。Gruvbox の `CursorLineSign` の上書きも、これに任せて消した
  - `--headless` で、8つのテーマ全部で3つの背景がそろうことを確かめた
- Material の Darker と Deep Ocean も足した（`themes/material-darker.nix`・`material-deep-ocean.nix`）。色は marko-cerovac/material.nvim の `colors/init.lua`。5つの種類のうち、Ghostty と Neovim の両方にあるのがこの2つだった
  - Ghostty の Material Darker・Material Ocean は、背景は Neovim と同じだが、文字の色が違う（Ocean は `#8f93a2`、Neovim は `#a6accd`）。ターミナルと Neovim で文字がずれないよう、Ghostty は palette の色を直接使う（`ghostty = null`）
  - バーは bg_alt（Darker `#1a1a1a`・Deep Ocean `#090b10`）。コメントの色はバーの文字には暗すぎるので、comment の役割には fg_dark を使った。bat・btop・k9s には入っていないので、`ansi`・`TTY`・標準の見た目
  - Neovim は material.nvim。どちらの種類かは `vim.g.material_style`（"darker"・"deep ocean"）で決める。`--headless` と、theme.nix を一時的にそれぞれにした組み立てで確かめた（theme.nix は元に戻した）
  - Deep Ocean の tmux のステータスバーがまとまらなかった（ユーザーの指摘）。ユーザー名のかたまり（fg2 `#717cb4`・青紫で鮮やか）、番号（fg1 `#a6accd`）、フォルダ名（fg3 `#3b3f51`）で色みも明るさもばらばらだったため。灰色の役割を色みの少ない青灰色の明るさの段にそろえた: comment・fg2 → `#8f93a2`（Ghostty の Material Ocean の文字の色）、fg3 → `#464b5d`（disabled）
- tmux の右端の三角が、Rosé Pine 以外は赤 → 青の虹の順に、テーマの決まった6色を並べただけで、段がはっきりしてグラデーションに見えなかった（ユーザーの指摘）。全部のテーマで、テーマらしい色を2〜4色選び、その間を混ぜたなめらかな6色（`rainbow`）にした
  - Gruvbox: red → orange → yellow / OneDark: red → purple → blue / Catppuccin: peach → pink → mauve → lavender / Nord: Frost（nord7 → nord10） / Tokyo Night: magenta → blue → cyan / Kanagawa: dragonRed → dragonOrange → dragonYellow / Everforest: green → aqua → blue / Material: purple → blue → cyan
  - 見たうえで、ユーザーは「やはり虹がいい」。縞の虹ではなく、なめらかな虹にした（Rosé Pine も同じ形）: OKLCH で、明るさ（L）と鮮やかさ（C）をテーマの赤・オレンジ・黄・緑・水色・青の平均にそろえ、色み（H）だけをテーマの赤から青へ等間隔に変えた6色。画面に出せない色は鮮やかさを少し下げた
- 色はできるだけテーマのパレットから選ぶことにした（ユーザーの希望）。計算で作るのは、差分の背景だけ（背景に赤や緑を混ぜないと見分けにくく、Neovim のテーマ自身も計算で作っている）
  - 三角: パレットの全部の色（Gruvbox の light_* / neutral_*、Catppuccin の maroon / sky、Rosé Pine の leaf、Tokyo Night の green1、Material の dark* など）から、虹の順に、明るさ（OKLCH の L）のそろうものを選んだ。機械的にいちばん近い色を選ぶと、黄が抜けたり最後に灰色が入ったりしたので、順番を守って候補を比べた
  - cyan_light: 水色の系統でもっと明るい色がパレットにあればそれ（Tokyo Night の blue6、Material Deep Ocean の accent）、なければいちばん明るい文字の色
  - バーの背景: Nord は nord1、Everforest は bg0（どちらもパレットに背景より暗い色がないので、バーはターミナルより少し明るくなる）
  - Material Deep Ocean の comment・fg2 の `#8f93a2` は、Material Theme の Ocean の文字の色（パレットの色）
  - 見たうえで、違和感があったので、ユーザーの希望でなめらかな虹（計算）に戻した。cyan_light と Nord・Everforest のバーの背景も、前の計算の色に戻した
- Gruvbox Dark Hard に切り替えても、カーソルが青みのあるグレー（Material Deep Ocean の cursor-color `#a6accd`）のままだった（ユーザーの指摘）
  - Ghostty の設定（`+show-config`）は `cursor-color = #ebdbb2` で正しかった。tmux の `cursor-colour` も none。SIGUSR2 で読み込み直しても変わらず、ターミナルに OSC 112（カーソルの色を設定の色に戻す）を送ると治った。プログラムが途中でカーソルの色を書き換え、それが残っていた
  - 入っている Neovim のテーマで、カーソルの色を変えるのは material.nvim だけ（`colored_cursor` が既定で有効。`guicursor` に `a:Cursor/Cursor` を足し、閉じるときに外す）。閉じるときの戻しで、Ghostty がそのときの設定の色を覚えたままになったと考えられる
  - material.nvim の `disable = { colored_cursor = true }` で切った。カーソルは、ほかのテーマと同じくターミナルの設定の色
  - それでも、テーマを替えるたびにカーソルだけ前のテーマの色で残った（ユーザーの報告）。Ghostty は SIGUSR2 で読み込み直しても、開いている画面のカーソルの色を更新しないらしい（OSC 112 で治るので）。`theme` コマンドで、読み込み直しの 0.5 秒後に、tmux につながっている画面（`tmux list-clients` の端末）へ OSC 112 を送るようにした
- 壁紙も、テーマのターミナルの背景（bg1）と同じ色の無地にした（ユーザーの希望）
  - `home.nix` の `wallpaper`: ImageMagick で 64x64 の無地の PNG を作る。名前に色を入れる（`wallpaper-1d2021.png`）ので、テーマごとに別の画像になる
  - `theme 名前` の最後に、新しくできた theme コマンドの `--set-wallpaper` を呼び、`osascript`（System Events の `set picture`）で壁紙にする
  - 試しに今の色（Gruvbox の `#1d2021`）の画像で壁紙を変え、macOS の壁紙の設定（`com.apple.wallpaper/Store/Index.plist`）に `wallpaper-1d2021.png` が入ったことを確かめた（`get picture` は新しい macOS では値を返さない）
  - ユーザーには、壁紙とターミナルの背景が違う色に見えた。画像に「sRGB の色」という印がなく（`cHRM` だけ）、macOS が別の基準の色として受け取っていたため。Ghostty は `window-colorspace = srgb`
  - macOS の `/System/Library/ColorSync/Profiles/sRGB Profile.icc` を `-profile` で付けると、`sRGB` の区切りが入り、`sips` でも「sRGB IEC61966-2.1」と読める。試しの画像を壁紙にして、色が合うことをユーザーが確かめた（Nix の sandbox は切ってあるので、組み立てのときにこのファイルを読める）

### 配色を Gruvbox Dark Hard から OneDark darker にした（このあと、テーマの1つとして themes/ に移した）

- ユーザーが OneDark darker（Neovim の onedark.nvim の style = "darker"）に興味を持った
- `palette.nix`: onedark.nvim の `lua/onedark/palette.lua` の darker の色にした。役割の名前は今までどおりで、onedark.nvim での名前をコメントに書いた
  - バー（bg0）は bg_d `#181b20`（ターミナルの背景 `#1f2329` より少し暗い）、カーソル行（bg3）は bg2 `#30363f`
  - darker に無い色（明るい文字 fg0・white）は、同じ OneDark の dark の fg `#abb2bf`。差分の `_emph` は green / red を bg1 に 30% 混ぜた色
- Ghostty: 同じテーマが入っていないので、`theme` をやめて、`background`・`foreground`・`palette`（16色）などを palette.nix から直接決めた
- Neovim: gruvbox.nvim → onedark.nvim（`style = "darker"`）。左端の列は onedark.nvim では最初から本文と同じ背景なので、Gruvbox のときの上書きは消した。`--headless` で、Normal の背景が `#1f2329`、文字が `#a0a8b7` になることを確かめた
- bat・delta → `OneHalfDark`、btop → `onedark`、k9s → `one-dark`（どれも最初から入っているもの）
- tmux・sketchybar・starship・fzf・lazygit などは palette.nix から色を取るので、自動で変わる

### おもしろいツールを試した（入れていない）

- wttr.in: `curl 'wttr.in/Tokyo?lang=ja'` で天気予報を出せる。入れるものはいらない
- vhs: 台本（.tape）のとおりにキーを打って、ターミナルの操作を GIF にする。`nix shell` で vhs・ttyd・ffmpeg を呼び、ブラウザは入っている Google Chrome を使って作れた。今は使い道がないので入れていない
- nyancat・moon-buggy: pty で起動して、落ちずに動くことを確かめた。`nix run nixpkgs#名前` で遊ぶ（moon-buggy は Space/j でジャンプ、a/l でレーザー、q で終わる）

### rebuild のあと、ほかのシェルも次のプロンプトで自動で起動し直すようにした → 消した

- tmux の各ペインの zsh は、rebuild より前に起動していると古い設定のまま（atuin の Ctrl-R が効かなかった）。毎回 `exec zsh` を打つのが手間（ユーザーの報告）
- `home.nix` の zsh の `initContent` に足した: `$ZDOTDIR/.zshrc` は home-manager-files を指していて、rebuild で home-manager の設定が変わると行き先が変わる。起動したときの行き先を覚えておき、プロンプトのたび（precmd）に見比べて、変わっていたら `exec zsh`
  - 行き先は `zstat -L -A` で変数に直接入れる（`$(...)` だとプロンプトのたびにプロセスが起動する）
  - 起動し直す前に、rebuild の別名と同じく `__HM_SESS_VARS_SOURCED` などの目印を消す（新しい PATH などを読み込ませるため）
  - 試しの場所でリンクを付け替えて、変わる前は何もせず、変わったら起動し直すと判断することを確かめた
- 使い方: rebuild のあと、各ペインで Enter を1回押す。ただし、この仕組みを入れる前から開いているシェルは、最初の1回だけ手で `exec zsh` が要る
- `Enter` を押さずに全部へ反映する仕組み（各 zsh に名前付きパイプを持たせ、rebuild が知らせを書き込み、`zle -F` で受けて起動し直す）も試作したが、複雑なのでやめた（設定には入れていない）
- ユーザーの希望で、この仕組みも消した（`initContent` は入れる前と同じ）。設定を変えたあとは、使うペインで `exec zsh` を打つ

### atuin（履歴検索）と just（コマンドに名前を付ける）を入れた（試し中）

- atuin（`programs.atuin`）: `Ctrl-R` の履歴検索を atuin にした。フォルダ・セッションごとに探せて、日時・かかった時間・成功したかも残る
  - 上矢印は今までどおり「1つ前のコマンド」（`--disable-up-arrow`）。共有（`auto_sync`）と新しい版の確認は切った。記録は手元の `~/.local/share/atuin` だけ
  - fzf も `Ctrl-R` を設定していて、home-manager が注意を出したので、fzf の `historyWidget.command = ""` で fzf の `Ctrl-R` を切った（`Ctrl-T`・`Alt-C` はそのまま）
  - 入れたあと、`atuin import zsh` で今までの履歴を取り込む
- just（`pkgs.just`）: プロジェクトの `justfile` に、よく打つコマンドを名前付きで書いて `just 名前` で呼ぶ

### テトリス（vitetris）を入れた。メニューで落ちる問題を直した

- `nix run nixpkgs#vitetris` で遊ぼうとすると、`zsh: trace trap` で落ちた（ユーザーの報告）
- pty で再現した: 起動して最初の Enter で SIGTRAP。lldb を横からつなぐと、`addopt` の `strcpy` で `__strcpy_chk` → `__chk_fail_overflow`（文字列のはみ出しの見張り）
- 元のプログラム（`src/options.c`・`options.h`）を読むと、`struct option` の最後の `char tp_key[4]` に長いキーを書く昔の書き方で、`malloc` で長さぶん多めに取っているので、実際にははみ出していない。見張りの勘違い
- Nix の `hardeningDisable = [ "fortify" ]` だけでは直らなかった（macOS の開発キットも自分で `_FORTIFY_SOURCE` を付けるため）。`-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0` も足して組み立て直すと、メニューを進めてゲームを始めても落ちない
- `home.nix` の `home.packages` に、この直したもの（`pkgs.vitetris.overrideAttrs`）を足した。`tetris` で起動する

### ターミナルと sketchybar のフォントを JetBrains Mono にした

- 長く同じフォント（Maple Mono）だったので、気分を変えたい（ユーザーの希望）
- `pkgs.nerd-fonts.jetbrains-mono`（3.5.0）を入れ、Ghostty の `font-family` を `"JetBrainsMono Nerd Font"` にした。日本語は入っていないので、2番目の Maple Mono NF CN に任せる
- 名前はフォントのファイルの name テーブルで確かめた（family は `JetBrainsMono Nerd Font`）。上下の高さ（ascender 1020・descender 300・UPM 1000）が Maple Mono と同じなので、行の高さと `window-padding-y` の計算は変わらない見込み
- sketchybar も JetBrains Mono にした（`sketchybar/settings.lua` の `FONT`）。上下の高さが同じなので、三角の大きさの計算（`HEIGHT / 1.32`）はそのまま。三角の横幅も前と同じ 13 だった
- ユーザーが気に入ったので、この形に決めた

### MacBook を閉じて開いたあと、sketchybar のバーが数秒消える原因を調べた（対策は逆効果で、やめた）

- 読み込み直しの速さ: `sketchybar --reload` から全部の項目が出るまで約 1.4 秒。部分ごとに測ると、Lua の処理はほぼ 0 で、項目（134 個）をまとめて渡す `end_config` が約 0.4 秒
- 閉じて開いたときに読み込み直しているわけではなかった: sketchybar は 11/8 に起動してから一度も起動し直されていない（launchd の runs = 1）。Hammerspoon・yabai・skhd にも読み込み直しの命令はない
- 見立て: 閉じると内蔵の画面がつながっていない状態になり、開いて macOS から「画面がつながった」と知らせが来てから、sketchybar がバーを作り直す。その待ち時間がバーの消えている時間ではないか
- 確かめるため、一時的な記録の仕組みを足した（`sketchybar/items/debug/wake_log.lua`）: `system_will_sleep`・`system_woke`・`display_change` を受け取った時刻を、ミリ秒まで `~/Library/Logs/sketchybar/wake.log` に書く。`pmset -g log` の Wake の時刻と比べる。調べ終わったら消す
- 1回目の記録（00:18 に閉じて開いた）: ふたを開けて画面がついたのが 00:18:39、`display_change` が約 2 秒後、`system_woke` が約 6.5 秒後（0.4 秒の間に3回）。ユーザーによると、ロックを解除してからさらに数秒待ってバーが出る
- sketchybar 2.24.0 の元のプログラム（GitHub）で確かめたこと
  - スリープに入ると `sleeps = true` になり、描き直し（`bar_manager_update`）を全部止める。`false` に戻すのは `system_woke` だけ
  - `system_woke` は、macOS の `NSWorkspaceDidWakeNotification` と `com.apple.screenIsUnlocked` から来る
  - `sketchybar --trigger system_woke` は項目に知らせるだけで、`sleeps` は戻らない
  - `--reload` は `bar_manager_init` で中身を作り直し、`sleeps = false` に戻る
- 対策（`sketchybar/items/wake_fix.lua`）: `system_will_sleep` を覚えておき、3 秒以上たってから `display_change` が来たら `sketchybar --reload` する。閉じるときの画面の知らせで読み込み直さないよう、3 秒の待ちを入れた
  - 手で知らせを送って試した: 4 秒後の `display_change` では 0.3 秒後に読み込み直しが起き、1 秒後では起きなかった
  - 見込み: バーが出るのは、開いてから約 3.5 秒後（画面の知らせ 2 秒 + 読み込み直し 1.4 秒）。次に閉じて開いたときの記録で確かめる
- 2回目の記録（00:24 に閉じて開いた）: 画面がついてから約 3.2 秒後に `display_change` で読み込み直しが始まり、約 4.0 秒後に設定が読み込まれた。`system_woke` は約 6.7 秒後。記録の上では約 2.5 秒早く描き始めた
- ところが、ユーザーには「むしろ遅く感じた」。読み込み直しでバーがいったん消え、そのあと本物の `system_woke` でも画面に合わせてバーを作り直すので、消える時間が2回に分かれたためと考えられる
- 対策（`wake_fix.lua`）も、調べるための記録（`debug/wake_log.lua` と `wake.log`）も消して、元に戻した
- 結論: 遅れの大部分は、macOS が復帰・ロック解除の合図を出すまでの時間。sketchybar の設定で縮める、よい方法は今のところない

## 2026-11-21

### tmux のステータスバーの左右の空白を、Ghostty の余白の塗り方で埋めた

- 空白の正体: Ghostty の左右の余白（`window-padding-x = 10`）と、マス目で割り切れない右端の余り。tmux はマス目にしか描けないので、そこはターミナルの背景（bg1）のままで、バー（bg0）とずれて見えていた
- `window-padding-color = "extend"` にした: 余白を、隣のマスの背景の色で塗る。バーの行は左右もバーの色になり、ふだんの行は背景と同じ色のままなので文字の余白は残る
  - 余白をなくす案（`window-padding-x = 0`）は、すべての行で文字が端にくっつくので、こちらにした
- 反映: `rebuild` → Ghostty で `Cmd + Shift + ,`
- ユーザーが見て「いい感じ」とのことで、この形に決めた

### ターミナル全体（Neovim を含む）を半透明にしてみたが、元に戻した

- Ghostty（`home.nix`）: `background-opacity = 0.85`・`background-blur = 20`（後ろをぼかす）。macOS では、Ghostty を一度終わらせて開き直さないと効かない
- Neovim（`nvim/init.lua`）: gruvbox.nvim の `transparent_mode = true`。左端の列（git や診断の印）は本文と同じ色で塗っていたので、ここも塗らない（`NONE`）にした。カーソル行・ステータスライン・浮かぶウィンドウは、色が残る
  - `--headless` で、Normal・SignColumn の背景が塗られていない（nil）こと、カーソル行は `#3c3836` のままなことを確かめた
- tmux（`home.nix`）: ペインの区切り線の背景を塗らない（`bg=default`）。ステータスバーは bg0 のまま
- 反映: `rebuild` → Ghostty を開き直す → tmux で `prefix + r`
- ユーザーの希望で元に戻した（`git checkout -- home.nix nvim/init.lua`）

### sketchybar のバー全体の背景を、tmux のステータスバーと同じ色にした

- バー全体（項目のないところ）は透明だったのを、tmux の `status-style` の背景と同じ bg0（`#282828`）にした（`sketchybar/style.lua`）
  - 前にターミナルの背景色（bg1 `#1d2021`）を試して戻したが、今回は tmux のバーの色
- 左右のかたまりの背景も bg0 なので、バー全体がひと続きの色になる。かたまりの端の三角（`front_app.end`・`right.start`）も同じ色なので見えなくなる（tmux のバーと同じ見え方）

### sketchybar の通信速度の左にも区切りを足した

- 右側のいちばん左（通信速度の左）にも、項目の間と同じ細い区切り線を足した（`items/init.lua` の `right_gap("stats.net_left")`）。stats を隠すと一緒に隠れる

### sketchybar の今のアプリを、1段明るい帯（bg3）にした

- バー全体を bg0 にしたら、スペースのアイコンと今のアプリの境目が見えなくなり、わかりにくかった（ユーザーの指摘）
- 区切り線を足す案と、今のアプリだけ帯の色を変える案から、帯の色を変える案を試した
- `items/front_app/front_app.lua`: アイコンと名前の帯を bg3（`#3c3836`）にした。帯の始まりに「bg0 → bg3」の三角（`front_app.start`）を足し、終わりの三角（`front_app.end`）も bg3 にした
- ユーザーの希望で、逆に暗くした: bg3 → bg1（`#1d2021`。ターミナルの背景と同じ色）
- 見比べて、明るいほう（bg3）に戻した
- ユーザーが気に入ったので、この形に決めた。bg3 は Gruvbox の bg1 で、Neovim のカーソル行・tmux や fzf・lazygit の選んでいる行と同じ色（「今いる場所」の色としてそろう）

### sketchybar の左右のかたまりを、形に沿って線で囲んでみたが、元に戻した

- ユーザーの希望: 矢印の形を変えずに、全体を枠で囲みたい。四角で囲む案と、かたまりの形に沿う案から、形に沿う案を選んだ
- 上下の辺: 左右のかたまりの後ろに、線（1pt・fg3 `#7c6f64`。右側の細い区切り線と同じ色）で囲んだ背景を、上下に 1pt ずつ大きく（高さ 27）敷いた（ブラケット `left.bg`・`right.bg`）。線の内側が、ちょうどかたまりの高さ 25 になる
  - 左側のかたまりの範囲を決めるため、リンゴの項目に名前（`apple.logo`）を付けた
- 端の三角: 線の色の大きい三角（高さ 27）の上に、今の三角（高さ 25）を重ね、はみ出した 1pt を線にした（`helpers/powerline.lua` の `outlined_arrow`）
  - 最初は2つの三角が横に並んだ。文字の幅を決めると負の余白が効かないため。大きい三角の幅を 0 にして、同じ位置から描かせた
- 画面は見られないので、見た目はユーザーのスクリーンショットで確かめる
- ユーザーの希望で、線を太くした（1pt → 2pt。`LINE_WIDTH` を変えるだけで、囲みの背景は高さ 29、大きい三角は高さ 29 になる）
- 見たうえで、思っていたのと違ったので、ユーザーの希望で元に戻した（ブラケット `left.bg`・`outlined_arrow`・`outlined_block`・リンゴの名前を消し、右側の背景と端の三角を前の形に戻した）

### sketchybar の右側の見た目をそろえた

- ユーザーと一緒に見た目を見直し、気になった4か所を試しに変えた
- 通信量（`items/monitor/netspeed.lua`）: 11pt の上下2行をやめ、ほかと同じ 13pt の1行（↓受信 ↑送信）にした。通信していないときは暗い色
- CPU・RAM（`items/monitor/cpu.lua`・`mem.lua`）: グラフをやめて、アイコンと「%」だけにした。RAM が赤い箱に見えていたのは、使用率 83% のグラフで埋まっていたため。赤くするのは CPU 80%・RAM 90% から（macOS はメモリをたくさん使うのがふつう）
  - 使わなくなった `helpers/graph_utils.lua` は、この形に決めたので消した（`sketchybarrc` の読み込みも）
- アイコンの色: 項目ごとにばらばらだった色を、ふだんは文字と同じ `subtext0` にそろえた（リンゴ・前のアプリ・音量・Wi-Fi・カレンダー・git・stats の切り替え・電池）。注意してほしいときだけ色を付ける（電池 40% 以下・Wi-Fi が切れた・CPU/RAM の使いすぎ）
- スペース（`helpers/spaces_util/sbar_util.lua`）: アプリのないスペースの「—」をやめ、番号だけにした（区切りとアイコンの部分を隠し、選んでいるときは右端の三角を番号のブロックの色で続ける）

### tmux のステータスバーを、画面の下の sketchybar に移す試作（bottombar）→ やめた

- 目的: tmux のバーを高くしたい。tmux は1行の高さでしか描けないので、同じ見た目・機能のバーを sketchybar で描く
- sketchybar は名前ごとに別のバーとして動く（本体の中で `git.felix.名前` を使う）。`bottombar` という名前で起動すると、上のバーとは別の、2本目のバーになる。SbarLua にも `set_bar_name` がある
- 作ったもの（`~/nix-config/bottombar/`）
  - `bottombarrc`: 下のバー。高さ 30・色 bg0・左右の端はウィンドウ（yabai の余白 8）にそろえる。中身と色は home.nix の tmux の設定と同じ（左: セッション名・ユーザー名、ウィンドウ一覧、右: 虹色の三角・ホスト名）。tmux に `display` と `list-windows` で聞いて書き直す。フォルダの移動は1秒ごとに拾う
  - `tmux.conf`: tmux のフックで、ウィンドウ・セッション・ペインが変わったら `bottombar --trigger tmux_update` で知らせる。prefix を押したことは外に知らせる方法がないので、`prefix None` にして `C-a` を自分で受け、prefix の状態にするのと一緒に `tmux_prefix` を知らせる。離したことは bottombar が 0.05 秒ごとに確かめる
- 試作の間は `rebuild` なし: bottombar は手で起動、yabai の下の余白は `yabai -m config bottom_padding 30`、tmux は `source-file` で読ませた。どれも Mac か tmux を起動し直すと消える
- 確かめたこと: 中身と色が tmux のバーと同じ。prefix を押した状態にすると水色になり、戻すと 0.3 秒以内に元の色に戻る
- tmux と違うところ: 動きがあったウィンドウの下線は引けないので、斜体にした
- 本番にするときの注意: tmux のバーを消すと、continuum の自動保存（status-right で動く）が止まる
- 使ってみて不便なことが多かったので、ユーザーの希望でやめた。bottombar を止め、yabai の下の余白を 8、tmux の prefix（`C-a`・`send-prefix`）とフックを元に戻し、`~/nix-config/bottombar/` を消した

### Ghostty の行の高さを 10% 広げてみたが、元に戻した

- tmux のステータスバーを高くしたい（ユーザーの希望）。tmux はターミナルの行の単位でしか高さを変えられないので、Ghostty の行の高さを広げる（`adjust-cell-height = "10%"`）
  - `status 2` で空の行を足す案は、文字が上に寄って違和感があるので、やめた
- ターミナル全体の行の間隔も広がる
- 気に入ったら合わせて直すもの: `window-padding-y`（今の 49px の行で割り切れるように決めた値）と、sketchybar の区切りの高さ（25。今の行の高さに合わせている）
- 反映後、tmux の `client_cell_height` で 1行が 49px → 54px になったことを確かめた
- 全画面の高さ（2230px）で下に約 46px の隙間が残るので、`window-padding-y` を `"12,0"` → `"8,0"` にした（2230 - 16 = 2214 = 54 × 41 行）
- 反映して測り直すと、1行は 55px だった（54px は、読み込み直しの途中の値だったらしい）。8 では下に 14px 残るので、`"15,0"` にした（2230 - 30 = 2200 = 55 × 40 行）
- 計算の上では隙間がなくなったが、ユーザーの見た目では変わらなかった（Ghostty が開いているウィンドウに余白を反映していないのか、yabai の下の余白 8pt なのかは、分からないまま）
- ユーザーの希望で、`adjust-cell-height` を消し、`window-padding-y` も `"12,0"` に戻した（`git checkout -- home.nix`）

## 2026-11-18

### sketchybar の右側の背景を、左側と同じ色にした

- 左側の項目は背景が bg0（`#282828`）だったが、右側の項目は背景がなく透明だった
- `sketchybar/items/init.lua` で、右側の項目全部を1つのブラケット（`right.bg`）で囲み、背景を bg0 にした（高さ 25・角なし。左と同じ `PL.block`）
  - 項目ごとに色を付けると、間の区切りや余白の項目が透明のまま残るので、まとめて1枚で囲んだ
  - stats や git を隠すと、囲みからも外れて背景が縮む
- `sketchybar --reload` で反映（`rebuild` は要らない）。`sketchybar --query right.bg` で、色が `0xff282828` になっていることを確かめた
- 右側の左端も、左側の終わりと同じく三角で尖らせた（`right.start`。塗りの左向きの三角 `e0b2` を bg0 の色で、背景は透明）
  - 右側の項目の中で最後に足すので、stats を隠しても、いつも右側のいちばん左に来る
  - 三角と背景の間に細い隙間が見えた（ユーザーの報告）。位置の上では隙間なく並んでいたので、三角の平らな辺が文字の枠の右端に少し届いていないとみて、`padding_right = -1` で 1 だけ背景に重ねた
  - ユーザーのスクリーンショットで、隙間が消えたことを確かめた

### sketchybar の区切りの高さを 32 にしてみたが、25 に戻した

- 縦の幅を大きくしたい（ユーザーの希望）ので、`helpers/powerline.lua` の `M.HEIGHT` を 25 → 32 にし、右側の細い区切りの画像も高さ 32・幅 14 で作り直した
- 見たうえで、ユーザーの希望で元の 25（tmux のステータスラインと同じ高さ）に戻した。画像も git から元のものに戻した

### sketchybar のバー全体の背景をターミナルの背景色にしてみたが、透明に戻した

- バー全体（項目のないところ）は透明で、壁紙が見えていた
- `sketchybar/style.lua` のバーの色を `COLORS.bg1`（`#1d2021`。Ghostty の Gruvbox Dark Hard の背景と同じ。Ghostty は半透明にしていない）にした
- 左右の項目の背景（bg0 `#282828`）は、そのまま。バーより少しだけ明るく見える
- 見たうえで、ユーザーの希望で透明に戻した

## 2026-11-17

### ウィンドウを割り込ませるキーを足した（yabai の warp）

- 4つのウィンドウを田の字に並べたいが、今までのキー（入れ替え）では場所が変わるだけで、並びの形は変えられなかった
- `skhd/skhdrc` に `ctrl + shift + alt - h/j/k/l` → `yabai -m window --warp 方向` を足した。選んだウィンドウが、その方向のウィンドウの隣に割り込む
- 田の字にする手順: 割り込ませて形を作り、`alt - e`（均等にする）で大きさをそろえる
- skhd は `~/nix-config/skhd/skhdrc` を直接読むので、`rebuild` は要らない（skhd を読み込み直せば効く）

## 2026-11-10

### opencode を入れた

- これまでは `nix run nixpkgs#opencode` で一時的に動かしていただけで、新しいターミナルでは `opencode` が見つからなかった
- `home.nix` の `home.packages` に `pkgs.opencode`（1.18.34）を足した。メインは Claude Code で、opencode は試しに使う用
- 設定は `~/.config-nix/opencode/opencode.jsonc`（中身はほぼ空）。AI を選ばないと opencode の無料の `big-pickle` が使われる

## 2026-10-18

### Neovim のノーマルモードで日本語入力の文字が本文に入る原因が分かり、対策を足した

- 症状（ユーザーの報告）: ノーマルモードで日本語入力のまま打つと、文字が本文に書き込まれて残る。WezTerm では起きていなかった
- 調べたこと
  - Ghostty が送るもの: Neovim と同じキーの送り方の方式で「あい」を打ってもらい、届いた中身を記録した → `あい` の文字だけで、余計なものは無かった
  - pty → tmux → Neovim の順につないで `；lkj` などを一度に送った → 本文には入らなかった（tmux の貼り付け扱いでもない）
  - ユーザーの Neovim に `vim.on_key` で届いたキーを記録する仕掛けを一時的に入れて、実際に打ってもらった → ノーマルモードで `l` `；` `か` `s` の順に届き、`s`（1文字消してインサートモードに入るコマンド）が効いてインサートモードに入っていた
- 原因: 日本語入力は、ひらがなにできなかった英字（`s` `l` など）をそのまま確定して送ることがある。それが Vim のコマンドとして効き（`s` `a` `i` `o` `c` など）、インサートモードに入って、あとの文字が書き込まれていた。Neovim からは日本語入力の `s` とキーボードの `s` を区別できない
  - 前日の項目に書いた「打ったキーが日本語になってコマンドとして効かない」は、原因の見立てが違っていた
- 対策: ノーマルモードでは日本語入力をオフにしておく（`nvim/init.lua`）
  - 前日に足した「編集モードを抜けたとき・起動したとき・画面に戻ったときに英字にする」はそのまま
  - 足したもの: ノーマル・ビジュアル・オペレータ待ちのモードで日本語などの文字（UTF-8 で2バイト以上）が届いたら、すぐ英字にする（`vim.on_key`）。文字そのものは捨てない（`f` や `r` で日本語の文字を使うため）。まとめて届くので、切り替えは 0.3 秒に1回まで
- 確認（`--headless` で macism を使って試した）: ノーマルモードで「か」が届くと ABC に戻る。インサートモードで「か」を打つと日本語入力のままで、本文に入る
- 使った記録用の仕掛けは外した
- 反映（`darwin-rebuild switch`）後、ユーザーが一度「直った」と言ったが、まだ残っていた: ノーマルモードで変換中に英字へ切り替えると、それまでの文字がまとめて確定して届き（例「かsてすと」）、`s` が効いて「てすと」が本文に入る
  - pty → tmux → Neovim で「かs」「かsてすと」を一度に送って再現した（英字に戻すだけでは、確定の文字は止まらない）
  - 足したもの: ノーマル・ビジュアルのモードで日本語の文字が届いたら、そのあと 30ms 以内に続けて届く英字は捨てる（一緒に確定したものとみなす。人が打つ間隔はこれより長い）
  - 確認: 「かきく」「かs」「かsてすと」「てすとa」「かkjしo」はどれも本文に入らずノーマルモードのまま。「ihello」「iてすと」は今までどおり本文に入る
  - 残る穴: 確定の文字列が英字から始まるとき（「sか」など）、先頭の英字は日本語の文字より先に届くので止められない
- それでも直らなかった（ユーザーの報告）: 試した Neovim の `.` レジスタは `l;dkfja;lskdfj` で、英字に切り替えたときに変換中の文字がローマ字のまま確定して届いていた。日本語の文字が無いので、上の仕組みでは見分けられない
  - 届いた文字で見分けるのはやめて、根っこを断つことにした: ノーマル・ビジュアルのモードで日本語入力をオンにした瞬間に英字へ戻す（変換中の文字をそもそも作らせない）
  - `nvim/ime-watch.js`: macOS が入力ソースの切り替えのたびに配る通知（`com.apple.Carbon.TISNotifySelectedKeyboardInputSourceChanged`）を受けて1行出す。`osascript -l JavaScript` で動くので、新しく入れるものは無い
  - `nvim/init.lua`: 起動時にこれを `jobstart` で裏で動かす（Neovim を閉じると一緒に終わる）。知らせが来たら、この Neovim を使っていて（FocusGained / FocusLost で覚える）ノーマル・ビジュアルのモードのときだけ、英字でなければ英字に戻す
  - Neovim が何個開いていても、使っていない Neovim は何もしない（ほかのアプリで日本語を打つのを邪魔しない）
  - 確認（`--headless`）: ノーマルで日本語にする → すぐ ABC に戻る。インサートで日本語にする → そのまま。インサートを抜ける → ABC。FocusLost のあとに日本語にする → そのまま。Neovim を閉じると見張り役も終わる
- ユーザーが直ったことを確かめた。そのあと、いらなくなったものを外した（ユーザーの希望: 無駄を省く）
  - 外した: `vim.on_key` の「日本語の文字が届いたら英字に戻し、30ms 以内に続く英字を捨てる」。見張りで変換中の文字ができなくなったので不要
  - 残した: 見張り（ime-watch.js）と、InsertLeave / VimEnter / FocusGained で英字にする自動コマンド（日本語入力のまま編集モードを抜けても切り替えは起きないので、見張りでは気づけない）
  - 確認: 外したあとも上と同じ4つの試しが同じ結果になった
- 手入れしやすくするため、1つのファイルにまとめた（ユーザーの希望）
  - 探し直したが、「ノーマルモードで日本語入力をオンにしたら戻す」ところまでする一般的なプラグインは無かった（im-select.nvim、macism-ime.nvim、auto-input-switch.nvim などは、どれもモードが変わったときに切り替えるだけ）
  - `nvim/lua/ime.lua` に全部まとめ、見張り役の JavaScript も文字列として中に入れた（`osascript -l JavaScript -e`）。`nvim/ime-watch.js` は消した
  - `init.lua` は `require("ime")` の1行だけ。いらなくなったら、この1行と `lua/ime.lua` を消せば元どおり
  - JavaScript に `]]` が含まれるので、Lua の文字列は `[==[ … ]==]` で囲む（`[[ … ]]` だと途中で切れて読み込みエラーになった）
  - 確認: 同じ4つの試しが同じ結果になった
- 結局、一般的なやり方だけの数行にした（ユーザーの希望: 数行にする）
  - `init.lua` に InsertLeave / VimEnter / FocusGained で `macism com.apple.keylayout.ABC` を呼ぶ自動コマンドだけを置いた。`lua/ime.lua`（見張り役）は消した
  - 分かっていて残した穴: ノーマルモードで自分から日本語入力をオンにすると、また文字が入る。日本語入力のまま編集モードを抜けたときは英字に戻る
  - 確認: インサートを抜けると ABC。ノーマルで日本語にしても戻らない（見張りを外したので、そうなるはず）
- 見張りを消したのは間違いだった（ユーザー: 見張りは残す。「数行に」は見張りを残したまま短くする意味だった）。`lua/ime.lua` を見張りつきの形に戻し、`init.lua` も `require("ime")` に戻した
  - 確認: 4つの試しが、まとめたときと同じ結果になった

## 2026-10-17

### Neovim で編集モードを抜けたら英字入力に戻すようにした

- 困っていたこと: 日本語入力のままノーマルモードに戻ると、打ったキーが日本語になってコマンドとして効かない
- 入力ソースをコマンドで切り替える `macism`（nixpkgs にある）を `home.packages` に足した
- `nvim/init.lua`: 編集モードを抜けたとき（InsertLeave）・起動したとき（VimEnter）・Neovim の画面に戻ったとき（FocusGained）に `macism com.apple.keylayout.ABC` で英字にする。macism が無い環境では何もしない
  - 編集モードに入るときは切り替えない（日本語を打つときは自分で切り替える）
  - tmux の中でも FocusGained が届くことを確認（`focus-events on` は前から入っていた）
- 入力ソースの名前は `macism`（引数なし）で調べた: 日本語は `com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese`、英字は `com.apple.keylayout.ABC`
- 確認: ビルドでき、日本語にしてから Neovim を動かすと ABC に切り替わった

## 2026-10-16

### amtui を消した

- ユーザーの判断: 使いにくいのでやめる（色の設定を反映する前に、使えないと判断）
- `home.nix` から amtui の定義・`home.packages` の行・`AMTUI_CONFIG_DIR`・`config.toml` を消した
- 動いていた amtui と、それが開いた Chrome（`--user-data-dir=~/.config/amtui/chrome`）を止め、`~/.config/amtui`（サインイン情報）も消した
- 確認: `home.nix` に amtui が残っていないこと、ビルドが通ることを確かめた。反映（`darwin-rebuild switch`）はユーザーが行う
- 下の2つの項目は、入れていたときの記録として残す

### amtui を入れた（Apple Music をターミナルで聴く道具）

- 最初は名前だけで探して、同じ名前の別の道具（pehlicd/amtui、Alertmanager を見るもの）を入れてしまった。ユーザーが欲しかったのは Apple Music 用なので置き換えた
- 入れたのは k1y0miiii/applemusic-tui v0.1.0（元の作者の版）。手を加えた版（michael-slop、CPU 使用が軽い）もあるが、使っている人が多い元の版をユーザーが選んだ
- 裏で Chrome（/Applications の Google Chrome）を動かし、Apple Music の Web 版を操作する。使うには Apple Music の契約が要る。初回は Chrome の画面が開くので Apple ID でサインインする（ログイン状態は `~/.config/amtui/chrome` に残る）
- nixpkgs に無いので、`amp` と同じく `home.nix` の let の中で GitHub からビルドする
  - 音に合わせて動く表示は CoreAudio を使うので cgo ありでビルドされる（`otool -L` で CoreAudio につながっていることを確認）
  - `engine/lifecycle_test.go`・`engine/musickit_test.go` のテストは本物の Chrome を起動するので、ビルド中の閉じた場所では必ず失敗する。この2つだけ `preCheck` で外した（ほかのテストは通っている）
  - Go のビルドではフォルダ名の `applemusic-tui` という名前になるので、公式の入れ方と同じ `amtui` に名前を変えた
- 確認: Mac 全体の設定がビルドでき、`amtui --version` で `v0.1.0 darwin/arm64` と出た
- 使い始めで Chrome の窓が出なかった: amtui を2つのタブで同時に起動していて、同じ Chrome 用フォルダを取り合い、白紙（about:blank）で止まっていた。1つだけで起動すればよい
  - 起動してから最大1分半ほどは、Chrome が画面の外で読み込むので何も見えない。サインインが要るときだけ窓が出てくる

### amtui の色を Gruvbox にした（nix-config で管理）

- `home.nix` で `~/.config-nix/amtui/config.toml` を作り、`[theme] name = "gruvbox"` にした
- amtui は XDG_CONFIG_HOME を見ず `~/.config/amtui` を読む（ソースの `configDir()` で確認）。ほかの道具と同じく `~/.config-nix` に置くため、`AMTUI_CONFIG_DIR` を足した
- サインイン情報（`~/.config/amtui/chrome`）は置き場所が決め打ちで、この変数に関係なく `~/.config/amtui` に残る
- amtui の中で `t` を押すと色は変わるが、起動時は設定ファイルの色が優先されるので、次の起動で Gruvbox に戻る
- 確認: ビルドでき、できる設定ファイルの中身と `AMTUI_CONFIG_DIR` の値を確かめた

## 2026-10-15

### Ghostty の作業中のバーの色をオレンジにした（tmux の中の Claude で出す工夫は、やめた）

- ウィンドウの上の細いバーは、Ghostty が作業中の合図（OSC 9;4）を受けて出すもの。Ghostty の設定は出す・出さない（`progress-style`）だけで、色は macOS のアクセントカラー（決まった8色）
- `darwin.nix`: `system.defaults.CustomUserPreferences."com.mitchellh.ghostty".AppleAccentColor = 1`（Ghostty だけオレンジ。Ghostty を開き直すと効く）。Gruvbox の色にはできない
- 分かったこと: Claude Code は `TERM_PROGRAM` が ghostty（1.2.0 以上）か iTerm.app のときだけ合図を出し、tmux の中では tmux のパススルー（`\ePtmux;…`）で送る。tmux の中では `TERM_PROGRAM=tmux` なので出さない（プログラムの中の判定を読んで確認）
- 試して、やめたこと（ユーザーの判断: 設定が複雑になるだけ）: zsh で `claude` を `TERM_PROGRAM=ghostty` 付きで起動する関数、tmux の `allow-passthrough on`、`terminal-features` の `xterm-ghostty:progressbar`。どれも取り消し、動いている tmux からも外した
- tmux の外で動かした Claude や、ほかのプログラムのバーはオレンジになる

### sketchybar を矢印の見た目にした（左は tmux のウィンドウ一覧、右は Neovim のステータスライン）

**決めたこと**（ユーザーの希望）
- 左は tmux のウィンドウ一覧（タブ）と同じ形。スペースが増えると矢印も増える
- 右は Neovim のステータスラインのように、細い三角で区切るだけ
- 高さは tmux のステータスラインと同じ。りんごは赤で、背景は tmux のセッション名と同じ色

**やったこと**
- `settings.lua` に `BAR_STYLE`（`"arrows"` / `"islands"`）を足した。`"islands"` にして `sketchybar --reload` すれば前の見た目に戻る
- `helpers/powerline.lua`: 三角の記号（Nerd Font の e0b0 など）を「文字の色 = 前の区切りの色、背景 = 次の区切りの色」で置く部品
  - 高さ 25: Ghostty の font-size 18.5 × 1.32（Maple Mono NF の1行の高さ）= 24.42 を Ghostty が Retina の点に丸めて 24.5。sketchybar の高さは整数なので 25
  - 三角の記号は文字の上端〜下端（1.32 文字ぶん）ちょうどの形なので、文字の大きさを 25 ÷ 1.32 にすると背景と同じ高さになる（fontTools で測った）
- 左: 赤いりんご（背景 bg0）→ 暗い帯（bg0）の上にスペースを並べる → 今のアプリ名 → 三角で帯を閉じる
  - スペース1つを5つの項目（左の三角・番号・間の三角・アイコン・右の三角）に分けた。どれも space 型で同じスペースを受け持つので、スペースが無いときはまとめて隠れる
  - 色は tmux の `window-status-current-format` / `window-status-format` と同じ。今いるスペースは 番号（fg1）▶ アイコン（fg3）▶、ほかは帯の上に `番号 ❯ アイコン`
  - space 型の項目は選ばれると自動で highlight_color に変わるので、color と highlight_color を毎回同じ色にしている
  - メニュー（アプリのアイコンを押すと出る）も同じ帯に入れた
- 右: 項目の間のすき間を、細い三角の区切りにした
  - フォントの e0b3 は線が太い（Maple Mono NF で 0.086 文字 ≒ 1.6pt。Moralerspace・Recursive も約 1.4pt）。Ghostty は tmux の区切りを下線の太さ（1pt）で自分で描いているので、同じ形・同じ太さの画像 `images/sep_thin_left.png`（magick で作った。作り方は `items/init.lua`）を背景に置いた
  - 幅を決めた項目には左右の余白が効かず、隣の項目に重なったので、見えない余白の項目（幅 5）ではさんだ
  - CPU などを隠したとき・git のブランチが出ていないときは、隣の区切りも一緒に隠す（`rsep.stats.*`・`rsep.git*`）
- 確認: 項目の位置を `sketchybar --query` で調べ、左は隙間なく並び、右の区切りは両隣と約 8 ずつ空いていることを確認。見た目はユーザーがスクリーンショットで確認した（この端末には画面を写す許可がない）

**注意**
- 区切りの画像の色（fg3）は画像に焼き込んである。テーマの色を変えたら作り直す

## 2026-10-14

### 手入れを自動にした（古い世代の掃除・同じファイルをまとめる）と README

- 背景: `/nix/store` が 12GB。世代は Mac 全体 14 個、ユーザー側に home-manager 44 個・profile 36 個（nix-darwin を入れる前の、home-manager 単独のころのもの）がたまっていた
- `darwin.nix`: `nix.gc`（毎週日曜 3:15、`--delete-older-than 14d`）と `nix.optimise`（毎週日曜 4:15）。root で動く
- `home.nix`: ユーザーの世代（`~/.local/state/nix/profiles`）は root の掃除では消えないので、`launchd.agents.nix-gc-user` を自分で書いた（毎週日曜 3:00、ログは `~/Library/Logs/nix-gc-user.log`）
  - home-manager の `nix.gc` を使わなかった理由: Mac では `options` を1つの引数のまま渡すので、`nix-collect-garbage` が `unrecognised flag '--delete-older-than 14d'` で失敗する（手で確かめた）
- 14 日にした理由: 変更でおかしくなったと気づいて戻すには2週間あれば足りる。その前の世代には戻せなくなる
- devShell は nix-direnv が掃除から守っているので、プロジェクトの環境は消えない
- 確認: ビルドが通り、できた起動設定3つの中身（コマンドと引数、曜日・時刻）を確認した。ユーザーが `rebuild` で適用し、`org.nixos.nix-gc`・`org.nixos.nix-optimise`（/Library/LaunchDaemons）と `org.nix-community.home.nix-gc-user` が登録されたことを確認
- `README.md` を足した（公開したので、何のリポジトリか・使い方を短く）

### 旧環境の起動設定（LaunchAgents）を消した

- `~/Library/LaunchAgents` から4つ消した。どれも読み込まれておらず、起動するプログラム（Homebrew の yabai・skhd・sketchybar・stats_provider）ももう無い
  - `com.asmvik.yabai.plist`・`com.koekeishiya.skhd.plist`・`homebrew.mxcl.sketchybar.plist`: `~/old-env-backup-2026-10-13/LaunchAgents/` に写してから消した
  - `com.sketchybar.stats-provider.plist`: `~/dotfiles` の中のファイルへのリンクだったので、リンクだけ消した（元のファイルは残っている）
- 残したもの: MongoDB（使っている）、Google の3つ、Nix の `org.nix-community.home.*`
- 確認: Nix の yabai・skhd・sketchybar・sketchybar-stats と MongoDB は動いたまま

### GitHub のいらないリポジトリを、アーカイブして非公開にした

- ユーザーの判断: 使うのは coffee-app・mlb-app・nix-config だけ。ほかは消さずに「アーカイブ＋非公開」にする（いつでも戻せる）。プロフィールの自己紹介（`hikaru181069`）は公開のまま残す
- 対象 10 個: study-log-app・youtube-channel-manager・netabare-app・dotfiles・atcoder・dev-notes・obsidian-dev-notes・nvim・nvim-config・desktop-tutorial
- アーカイブすると設定を変えられないので、非公開にしてからアーカイブした。dotfiles はアーカイブ済みだったので、いったん外して非公開にし、またアーカイブした。学内なので Homebrew の gh を使った
- 確認: `gh repo list` で 10 個とも PRIVATE・アーカイブ。公開は coffee-app・mlb-app・hikaru181069 だけ
- 注意: アーカイブしたものには push できない。手元の `~/study-log-app`・`~/youtube-app`・`~/netabare-app`・`~/Documents/dev-notes` はそのまま使えるが、push するなら先に `gh repo unarchive` が要る
- 戻し方: `gh repo unarchive hikaru181069/<名前>`、公開に戻すなら `gh repo edit hikaru181069/<名前> --visibility public --accept-visibility-change-consequences`

### Mac の名前をさらに hikaru-mbp に変えた

- `MacBook-Pro` はみんなが使う最初の名前なので、学校などのネットワークではまたかぶって番号が付きやすい。自分だけの名前にした
- `darwin.nix` の `networking.computerName`・`networking.localHostName` を両方 `hikaru-mbp` に（画面に出る名前もそろえた）。`flake.nix` の `darwinConfigurations` の名前も `"hikaru-mbp"` に
- ビルドが通り、`activate` に `scutil --set ComputerName hikaru-mbp`・`scutil --set LocalHostName hikaru-mbp` が入っていることを確認
- 1回目の適用は名前を指定する: `sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/nix-config#hikaru-mbp`。ユーザーが適用し、ComputerName・LocalHostName とも `hikaru-mbp` になったことを確認

### Mac の名前を MacBook-Pro-5 から MacBook-Pro にした

- 理由: ローカルホスト名の `-5` は、ネットワーク上で名前がかぶったと macOS が判断して自動で付けた番号（ほかの機器や、ルーターなどが覚えていた自分の古い名前とかぶると増える）。画面に出る名前（ComputerName）も `MacBook  Pro` と空白が2つになっていた
- `darwin.nix` に `networking.computerName = "MacBook Pro"` と `networking.localHostName = "MacBook-Pro"` を書いた。nix-darwin が適用のたびに `scutil --set` で名前を合わせ直す（ビルドしたものの `activate` に入っていることを確認）
- `darwin-rebuild` は今のローカルホスト名で設定を選ぶので、`flake.nix` の `darwinConfigurations."MacBook-Pro-5"` も `"MacBook-Pro"` に変えた
- 注意: 1回目の適用のときは Mac の名前がまだ `MacBook-Pro-5` なので、`rebuild` では設定が見つからない。名前を指定して適用する: `sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/nix-config#MacBook-Pro`。2回目からは `rebuild` でよい
- ユーザーが `#MacBook-Pro` を付けて適用した（先に `rebuild` で試し、上の注意どおり「見つからない」になった）
- 確認: ComputerName `MacBook Pro`、LocalHostName `MacBook-Pro`（`MacBook-Pro.local`）。名前を指定しない `darwin-rebuild build --flake ~/nix-config` でも設定が見つかる

### tmux の中で claude が見つからず、nvim が初期状態になる問題を直した

- 症状: tmux の新しいペインで `claude` が見つからない。nvim は起動するが、自分の設定が読まれず初期状態
- 原因: tmux の本体（サーバー）は 10/9（envswitch のころ）から動きっぱなしで、そのとき環境にあった「設定は読み込み済み」の目印（`__HM_SESS_VARS_SOURCED=1` など）を持っている。新しいペインはこれを引き継ぐので、home-manager の設定（`home.sessionPath` の `~/.local/bin`、`home.sessionVariables` の `NVIM_APPNAME=nvim-nix`）を読み飛ばしていた。どちらも tmux の起動後（10/12）に足した設定
  - `NVIM_APPNAME` がないと、nvim は `~/.config-nix/nvim`（ない）を探すので初期状態になる
- 今すぐの直し: `tmux set-environment -gu` で動いている tmux から目印を3つ消した。開いているセッションはそのまま。新しいペインで `claude` が見つかり、nvim の設定の場所が `~/.config-nix/nvim-nix` になることを確認
- 再発を防ぐ: `home.nix` の tmux の設定に、同じ3つを消す行を足した（`ZDOTDIR` を消している行の下）。ビルドが通ることを確認。適用（`rebuild`）はユーザーが行う

### 残りのプロジェクトに devShell を作り、旧環境の nvm・pyenv を消した

**devShell**（ユーザーと相談し、coffee-app と同じく各リポジトリの中に置くことにした）
- mlb-app・study-log-app・youtube-app に、`main` から `chore/nix-devshell` ブランチを作ってコミットした（`flake.nix`・`flake.lock`・`.envrc`）。別の作業フォルダ（git worktree）で作ったので、編集中の変更や今のブランチには触っていない
- push して PR を作った（Nix の gh は学内でつながらず、Homebrew の gh を使った）: mlb-app #20・study-log-app #1・youtube-channel-manager #2
- 3つともマージし、手元の作業ブランチに取り込んで `direnv allow` した。取り込んだのは devShell の3ファイルだけで、編集中の変更はそのまま（mlb-app の `feature/nav-discovery-first` は main と同じ位置から始まっていたので、早送りで取り込まれた）
- 確認: 各フォルダで `node` が Nix の v22.23.3、mlb-app は `python` が `.venv` のもので fastapi が読み込める
- `~/coffee-app` の `feat/k8s-bootstrap` にも main（devShell・Node 22 化）を取り込んだ（push はしていない）。`IMPLEMENTATION.md` が両方で末尾に書き足されていてぶつかったので、両方の記録を残して日付順（10/5・10/7 の k8s → 10/10 の Nix）に並べ、「次に実装すべき」の番号を 21・22 にした。どちらの側の行も消えていないことを diff で確認。編集中の `k8s/backend.yaml` はそのまま

**壊れていた `.venv` 5つを作り直した**
- 対象: `~/applied_programming_i/report/venv`・`~/applied_programming_ii/.venv`・`~/python-practice/.venv`・`~/coffee-app/fastapi-service/.venv`・`~/mlb-app/fastapi-service/.venv`
- Python は uv が管理する 3.13.13（`uv python install 3.13`、`~/.local/share/uv/python`）。Nix の Python で作ると、devShell の外では Nix の掃除（garbage collection）で消えて、また壊れるおそれがあるため
  - そのとき `~/.local/bin/python3.13` も置かれた（uv の仕組み）。プロジェクトの外でも `python3.13` は使える
- 部品は、壊れた `.venv` の中に残っていた一覧（`*.dist-info`）から、同じ版を入れ直した。5つとも数が一致（33・49・3・31・30）
- 確認: coffee-app の fastapi-service のテスト 10 件、mlb-app 12 件が通った。applied_programming_ii で numpy・pandas・matplotlib・ipykernel が読み込める
- coffee-app・mlb-app の `fastapi-service/.venv` は、ふだんは使われていない古いもの（devShell はリポジトリ直下の `.venv` を使う）

**`Hikaru` ユーザーを消した**
- 10/9 に作って使わなくなったユーザー。消えたこと（`dscl` に無い、`/Users/Hikaru` も無い）を確認
- 中身: 3つとも Node.js 22 と mongosh。mlb-app は Python 3.13 と uv も入れ、`.envrc` で `.venv` を作る（coffee-app と同じ形）
- Node 20 はサポート終了（2026-04-30）で nixpkgs から消えていたので 22 にした。mlb-app の Dockerfile は Node 20 のまま（別の機会に決める）
- 確認: 3つとも `nix develop` で `node -v` が v22.23.3
- `~/coffee-app` の `feat/k8s-bootstrap` には devShell がまだない（`main` を取り込めば入る）

**mlb-app の `.venv` を作り直した**
- pyenv の Python で作られていたので、Nix の Python 3.13.15 で作り直し、`requirements.txt` を入れた。fastapi-service のテスト 12 件が通った

**片付け**
- `~/.nvm`（743MB）・`~/.pyenv`（738MB）を消した。nvm にあった codex は Homebrew 版（cask）が使われているので影響なし
- nix-config の stash（sketchybar の右側を島にした試作）を捨てた
- 気づいたこと: 次の `.venv` は pyenv の Python で作られていて、**10/13 の Homebrew の片付けの時点で、もう動かなくなっていた**（pyenv の Python が Homebrew の gettext を使っていたため）。中の部品は `.venv` に残っているので作り直せる
  - `~/applied_programming_i/report/venv`・`~/applied_programming_ii/.venv`・`~/python-practice/.venv`・`~/coffee-app/fastapi-service/.venv`・`~/mlb-app/fastapi-service/.venv`
- 10/11 から開いたままの Neovim（`nvim backend`、旧環境の Mason の LSP）が nvm の node で動いていた。動いている間はそのままだが、LSP を再起動すると失敗する
- `~/Library/LaunchAgents` に旧環境の yabai・skhd の起動設定（`com.asmvik.yabai`・`com.koekeishiya.skhd`）が残っている。読み込まれてはいない（今は nix-darwin の `org.nix-community.home.*` が動いている）

---

## 2026-10-13

### sketchybar と Ghostty の小さな変更

- sketchybar の右側の作り直し（島・数字・色など）は試したがやめ、今朝の形に戻した。試した変更は `git stash` に残してある
- 残した変更: 日付と時刻をカレンダーのアイコン + 1行（`10/13 22:05`）にした。Docker の表示を外した
- Ghostty: tmux のステータスバーをウィンドウのいちばん下に置くため、余白を上 12・下 0 にした（全画面の高さ 2230px・1行 49px で、割り切れない余りが下に残らない値）。開いているウィンドウには効かず、新しいウィンドウから効く
- 返答が英語になる問題のため、`~/.claude/CLAUDE.md` に「返答は必ず日本語」と書いた（nix-config の外）

### 旧 dotfiles リポジトリをアーカイブした

- 旧環境の dotfiles（`~/.config` そのものが git リポジトリ、GitHub の `hikaru181069/dotfiles`、公開）は、今の設定がすべて nix-config にあるので、使い続けずに参照用として凍結することにした（ユーザーの判断。計画の「既存 dotfiles は参照用に残す」の仕上げ）
- コミットしていなかった変更2つ（sketchybar の git ブランチを tmux の中でも正しく出す工夫、WezTerm の文字の大きさと不透明）を「アーカイブ前の最後の状態」としてコミットし、SSH で push した（リモートの設定は HTTPS のままで変えていない）
- GitHub でアーカイブした（読み取り専用。`gh repo unarchive` で戻せる）。学内では Nix の gh がつながらないので、Homebrew の gh を使った
- `~/.config` のフォルダは Mac の中にそのまま残している。いずれ Nix の設定（今は `~/.config-nix`）を `~/.config` に移すかは、別の日に考える

### Homebrew を片付け、宣言したものだけにした（Step 6）

**決めたこと**（ユーザーと相談）
- Homebrew のコマンド 26 個を「消す」「Nix に移す」「残して宣言する」に分けた。旧環境のもの（nvm・pyenv・p10k など）も一緒に消すことにした
- 開発への影響: Nix 環境では PATH で Nix のものが先に見つかり、nvm・pyenv・p10k も読み込まれていないので、ふだんの作業は変わらない
- 気づいたこと（片付けとは別）: Nix 環境ではプロジェクトの外に `node`・`python` がない。devShell があるのは coffee-app の `chore/mac-native-dev`（`~/coffee-app-mac`）だけで、`~/coffee-app`・mlb-app・study-log-app・youtube-app で Mac 上で直接 `npm` などを打つと見つからない（Docker の中で動かすなら問題ない）

**やったこと**
- バックアップ: `~/old-env-backup-2026-10-13`（自分だけが読める）に、旧環境の設定ファイル一式（`.zshrc`・`.zprofile`・`.p10k.zsh`・`.gitconfig`・`~/.config` など）、片付け前の Brewfile、版の一覧、nvm・pyenv の版（Node v24.15.0・Python 3.13.13）、戻し方の README を置いた。`~/.nvm`（743MB）・`~/.pyenv`（738MB）は消していない
- `darwin.nix`: `cleanup = "uninstall"` にし、残すものだけを宣言した
  - cask 11 個（前と同じ）
  - mongodb-community@8.0・mongodb-database-tools（tap は mongodb/brew）: mlb-app の MongoDB。Homebrew のサービスとして 27017 で動いている
  - gh: Nix の gh が学内のネットワークでつながらない件の逃げ道（`/opt/homebrew/bin/gh` と打つ）
- `home.nix`: kind・poppler（`poppler-utils`）・imagemagick・git-filter-repo を Nix に移した
- 適用の前に、Nix が作った Brewfile で `brew bundle cleanup`（`--force` なし＝消さずに一覧を出すだけ）を試し、消えるものを確かめた
  - Homebrew に「信頼していない tap のものは読み込まない」仕組みが入っていて、yabai・skhd・sketchybar・sketchybar-system-stats の Homebrew 版（使っていない古いもの）は片付けの対象から外れた。tap を外す処理が途中で止まるおそれがあるので、先にユーザーが `brew uninstall` で手で消した（私の削除のコマンドは Claude Code の安全確認で止められたため）

**確認したこと**（`rebuild`、世代6）
- Homebrew に残ったのは formula 11 個（gh・MongoDB の2つと、その依存の小さなライブラリ）・cask 11 個・tap 1つ（mongodb/brew）。片付け前は formula 102 個・tap 4つ
- MongoDB は動いたまま（27017）。yabai・skhd・sketchybar（Nix 版）も動いたまま
- 新しいシェルで kind・pdftoppm・magick・git-filter-repo は Nix 版。nvim・tmux・eza・lazygit など、ほかのコマンドも Nix 版。Homebrew の gh（2.92.0）も `/opt/homebrew/bin/gh` で使える
- 戻し方: `brew bundle --file=~/old-env-backup-2026-10-13/Brewfile` で片付け前の Homebrew をまとめて入れ直せる

---

## 2026-10-12

### macOS の設定を nix-darwin で宣言した（Step 6）

- まず `defaults read` で今の値を読み、「今の値をそのまま宣言するもの（A）」と「この機会に変えるもの（B）」に分けて提案した。ユーザーが A と B の 1〜3・6 を選んだ
- A（見た目も動きも変わらない）: ダークモード、メニューバーを隠す（sketchybar を出すため）、Dock は左・自動で隠す・大きさ 40、Finder はカラム表示、トラックパッドはタップでクリックなし・3本指ドラッグなし・右クリックあり、スクリーンショットは `~/screenshots`、macOS のタイルの余白なし
- B（変えたもの）
  - `dock.mru-spaces = false`: スペースを最近使った順に並び替えない（yabai・sketchybar のスペース番号がずれるため）
  - キーの押しっぱなしで文字をくり返す（`ApplePressAndHoldEnabled = false`）。くり返しはシステム設定で選べるいちばん速い値（`KeyRepeat = 2`・`InitialKeyRepeat = 15`）
  - 文字の自動修正をすべてオフ（文頭の大文字・ピリオド・引用符・ダッシュ・スペル・インライン予測）
  - 壁紙をクリックしてもウィンドウをよけない（`EnableStandardClickToShowDesktop = false`）
- 見送ったもの: Finder の表示の追加（拡張子・パスバーなど）、Dock の「最近使ったアプリ」と出てくるまでの待ち時間、Dock に並べるアプリ（並びを変えるたびに設定を書き換えることになるため）
- 確認: `rebuild` で適用（世代5）。`defaults read` で値が入ったことを確認した。Dock は適用の中で自動で再起動された（nix-darwin が `killall Dock` する）
- 注意: キーリピートと押しっぱなしの動きは、開いていたアプリには反映されないことがある。ログインし直すと確実

### sudo を Touch ID で通せるようにした（Step 6）

- `darwin.nix` に `security.pam.services.sudo_local.touchIdAuth = true` と `reattach = true` を足した。書き込まれるのは `/etc/pam.d/sudo_local`（macOS がユーザーの追加の設定用に用意している場所で、アップデートでも消えない）
- `reattach` は tmux の中でも Touch ID を使うため（pam_reattach）。ないと tmux の中ではパスワードしか聞かれない
- 確認: `rebuild` で適用（世代4）したあと、ユーザーが `sudo -k && sudo true` を試し、Touch ID で通った
- つまずき: 世代3より前に開いたペインには `rebuild` のエイリアスがなかった。`exec zsh` で読み込み直せば使える

### nix-darwin を入れ、旧環境を卒業した（Step 6 の始め）

**決めたこと**（ユーザーと相談）
- 最初は「旧環境に一切さわらない」最小の形（nix-darwin にシェルの設定や Nix 本体を管理させない）を提案したが、ユーザーから「中途半端では」と指摘があった
- 旧環境と Nix 環境を並べて `envswitch` で行き来するのは珍しいやり方で、ふつうは Nix の世代（ロールバック）を命綱にそのまま乗り換える。旧環境はほとんど使っていないので、**旧環境を卒業する**ことにした
- 旧環境のファイル（`~/.config` の dotfiles、`~/.zshrc`）と Homebrew のコマンド（formula 26 個）は消さずに残す

**やったこと**
- `flake.nix` に nix-darwin を足し、`darwinConfigurations."MacBook-Pro-5"`（Mac のローカルホスト名と同じ名前）を作った。home-manager は nix-darwin のモジュールとして一緒に適用する（`useGlobalPkgs = true`）。単独の `homeConfigurations` は外した
- `darwin.nix`（Mac 全体の設定）を新しく作った
  - Nix 本体（nix-daemon・`/etc/nix/nix.conf`）も nix-darwin で管理し、flakes を有効にした
  - `/etc/zshenv`・`/etc/zshrc` は nix-darwin が作る。補完の初期化とプロンプトは home-manager 側で行うので、`enableGlobalCompInit = false`・`promptInit = ""`
  - nix-darwin は PATH を作り直す。Homebrew の場所は macOS の `/etc/paths.d` で足されていたので、`environment.systemPath` で明示した
  - Homebrew は cask 11 個をそのまま宣言した。`cleanup = "none"`・自動更新なし
- `envswitch` をやめた（`home.nix` の `~/.zshenv` の差し替えと `~/.local/bin/envswitch` を外し、`envswitch/` を消した）。`~/.zshenv` は home-manager の標準の中身（`~/.config-nix/zsh/.zshenv` を読むだけ）になり、新しいタブはいつも Nix 環境
- home.nix の `nix.package`・`nix.settings` は Mac 全体の設定と重なるので外した

**適用**（ユーザーがパスワードを打って実行）
- `/etc/zshrc`・`/etc/bashrc` は nix-darwin の「知っている中身」の一覧になく（macOS 26.5 の中身 + Nix インストーラの行）、そのままだと安全のため止まる。そこで `*.before-nix-darwin` に名前を変えて残した。`/etc/zprofile` は nix-darwin が自動で名前を変えた
- 初回はビルドしたものに入っている `darwin-rebuild` で適用した（世代1）
- 適用後に `~/.local/bin`（`claude` と `uv` がある）が PATH にないことに気づき、`home.sessionPath` に足して再適用した（世代2）
- `sudo darwin-rebuild` は「見つからない」になる。`sudo` は決まった場所しか探さず、`/run/current-system/sw/bin` が入っていないため。今はフルパスで打つ: `sudo /run/current-system/sw/bin/darwin-rebuild switch --flake ~/nix-config`
  - 同じ日に、これを zsh のエイリアス `rebuild` にした。適用が要るのは Nix の設定ファイル（home.nix・darwin.nix・flake.nix）を変えたときと、`nix flake update` のあとだけ

**確認したこと**
- 新しいシェル（ログインシェル）で: `ZDOTDIR`・`XDG_CONFIG_HOME` が `~/.config-nix`、PATH は `~/.local/bin` → `~/.nix-profile/bin` → `/run/current-system/sw/bin` → Nix → `/opt/homebrew/bin` → macOS 標準の順。git・nvim・starship・gh は Nix 版、`claude`・`uv`・`darwin-rebuild`・`brew` も見つかる。git のメールは noreply、補完も履歴（10 万件）もそのまま
- nix-daemon は nix-darwin の起動設定で動いている。yabai・skhd・sketchybar も動いたまま。Homebrew の cask は 11 個のまま（`brew bundle` はすべて Using）
- 戻し方: `sudo darwin-rebuild --rollback`（前の世代へ）。nix-darwin ごとやめるなら、`*.before-nix-darwin` を元の名前に戻し、nix-darwin のアンインストーラを使う

### typioca を入れた

- 英語のタイピング練習（`home.packages`、3.1.0）。ttyper と比べて、メニューでモード（時間制・単語数制など）を選べて記録も残る typioca をユーザーが選んだ
- 確認: Nix 版が入り、`typioca --help` が出た。`typioca serve`（SSH で遊べるサーバー）という機能もあるが、自分で打たない限り動かない

### lazydocker・posting・astroterm を入れた

- 「いい感じの CLI ツール」の2回目の候補から、ユーザーが選んだ。どれも Nix 環境だけで使える
- lazydocker（`programs.lazydocker`）: Docker の画面。色は lazygit と同じ（操作中の枠は blue、選んでいる行は sel0）。lazydocker は `XDG_CONFIG_HOME` を優先して読むので、設定は `~/.config-nix/lazydocker/config.yml`
  - そこに 10/10 にできた空の `config.yml`（0 バイト、以前 lazydocker を一度起動したときのもの）があり、home-manager とぶつかるので消した
- posting: API を試す画面。入れただけ
- astroterm: 今見える星空を描く。設定ファイルがなく、場所を指定しないと緯度 0・経度 0 の空になる。そこで zsh のエイリアスで `--city Tokyo --color --constellations --unicode` を付けた（埼玉 `Saitama` も選べる）
- 確認: 3つとも Nix 版（lazydocker 0.25.2、posting 2.11.0、astroterm 1.2.0）が入り、lazydocker の設定ファイルに色が書かれ、zsh にエイリアスが入った。画面はまだ開いていない（ユーザーが試す）

### cava を入れ、ミュージック.app の音に反応させた

- 音に合わせて棒グラフが動くビジュアライザー（`programs.cava`、1.0.0）。設定は `~/.config-nix/cava/config`（cava は `XDG_CONFIG_HOME` を見るので、そのまま読まれる）
- 棒の色は palette.nix から、下から上へ 水色 → 緑 → 黄 → オレンジ → 赤 のグラデーション
- 音の取り方: `method = coreaudio`・`source = tap`。macOS 14.2 からの公式の仕組み（Core Audio tap）で、Mac から出ている音をそのまま取る。cava 1.0 はこれに対応していて、nixpkgs の cava にも組み込まれている
- そこにたどり着くまで（ユーザーと相談しながら）
  - 最初は「macOS の cava はマイクの音にしか反応しない。Mac の音を取るには BlackHole（仮想の音の機器）が要る」と説明した。これは誤りで、cava の最新版を確かめていなかった
  - BlackHole は nixpkgs にもあるが、ドライバを Mac 全体の場所（`/Library/Audio/Plug-Ins/HAL`）に置く必要があり、home-manager ではできない。さらに複数出力装置を使うと音量キーが効かなくなる。なので見送った
  - 代わりに AudioTee（makeusabrew/audiotee、Core Audio tap で音を標準出力に流す Swift 製のコマンド）を Nix でビルドし、fifo で cava に渡す形を試した。音は取れたが、cava は fifo からの音が 0.1 秒来ないと「無音」として毎回リセットする作りで、AudioTee は 0.2 秒ごとに送るため、棒が動かなかった
  - その原因を調べるため cava のソースを読んでいて、`coreaudio_tap.m`（cava 自身の tap 対応）を見つけた → AudioTee・fifo・起動用のスクリプトは外し、cava の設定2行だけにした
- 確認: 仮の設定（数字で出力）で、ミュージック.app の再生中に棒の高さが音楽に合わせて動いた（197 行中 196 行が 0 以外）。許可（画面と音声の収録）は AudioTee を試したときに Ghostty に出したもので足りた
- 違い: AudioTee ならミュージック.app の音だけに絞れたが、cava の tap は Mac から出ている音すべてに反応する

### hollywood の代わりに genact を入れた

- ユーザーは hollywood（ターミナルを分割して「ハッカー映画っぽい」画面を並べる）を希望した。だが macOS ではうまく動かないので見送った
  - nixpkgs の hollywood は macOS では入らない。jp2a に「macOS では壊れている」印（`broken = isDarwin`）がある。ただし実際には作れて、画像も文字で描けた。さらに mlocate・atop・mplayer・ccze は macOS 用がない
  - 17 ある画面のうち、7つは ccze（色付け）を使う。ほかにも locate・atop・mplayer・`/sys` など Linux にしかないものを使う画面がある。動くのは cmatrix・bmon・htop・世界地図・`/dev` のツリーの5つくらい（足りない画面は自動で閉じる仕組み）
- 代わりに、macOS でもそのまま動く genact（忙しく作業しているふりをする）を `home.packages` に入れた
- 確認: Nix 版（1.6.0）が入り、`genact -m cargo` で偽のダウンロード表示が流れた。表示の種類は `genact --list-modules`

### k9s・yazi・gping・dust・glow・sl・tealdeer を入れた

- 「おもしろい CLI ツール」として候補を出し、ユーザーが選んだ。どれも旧環境にはなく、Nix 環境だけで使える
- k9s（`programs.k9s`）: kind の coffee-app を画面で見るため。配色は k9s に最初から入っている `gruvbox-dark-hard`（背景が palette.nix の bg1 と同じ）
- yazi（`programs.yazi`）: ファイル操作の画面。`y` で開くと、閉じたときにそのフォルダへ移動する（home-manager が zsh に関数 `y` を作る）
- tealdeer（`programs.tealdeer`、コマンドは `tldr`）: 説明の自動更新を有効にした
  - home-manager の `settings` は macOS だと `~/Library/Application Support/tealdeer` に書く。一方 tealdeer は、Nix 環境が設定する `XDG_CONFIG_HOME`（`~/.config-nix`）を優先して読む。そのため設定が読まれなかった → `xdg.configFile` で `~/.config-nix/tealdeer/config.toml` に自分で置いた
- gping・dust・glow・sl: 入れただけ（`home.packages`）
- 確認: 7つとも Nix 版が入った。k9s は `~/.config-nix/k9s` の設定と配色を読んでいる（`k9s info`）。tldr は初回に説明を取ってきて `tldr dust` が表示された。glow で log.md が読め、dust でフォルダの容量が表示された。yazi の `y` は zsh の関数になっている
- まだ画面で見ていないもの: k9s・yazi・gping・sl（どれも操作する画面なので、ユーザーが触って確認する）

### btop と fastfetch を入れた

- どちらも旧環境には入っていなかったので、新しく足した。Nix 環境（`envswitch nix` のタブ）だけで使える
- btop（`programs.btop`）: 配色は btop に最初から入っている `gruvbox_dark_v2`。背景は塗らずにターミナルの色を使う（`theme_background = false`）。`hjkl` で動く（`vim_keys`）
- fastfetch（`programs.fastfetch`）: まずは初期設定のまま。表示する項目は使いながら決める
- 確認: どちらも Nix 版（btop 1.4.7、fastfetch 2.69.0）が入り、btop の設定ファイル（`~/.config-nix/btop/btop.conf`）に上の3つが書かれている。fastfetch はロゴと情報が表示された
- 適用時に、fzf の設定名が変わったという警告が出た（`changeDirWidgetCommand` → `changeDirWidget.command`、`fileWidgetCommand` → `fileWidget.command`）。今回の変更とは関係ない。動作には影響しないので、そのままにしている

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
  - もう一度試した（同じ日、学内）: 結果は同じ。Nix の gh は 10 秒でタイムアウトし、Homebrew の gh は 0.3 秒でつながる。テザリングなど学内以外の回線で試すのは後回し。それまでは必要なら Homebrew の gh（`/opt/homebrew/bin/gh`）を使う

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
