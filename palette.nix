# 色の定義。各ツール（tmux, sketchybar, starship, delta, lazygit, fzf など）はここから色を取る
# 色そのものは themes/ にテーマごとにあり、どれを使うかは theme.nix で決める
# 名前は役割で付けている
#   背景  bg: 通常の背景（ターミナル・エディタ）  bg_bar: バー・タブの行・浮かぶウィンドウ  bg_alt: 通常と少し違う背景  bg_band: 帯（sketchybar の今のアプリなど）
#   文字  fg: 通常の文字  fg_bright: 明るい文字  fg_dim: 暗い文字  fg_muted: さらに暗い文字（行番号）  comment: コメント
#   ほか  border: 枠線  selection: 選んでいる行の背景（fzf・lazygit など）  search: 検索結果などの背景  diff_*: 差分の背景
#   バー  block_fg・block_fg_dim・block_fg_muted: 3つのバー（tmux・sketchybar・Neovim のステータスライン）の灰色のブロックの色
#         block_fg_bright・block_comment: 今アクティブなものの、ブロックより明るい三角と文字の色（block_comment は細い区切りの線にも使う）
#         どれも fg〜・comment を、バーの地（bg_bar）に barDarken だけ寄せて暗くしたもの（全テーマ共通）
#         text_fg_dim・text_comment・text_fg_muted: バーの地の上の文字とアイコン（テーマが darkenBarText = true のときだけ暗くする。
#         darkenBarInactive = true なら、選んでいないもの text_comment と休んでいるもの text_fg_muted だけ暗くする）
let
  theme = import ./theme.nix;
  palette = theme.palette;
  # バーの灰色のブロックを暗くする割合（0 で元の色のまま。大きいほど暗い）
  # テーマのファイルに barDarken があれば、そのテーマだけその値にする（文字のコントラストに余裕があるテーマなど）
  barDarken = theme.barDarken or 0.45;
  # テーマのファイルに darkenBarText = true があれば、バーの地の上の文字とアイコン（text_〜）も同じだけ暗くする
  darkenBarText = theme.darkenBarText or false;
  # darkenBarInactive = true なら、選んでいないもの（text_comment）と休んでいるもの（text_fg_muted）だけ暗くする
  darkenBarInactive = theme.darkenBarInactive or false;

  digits = "0123456789abcdef";
  digit = c: builtins.head (builtins.filter (i: builtins.substring i 1 digits == c) (builtins.genList (i: i) 16));
  byte = hex: i: digit (builtins.substring i 1 hex) * 16 + digit (builtins.substring (i + 1) 1 hex);
  toHex = n: builtins.substring (builtins.div n 16) 1 digits + builtins.substring (n - builtins.div n 16 * 16) 1 digits;
  # a を b に t だけ寄せた色（"#rrggbb"。小文字で書く）
  mix =
    a: b: t:
    let
      ch = i: toHex (builtins.floor (byte a i + (byte b i - byte a i) * t + 0.5));
    in
    "#" + ch 1 + ch 3 + ch 5;
  toBar = c: mix (lowerHex c) (lowerHex palette.bg_bar) barDarken;
  lowerHex = s: builtins.replaceStrings [ "A" "B" "C" "D" "E" "F" ] [ "a" "b" "c" "d" "e" "f" ] s;
in
palette
// {
  block_fg = toBar palette.fg;
  block_fg_dim = toBar palette.fg_dim;
  block_fg_muted = toBar palette.fg_muted;
  # 今アクティブなもの（今のタブ・今のデスクトップ）の、ブロックより明るい三角（間は fg_bright、終わりは comment）も同じだけ暗くする
  block_fg_bright = toBar palette.fg_bright;
  block_comment = toBar palette.comment;
  # バーの地の上の文字とアイコン（情報の文字 fg_dim・選んでいないもの comment・休んでいるもの fg_muted）。ふだんは元の色のまま
  text_fg_dim = if darkenBarText then toBar palette.fg_dim else palette.fg_dim;
  text_comment = if darkenBarText || darkenBarInactive then toBar palette.comment else palette.comment;
  text_fg_muted = if darkenBarText || darkenBarInactive then toBar palette.fg_muted else palette.fg_muted;
  # Neovim のタブの行の、ほかのタブの文字と、色付きのアイコンを暗くする割合（darkenBarInactive のテーマだけ。色ではなく数）
  # 文字は、ほかのバーの「選んでいないもの」（text_comment）と同じ色にそろえる。ふだんは元の fg_muted のまま
  tab_inactive_fg = if darkenBarInactive then toBar palette.comment else palette.fg_muted;
  tab_inactive_darken = if darkenBarInactive then barDarken else 0;
}
