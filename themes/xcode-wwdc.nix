# Xcode WWDC（Xcode の公式の配色の、WWDC の種類）。lunacookies/vim-colors-xcode の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Xcode WWDC"; # Ghostty に入っている
  nvim = "xcodewwdc"; # lunacookies/vim-colors-xcode（nvim/init.lua の extra_themes）
  bat = "xcode-wwdc"; # Neovim の実際の色の割り当てから作った（bat/xcode-wwdc.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#d57671"
    "#bf8b33"
    "#7fa450"
    "#07ad9a"
    "#38a1d3"
    "#908adc"
  ];

  palette = {
    # 色
    black = "#494d5c";
    red = "#bb383a";
    green = "#94c66e";
    yellow = "#d28e5d";
    blue = "#8884c5";
    magenta = "#b73999";
    cyan = "#00aba4";
    white = "#e7e8eb";
    orange = "#d28e5d";
    pink = "#c561ad";

    comment = "#7f869e";

    bg_bar = "#1f2128"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#292c36"; # 通常の背景
    bg_alt = "#2c2f3a"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#2f323d"; # sketchybar のアプリ名の帯など
    border = "#585b63"; # 枠線（背景に文字の色を 25% 混ぜた）

    fg_bright = "#eeeff1"; # 明るい文字
    fg = "#e7e8eb"; # 通常の文字
    fg_dim = "#b8b9be"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#595e6d"; # さらに暗い文字

    selection = "#494d5c"; # 選んでいる行の背景
    search = "#494d5c"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#39433e";
    diff_delete = "#3f2e37";
    diff_change = "#37394b";
    diff_text = "#464661";
    diff_add_emph = "#495a47";
    diff_delete_emph = "#553037";
  };
}
