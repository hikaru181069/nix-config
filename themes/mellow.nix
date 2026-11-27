# Mellow。mellow-theme/mellow.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Mellow"; # Ghostty に入っている
  nvim = "mellow"; # mellow-theme/mellow.nvim（nvim/init.lua の extra_themes）
  bat = "mellow"; # Neovim（mellow-theme/mellow.nvim）の実際の色の割り当てから作った（bat/mellow.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#e69f91"
    "#ceaf71"
    "#99c18a"
    "#6bc6c0"
    "#81bbe7"
    "#b8a9e6"
  ];

  palette = {
    # 色
    black = "#27272a";
    red = "#f5a191";
    green = "#90b99f";
    yellow = "#e6b99d";
    blue = "#aca1cf";
    magenta = "#e29eca";
    cyan = "#ea83a5";
    white = "#c1c0d4";
    orange = "#f5a191";
    pink = "#ecaad6";

    comment = "#757581";

    bg_bar = "#101011"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#161617"; # 通常の背景
    bg_alt = "#18181a"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#1b1b1d"; # sketchybar のアプリ名の帯など
    border = "#3e3e43"; # 枠線

    fg_bright = "#cac9dd"; # 明るい文字
    fg = "#c9c7cd"; # 通常の文字
    fg_dim = "#9c9ba0"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#57575f"; # さらに暗い文字

    selection = "#2a2a2d"; # 選んでいる行の背景
    search = "#27272a"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#282e2b";
    diff_delete = "#372b29";
    diff_change = "#2c2b33";
    diff_text = "#43404e";
    diff_add_emph = "#3b4740";
    diff_delete_emph = "#59403c";
  };
}
