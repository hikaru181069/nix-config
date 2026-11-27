# Kanagawa Wave。rebelot/kanagawa.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Kanagawa Wave"; # Ghostty に入っている
  nvim = "kanagawa-wave"; # rebelot/kanagawa.nvim（nvim/init.lua の extra_themes）
  bat = "kanagawa-wave"; # Neovim（rebelot/kanagawa.nvim）の実際の色の割り当てから作った（bat/kanagawa-wave.tmTheme）
  btop = "kanagawa-wave"; # btop に入っている
  k9s = "kanagawa"; # k9s に入っている
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#cc7d79"
    "#bd8c4e"
    "#8f9f56"
    "#50aa8a"
    "#3ea5bd"
    "#7796d4"
  ];

  palette = {
    # 色
    black = "#090618";
    red = "#c34043";
    green = "#76946a";
    yellow = "#c0a36e";
    blue = "#7e9cd8";
    magenta = "#957fb8";
    cyan = "#6a9589";
    white = "#c8c093";
    orange = "#ffa066";
    pink = "#938aa9";

    comment = "#727169";

    bg_bar = "#17171e"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#1f1f28"; # 通常の背景
    bg_alt = "#2a2a37"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#363646"; # sketchybar のアプリ名の帯など
    border = "#54546d"; # 枠線

    fg_bright = "#e6e3cf"; # 明るい文字
    fg = "#dcd7ba"; # 通常の文字
    fg_dim = "#ada996"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#54546d"; # さらに暗い文字

    selection = "#223249"; # 選んでいる行の背景
    search = "#2d4f67"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#2c3132";
    diff_delete = "#38242c";
    diff_change = "#2d3242";
    diff_text = "#3c445d";
    diff_add_emph = "#39423c";
    diff_delete_emph = "#502930";
  };
}
