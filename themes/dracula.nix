# Dracula。Mofiqul/dracula.nvim の色
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Dracula"; # Ghostty に入っている
  nvim = "dracula"; # Mofiqul/dracula.nvim（nvim/init.lua）
  bat = "dracula"; # Neovim（Mofiqul/dracula.nvim）の実際の色の割り当てから作った（bat/dracula.tmTheme）
  btop = "dracula"; # btop に入っている
  k9s = "dracula"; # k9s に入っている
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ffafa8"
    "#fbba39"
    "#99dd73"
    "#02e3dc"
    "#95cdff"
    "#d3b7ff"
  ];

  palette = {
    # 色
    black = "#21222c";
    red = "#ff5555";
    green = "#50fa7b";
    yellow = "#f1fa8c";
    blue = "#bd93f9";
    magenta = "#ff79c6";
    cyan = "#8be9fd";
    cyan_light = "#b9f2fe"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#f8f8f2";
    orange = "#ffb86c";
    pink = "#ff79c6";

    comment = "#6272a4";

    bg_bar = "#21222c"; # バー・浮かぶウィンドウ・選んでいないタブ
    bg = "#282a36"; # 通常の背景
    bg_alt = "#343746"; # 通常と少し違う背景
    bg_band = "#44475a"; # sketchybar のアプリ名の帯など
    border = "#44475a"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#f8f8f2"; # 通常の文字
    fg_dim = "#c4c4c3"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#56648e"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#44475a"; # 選んでいる行の背景
    search = "#506078"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#2e4940";
    diff_delete = "#48303b";
    diff_change = "#3e3a53";
    diff_text = "#554a70";
    diff_add_emph = "#34684b";
    diff_delete_emph = "#68373f";
  };
}
