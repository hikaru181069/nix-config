# Oldworld。dgox16/oldworld.nvim の色（Neovim で読みこんだ実際の色と、プラグインのターミナルの色）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty に入っていないので、下の色を直接使う（home.nix）
  nvim = "oldworld"; # dgox16/oldworld.nvim（nvim/init.lua の extra_themes）
  bat = "oldworld"; # Neovim（dgox16/oldworld.nvim）の実際の色の割り当てから作った（bat/oldworld.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#dc9bae"
    "#d9a380"
    "#b5b578"
    "#80c1a1"
    "#71bdd2"
    "#9daee5"
  ];

  palette = {
    # 色
    black = "#27272a";
    red = "#ea83a5";
    green = "#90b99f";
    yellow = "#e6b99d";
    blue = "#92a2d5";
    magenta = "#aca1cf";
    cyan = "#85b5ba";
    white = "#c9c7cd";
    orange = "#f5a191";
    pink = "#bbb4ce";

    comment = "#8b8693";

    bg_bar = "#101011"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#161617"; # 通常の背景
    bg_alt = "#18181a"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#1b1b1c"; # sketchybar のアプリ名の帯など
    border = "#313134"; # 枠線

    fg_bright = "#d9d8dc"; # 明るい文字
    fg = "#c9c7cd"; # 通常の文字
    fg_dim = "#9c9ba0"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#74707a"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#3b3b3e"; # 選んでいる行の背景
    search = "#27272a"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#282e2b";
    diff_delete = "#36262c";
    diff_change = "#292b34";
    diff_text = "#3b4050";
    diff_add_emph = "#3b4740";
    diff_delete_emph = "#563742";
  };
}
