# Gruvbox Material（medium）。sainnhe/gruvbox-material の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Gruvbox Material Dark"; # Ghostty に入っている
  nvim = "gruvbox-material"; # sainnhe/gruvbox-material（nvim/init.lua の extra_themes）
  bat = "gruvbox-material"; # Neovim（sainnhe/gruvbox-material）の実際の色の割り当てから作った（bat/gruvbox-material.tmTheme）
  btop = "gruvbox_material_dark"; # btop に入っている
  k9s = "gruvbox-material-dark-medium"; # k9s に入っている
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#e18a82"
    "#d99360"
    "#c2a150"
    "#9fae5d"
    "#74b87f"
    "#49bba7"
  ];

  palette = {
    # 色
    black = "#282828";
    red = "#ea6962";
    green = "#a9b665";
    yellow = "#d8a657";
    blue = "#7daea3";
    magenta = "#d3869b";
    cyan = "#89b482";
    white = "#d4be98";
    orange = "#e1885c"; # 赤と黄を半分ずつ混ぜた
    pink = "#dc9eaf";

    comment = "#928374";

    bg_bar = "#1e1e1e"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#282828"; # 通常の背景
    bg_alt = "#2d2c2c"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#32302f"; # sketchybar のアプリ名の帯など
    border = "#928374"; # 枠線

    fg_bright = "#ddc7a1"; # 明るい文字
    fg = "#d4be98"; # 通常の文字
    fg_dim = "#a9987c"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#7d7165"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#45403d"; # 選んでいる行の背景
    search = "#5d4e36"; # 検索結果などの背景（背景に黄を 30% 混ぜた）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#3b3d31";
    diff_delete = "#453231";
    diff_change = "#353c3a";
    diff_text = "#42504d";
    diff_add_emph = "#4f533a";
    diff_delete_emph = "#623c39";
  };
}
