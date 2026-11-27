# Nordic。AlexvZyl/nordic.nvim の色（Neovim で読みこんだ実際の色と、プラグインの色の表）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty に入っていないので、下の色を直接使う（home.nix）
  nvim = "nordic"; # AlexvZyl/nordic.nvim（nvim/init.lua の extra_themes）
  bat = "nordic"; # Neovim（AlexvZyl/nordic.nvim）の実際の色の割り当てから作った（bat/nordic.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#d69397"
    "#cd9d72"
    "#acac6f"
    "#7eb792"
    "#64b7be"
    "#7facd9"
  ];

  palette = {
    # 色
    black = "#1e222a";
    red = "#bf616a";
    green = "#a3be8c";
    yellow = "#ebcb8b";
    blue = "#81a1c1";
    magenta = "#b48ead";
    cyan = "#8fbcbb";
    white = "#d8dee9";
    orange = "#d08770";
    pink = "#c3a5bd";

    comment = "#4c566a";

    bg_bar = "#1b1f26"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#242933"; # 通常の背景
    bg_alt = "#20242c"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#1b1f26"; # sketchybar のアプリ名の帯など
    border = "#4b515c"; # 枠線（背景に文字の色を 25% 混ぜた）

    fg_bright = "#eceff4"; # 明るい文字
    fg = "#c0c8d8"; # 通常の文字
    fg_dim = "#99a0af"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#444d5f"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#1b1f26"; # 選んでいる行の背景
    search = "#1b1f26"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#373f40";
    diff_delete = "#3b313b";
    diff_change = "#323b48";
    diff_text = "#404d5e";
    diff_add_emph = "#4a564e";
    diff_delete_emph = "#523a44";
  };
}
