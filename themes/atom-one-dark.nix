# Atom One Dark（OneDark の dark。Atom の元祖 One Dark）。navarasu/onedark.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Atom One Dark"; # Ghostty に入っている
  ghosttyOverride = {
    background = "#282c34"; # Neovim 版の背景にそろえる（Ghostty 版は #21252b）
  };
  nvim = "onedark-atom"; # navarasu/onedark.nvim（nvim/init.lua）
  bat = "atom-one-dark"; # Neovim の実際の色の割り当てから作った（bat/atom-one-dark.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#e88e92"
    "#dc9b5e"
    "#b1b05a"
    "#70c08b"
    "#3ec0c6"
    "#6db2ec"
  ];

  palette = {
    # 色
    black = "#21252b";
    red = "#e06c75";
    green = "#98c379";
    yellow = "#e5c07b";
    blue = "#61afef";
    magenta = "#c678dd";
    cyan = "#56b6c2";
    white = "#abb2bf";
    orange = "#d19a66";
    pink = "#d193e4";

    comment = "#5c6370";

    bg_bar = "#1e2127"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#282c34"; # 通常の背景
    bg_alt = "#2c303a"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#31353f"; # sketchybar のアプリ名の帯など
    border = "#5c6370"; # 枠線

    fg_bright = "#c4c9d2"; # 明るい文字
    fg = "#abb2bf"; # 通常の文字
    fg_dim = "#8a909c"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#525864"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#3b3f4c"; # 選んでいる行の背景
    search = "#615849"; # 検索結果などの背景（背景に黄を 30% 混ぜた）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#39433e";
    diff_delete = "#44363e";
    diff_change = "#314050";
    diff_text = "#39536c";
    diff_add_emph = "#4a5949";
    diff_delete_emph = "#5f3f48";
  };
}
