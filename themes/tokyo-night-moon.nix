# Tokyo Night Moon。folke/tokyonight.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "TokyoNight Moon"; # Ghostty に入っている
  nvim = "tokyonight-moon"; # folke/tokyonight.nvim（nvim/init.lua の extra_themes）
  bat = "tokyo-night-moon"; # Neovim（folke/tokyonight.nvim）の実際の色の割り当てから作った（bat/tokyo-night-moon.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ffa4a7"
    "#f8b05f"
    "#bccb65"
    "#61dbad"
    "#3ed5f4"
    "#a2c0ff"
  ];

  palette = {
    # 色
    black = "#1b1d2b";
    red = "#ff757f";
    green = "#c3e88d";
    yellow = "#ffc777";
    blue = "#82aaff";
    magenta = "#c099ff";
    cyan = "#86e1fc";
    white = "#828bb8";
    orange = "#ff966c";
    pink = "#cdadff";

    comment = "#636da6";

    bg_bar = "#1a1b28"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#222436"; # 通常の背景
    bg_alt = "#282c42"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#2f334d"; # sketchybar のアプリ名の帯など
    border = "#589ed7"; # 枠線

    fg_bright = "#d8e0f8"; # 明るい文字
    fg = "#c8d3f5"; # 通常の文字
    fg_dim = "#9ea7c5"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#565e90"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#2d3f76"; # 選んでいる行の背景
    search = "#3e68d7"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#3a4143";
    diff_delete = "#433041";
    diff_change = "#303854";
    diff_text = "#3f4c72";
    diff_add_emph = "#525f50";
    diff_delete_emph = "#643c4c";
  };
}
