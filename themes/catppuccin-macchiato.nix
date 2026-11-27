# Catppuccin Macchiato。catppuccin/nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Catppuccin Macchiato"; # Ghostty に入っている
  nvim = "catppuccin-macchiato"; # catppuccin/nvim（nvim/init.lua の extra_themes）
  bat = "catppuccin-macchiato"; # Neovim（catppuccin/nvim）の実際の色の割り当てから作った（bat/catppuccin-macchiato.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#f8a4af"
    "#eeb07b"
    "#c0c679"
    "#80d3ac"
    "#69d0e5"
    "#9fbfff"
  ];

  palette = {
    # 色
    black = "#494d64";
    red = "#ed8796";
    green = "#a6da95";
    yellow = "#eed49f";
    blue = "#8aadf4";
    magenta = "#f5bde6";
    cyan = "#8bd5ca";
    white = "#a5adcb";
    orange = "#f5a97f";
    pink = "#f2a9dd";

    comment = "#939ab7";

    bg_bar = "#1b1d2c"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#24273a"; # 通常の背景
    bg_alt = "#2a2d40"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#303347"; # sketchybar のアプリ名の帯など
    border = "#8aadf4"; # 枠線

    fg_bright = "#dae0f8"; # 明るい文字
    fg = "#cad3f5"; # 通常の文字
    fg_dim = "#a0a8c6"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#7d839e"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#494d64"; # 選んでいる行の背景
    search = "#455c6d"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#384248";
    diff_delete = "#423548";
    diff_change = "#333b56";
    diff_text = "#434f72";
    diff_add_emph = "#4b5d55";
    diff_delete_emph = "#604456";
  };
}
