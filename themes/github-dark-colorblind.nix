# GitHub Dark Colorblind（赤と緑を見分けやすくした種類）。projekt0n/github-nvim-theme の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "GitHub Dark Colorblind"; # Ghostty に入っている
  nvim = "github_dark_colorblind"; # projekt0n/github-nvim-theme（nvim/init.lua）
  bat = "github-dark-colorblind"; # Neovim の実際の色の割り当てから作った（bat/github-dark-colorblind.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#e38c35"
    "#b9a416"
    "#74b85b"
    "#02bea1"
    "#02b6d4"
    "#5da6fb"
  ];

  palette = {
    # 色
    black = "#484f58";
    red = "#ec8e2c";
    green = "#58a6ff";
    yellow = "#d29922";
    blue = "#58a6ff";
    magenta = "#bc8cff";
    cyan = "#39c5cf";
    white = "#b1bac4";
    orange = "#d47616";
    pink = "#d2a8ff";

    comment = "#8b949e";

    bg_bar = "#0a0d11"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#0d1117"; # 通常の背景
    bg_alt = "#12161c"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#161b22"; # sketchybar のアプリ名の帯など
    border = "#30363d"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#c9d1d9"; # 通常の文字
    fg_dim = "#9aa1a8"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#6e7681"; # さらに暗い文字

    selection = "#2f547f"; # 選んでいる行の背景
    search = "#483a1a"; # 検索結果などの背景（背景に黄を 30% 混ぜた）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#18273a";
    diff_delete = "#2e241a";
    diff_change = "#18273a";
    diff_text = "#243e5d";
    diff_add_emph = "#243e5d";
    diff_delete_emph = "#50361d";
  };
}
