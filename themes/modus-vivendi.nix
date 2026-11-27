# Modus Vivendi。miikanissi/modus-themes.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Modus Vivendi"; # Ghostty に入っている
  nvim = "modus-vivendi"; # miikanissi/modus-themes.nvim（nvim/init.lua の extra_themes）
  bat = "modus-vivendi"; # Neovim（miikanissi/modus-themes.nvim）の実際の色の割り当てから作った（bat/modus-vivendi.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ff7c73"
    "#e99403"
    "#acb302"
    "#30c77b"
    "#02c1c7"
    "#41b3ff"
  ];

  palette = {
    # 色
    black = "#000000";
    red = "#ff5f59";
    green = "#44bc44";
    yellow = "#d0bc00";
    blue = "#2fafff";
    magenta = "#feacd0";
    cyan = "#00d3d0";
    white = "#a6a6a6";
    orange = "#e88e2c"; # 赤と黄を半分ずつ混ぜた
    pink = "#b6a0ff";

    comment = "#989898";

    bg_bar = "#1e1e1e"; # バー・浮かぶウィンドウ・選んでいないタブ（背景が真っ黒で、黒に寄せると背景と同じになるので、Modus の bg_dim。背景より明るい）
    bg = "#000000"; # 通常の背景
    bg_alt = "#181c24"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#2f3849"; # sketchybar のアプリ名の帯など
    border = "#c4c4c4"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#ffffff"; # 通常の文字
    fg_dim = "#bfbfbf"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#7a7a7a"; # さらに暗い文字（コメントの色を背景に 20% 寄せた。comment より暗くして、今アクティブなものの三角がブロックより明るくなるように）

    selection = "#7030af"; # 選んでいる行の背景
    search = "#2f822f"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#0a1c0a";
    diff_delete = "#260e0d";
    diff_change = "#071a26";
    diff_text = "#0e344c";
    diff_add_emph = "#143814";
    diff_delete_emph = "#4c1c1b";
  };
}
