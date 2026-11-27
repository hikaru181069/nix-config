# Mellifluous。ramojus/mellifluous.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Mellifluous"; # Ghostty に入っている
  nvim = "mellifluous"; # ramojus/mellifluous.nvim（nvim/init.lua の extra_themes）
  bat = "mellifluous"; # Neovim（ramojus/mellifluous.nvim）の実際の色の割り当てから作った（bat/mellifluous.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#cd9f9e"
    "#c2a885"
    "#a1b48f"
    "#84b8b1"
    "#8db1cd"
    "#afa5cc"
  ];

  palette = {
    # 色
    black = "#1a1a1a";
    red = "#d29393";
    green = "#b3b393";
    yellow = "#cbaa89";
    blue = "#a8a1be";
    magenta = "#b39fb0";
    cyan = "#c0af8c";
    white = "#dadada";
    orange = "#ce9e8e"; # 赤と黄を半分ずつ混ぜた
    pink = "#9c6995";

    comment = "#737246";

    bg_bar = "#141414"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#1a1a1a"; # 通常の背景
    bg_alt = "#1f1f1f"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#242424"; # sketchybar のアプリ名の帯など
    border = "#4a4a4a"; # 枠線（背景に文字の色を 25% 混ぜた）

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#dadada"; # 通常の文字
    fg_dim = "#aaaaaa"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#5b5b5b"; # さらに暗い文字

    selection = "#2d2d2d"; # 選んでいる行の背景
    search = "#3b372f"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#31312c";
    diff_delete = "#362c2c";
    diff_change = "#2f2e33";
    diff_text = "#45424b";
    diff_add_emph = "#48483e";
    diff_delete_emph = "#513e3e";
  };
}
