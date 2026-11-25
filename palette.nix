# 色の定義。各ツール（tmux, sketchybar, starship, delta, lazygit, fzf など）はここから色を取る
# 色そのものは themes/ にテーマごとにあり、どれを使うかは theme.nix で決める
# 名前は役割で付けている
#   背景  bg: 通常の背景（ターミナル・エディタ）  bg_bar: バー・タブの行・浮かぶウィンドウ  bg_alt: 通常と少し違う背景  bg_band: 帯（sketchybar の今のアプリなど）
#   文字  fg: 通常の文字  fg_bright: 明るい文字  fg_dim: 暗い文字  fg_muted: さらに暗い文字（行番号。バーのブロックの色にも使う）  comment: コメント
#   ほか  border: 枠線  selection: 選んでいる行の背景（fzf・lazygit など）  search: 検索結果などの背景  diff_*: 差分の背景
(import ./theme.nix).palette
