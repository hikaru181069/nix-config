# Ayu（dark）。Shatur/neovim-ayu の色
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Ayu"; # Ghostty に入っている
  nvim = "ayu-dark"; # Shatur/neovim-ayu（nvim/init.lua）
  bat = "ayu-dark"; # Neovim（Shatur/neovim-ayu）の実際の色の割り当てから作った（bat/ayu-dark.tmTheme）
  btop = "ayu"; # btop に入っている
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ff9799"
    "#f8a350"
    "#c5be45"
    "#70d288"
    "#00d3d1"
    "#61c4ff"
  ];

  palette = {
    # 色
    black = "#11151c";
    red = "#ea6c73";
    green = "#aad94c";
    yellow = "#e6b450";
    blue = "#59c2ff";
    magenta = "#d2a6ff";
    cyan = "#95e6cb";
    white = "#c7c7c7";
    orange = "#ff8f40";
    pink = "#f07178";

    comment = "#636a72";

    bg_bar = "#080a0f"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#0b0e14"; # 通常の背景
    bg_alt = "#11151c"; # 通常と少し違う背景
    bg_band = "#1e222a"; # sketchybar のアプリ名の帯など
    border = "#454b55"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#bfbdb6"; # 通常の文字
    fg_dim = "#92918e"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#51585f"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#122132"; # 選んでいる行の背景
    search = "#454b55"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#232c1c";
    diff_delete = "#2c1c22";
    diff_change = "#172937";
    diff_text = "#22445a";
    diff_add_emph = "#3b4b25";
    diff_delete_emph = "#4e2a30";
  };
}
