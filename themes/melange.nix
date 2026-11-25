# Melange（dark）。Neovim の savq/melange-nvim の色（lua/melange/palettes/dark.lua）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。Melange での名前は、それぞれのコメントに書いた
# Melange の色は a（背景・文字）、b（明るい色）、c（暗い色）、d（とても暗い色）に分かれている。ここでは主に b を使った
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "Melange Dark"; # Ghostty に入っているので、そのまま使う
  nvim = "melange"; # savq/melange-nvim（nvim/init.lua）
  bat = "melange"; # bat には入っていないので、Neovim（savq/melange-nvim）の実際の色の割り当てから作って足した（bat/melange.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#dd988a"
    "#c8a66b"
    "#9ab77d"
    "#69bead"
    "#6eb7d7"
    "#9ea7e2"
  ];

  palette = {
    # 色
    black = "#34302c"; # a.float（ターミナルの0番と同じ）
    red = "#d47766"; # b.red
    green = "#85b695"; # b.green
    yellow = "#ebc06d"; # b.yellow
    blue = "#a3a9ce"; # b.blue
    magenta = "#cf9bc2"; # b.magenta
    cyan = "#89b3b6"; # b.cyan
    cyan_light = "#b8d1d3"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#c1a78e"; # a.com（ターミナルの7番と同じ）
    orange = "#e49b5d"; # Melange に orange はないので c.yellow（だいだい色）
    pink = "#cf9bc2"; # Melange に pink はないので b.magenta

    comment = "#c1a78e"; # a.com

    bg_bar = "#231f1d"; # バー・浮かぶウィンドウ・選んでいないタブ（Melange に無いので、a.bg を黒に 15% 寄せた。通常の背景より少し暗い）
    bg = "#292522"; # 通常の背景（ターミナル・エディタ。a.bg）
    bg_alt = "#34302c"; # a.float
    bg_band = "#403a36"; # 帯（sketchybar の今のアプリなど）（a.sel）
    border = "#867462"; # 枠線（a.ui）

    fg_bright = "#ece1d7"; # 明るい文字（a.fg）
    fg = "#ece1d7"; # 通常の文字（a.fg）
    fg_dim = "#c1a78e"; # 暗い文字（ステータスライン。a.com）
    fg_muted = "#867462"; # さらに暗い文字（行番号。a.ui）

    selection = "#403a36"; # 選んでいる行の背景（fzf・lazygit など。a.sel）
    search = "#8b7449"; # 検索結果などの背景（d.yellow）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景 a.bg に混ぜた色
    # 行全体は 15%、行の中で実際に変わった部分（_emph）と diff_text は 30%
    diff_add = "#373b33";
    diff_delete = "#43312c";
    diff_change = "#3b393c";
    diff_text = "#4e4d56";
    diff_add_emph = "#455044";
    diff_delete_emph = "#5c3e36";
  };
}
