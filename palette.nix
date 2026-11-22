# 色の定義。各ツール（tmux, sketchybar, starship, delta, lazygit, fzf など）はここから色を取る
# 色そのものは themes/ にテーマごとにあり、どれを使うかは theme.nix で決める
# 名前（bg0〜bg4・fg0〜fg3 など）は、Nightfox を使っていた頃の役割の名前をそのまま使っている
#   bg0: バー・浮かぶウィンドウ・選んでいないタブ  bg1: 通常の背景（ターミナル・エディタ）  bg3: カーソル行  bg4: 枠線
#   fg0: 明るい文字  fg1: 通常の文字  fg2: 暗い文字（ステータスライン）  fg3: さらに暗い文字（行番号）
#   sel0: 選んでいる行の背景  sel1: 検索結果などの背景  diff_*: 差分の背景
(import ./theme.nix).palette
