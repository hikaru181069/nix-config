# Outrun Night（自作）。VS Code のテーマ「Outrun Night Meets Synthwave」（edevars/outrun-meets-synthwave）の色を参考にした
# Neovim の配色は nvim/lua/outrun.lua（outrun-night）、bat は bat/outrun-night.tmTheme（どちらも自作）
# 元のテーマには本当の緑が無い（ターミナルの緑も青系 #62a9cf）ので、緑の役には git の追加行の色（#a7da1e）を当てた。
# 赤の役は、ターミナルの赤（ピンク #ff2e97）ではなく、差分の削除の赤（#e61f44）。ピンクは pink に入れた
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty に入っていないので、下の色を直接使う（home.nix）
  nvim = "outrun-night"; # 自作（nvim/lua/outrun.lua）
  bat = "outrun-night"; # 自作（bat/outrun-night.tmTheme。VS Code の色分けの決まりをそのまま当てはめた）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ff9698"
    "#ff9f3c"
    "#cabd22"
    "#6cd379"
    "#09d4ca"
    "#49c7ff"
  ];

  palette = {
    # 色（VS Code の色の名前）
    black = "#283034"; # terminal.ansiBlack
    red = "#e61f44"; # markup.deleted（差分の削除）
    green = "#a7da1e"; # markup.inserted.git_gutter（git の追加行）
    yellow = "#ffd400"; # constant.numeric・terminal.ansiYellow
    blue = "#42c6ff"; # storage・terminal.ansiBlue
    magenta = "#ff2afc"; # keyword・terminal.ansiMagenta
    cyan = "#a3d6e0"; # support.constant（青と見分けるため、明るい水色）
    white = "#d9e0e9"; # terminal.ansiWhite
    orange = "#ff9b50"; # entity.name.function
    pink = "#ff2e97"; # editorCursor・terminal.ansiRed

    comment = "#546a90"; # comment

    bg_bar = "#0c0a20"; # バー・浮かぶウィンドウ・選んでいないタブ（sideBar.background）
    bg = "#161130"; # 通常の背景（editor.background）
    bg_alt = "#1e1837"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#25203e"; # sketchybar のアプリ名の帯など（カーソル行。背景に文字の色を 7% 混ぜた）
    border = "#763b8c"; # 枠線（input.border）

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#ebecf8"; # 通常の文字（editor.foreground）
    fg_dim = "#b6b5c6"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#484f7d"; # さらに暗い文字（editorLineNumber.foreground）

    selection = "#484f7d"; # 選んでいる行の背景（editor.selectionBackground）
    search = "#5c4c22"; # 検索結果などの背景（背景に黄を 30% 混ぜた）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#2c2f2d";
    diff_delete = "#351333";
    diff_change = "#1d2c4f";
    diff_text = "#23476e";
    diff_add_emph = "#424d2b";
    diff_delete_emph = "#541536";
  };
}
