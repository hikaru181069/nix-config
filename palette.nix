# 色の定義。各ツール（tmux, sketchybar, starship, delta, lazygit, fzf など）はここから色を取る
# 色そのものは themes/ にテーマごとにあり、どれを使うかは theme.nix で決める
# 名前は役割で付けている
#   背景  bg: 通常の背景（ターミナル・エディタ）  bg_bar: バー・タブの行・浮かぶウィンドウ  bg_alt: 通常と少し違う背景  bg_band: 帯（sketchybar の今のアプリなど）
#   文字  fg: 通常の文字  fg_bright: 明るい文字  fg_dim: 暗い文字  fg_muted: さらに暗い文字（行番号）  comment: コメント
#   ほか  border: 枠線  selection: 選んでいる行の背景（fzf・lazygit など）  search: 検索結果などの背景  diff_*: 差分の背景
#   バー  block_fg・block_fg_dim・block_fg_muted: 3つのバー（tmux・sketchybar・Neovim のステータスライン）の灰色のブロックの色
#         block_fg_bright・block_comment: 今アクティブなものの、ブロックより明るい三角と文字の色（block_comment は細い区切りの線にも使う）
#         どれも fg〜・comment を、バーの地（bg_bar）に barDarken だけ寄せて暗くしたもの（全テーマ共通）
let
  palette = (import ./theme.nix).palette;
  # バーの灰色のブロックを暗くする割合（0 で元の色のまま。大きいほど暗い）
  barDarken = 0.45;

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
}
