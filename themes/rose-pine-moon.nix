# Rosé Pine Moon。rose-pine/neovim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Rose Pine Moon"; # Ghostty に入っている
  nvim = "rose-pine-moon"; # rose-pine/neovim（nvim/init.lua の extra_themes）
  bat = "rose-pine-moon"; # Neovim（rose-pine/neovim）の実際の色の割り当てから作った（bat/rose-pine-moon.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = "rose-pine-moon"; # k9s に入っている
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ea96aa"
    "#e99d7a"
    "#cfae61"
    "#a0bf76"
    "#69c8a6"
    "#55c4d6"
  ];

  palette = {
    # 色
    black = "#393552";
    red = "#eb6f92";
    green = "#3e8fb0";
    yellow = "#f6c177";
    blue = "#9ccfd8";
    magenta = "#c4a7e7";
    cyan = "#ea9a97";
    white = "#e0def4";
    orange = "#f6c177";
    pink = "#d0b9ec";

    comment = "#908caa";

    bg_bar = "#1a1928"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#232136"; # 通常の背景
    bg_alt = "#2e2b44"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#393552"; # sketchybar のアプリ名の帯など
    border = "#6e6a86"; # 枠線

    fg_bright = "#e9e8f7"; # 明るい文字
    fg = "#e0def4"; # 通常の文字
    fg_dim = "#b1afc4"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#6e6a86"; # さらに暗い文字

    selection = "#3b3551"; # 選んでいる行の背景
    search = "#4d4143"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#273248";
    diff_delete = "#412d44";
    diff_change = "#353b4e";
    diff_text = "#475567";
    diff_add_emph = "#2b425b";
    diff_delete_emph = "#5f3852";
  };
}
