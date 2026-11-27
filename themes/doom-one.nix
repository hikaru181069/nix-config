# Doom One（Doom Emacs の定番）。NTBBloodbath/doom-one.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Doom One"; # Ghostty に入っている
  nvim = "doom-one"; # NTBBloodbath/doom-one.nvim（nvim/init.lua）
  bat = "doom-one"; # Neovim の実際の色の割り当てから作った（bat/doom-one.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#f08a86"
    "#d8a045"
    "#91bb63"
    "#25c5b3"
    "#50b7f0"
    "#aa9df5"
  ];

  palette = {
    # 色
    black = "#000000";
    red = "#ff6c6b";
    green = "#98be65";
    yellow = "#ecbe7b";
    blue = "#a9a1e1";
    magenta = "#c678dd";
    cyan = "#51afef";
    white = "#bbc2cf";
    orange = "#da8548";
    pink = "#d193e4";

    comment = "#5b6268";

    bg_bar = "#1e2127"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#282c34"; # 通常の背景
    bg_alt = "#242830"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#21242b"; # sketchybar のアプリ名の帯など
    border = "#bbc2cf"; # 枠線

    fg_bright = "#cfd4dd"; # 明るい文字
    fg = "#bbc2cf"; # 通常の文字
    fg_dim = "#969ca8"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#51575e"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#2257a0"; # 選んでいる行の背景
    search = "#2257a0"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#39423b";
    diff_delete = "#48363c";
    diff_change = "#3b3e4e";
    diff_text = "#4f4f68";
    diff_add_emph = "#4a5843";
    diff_delete_emph = "#683f44";
  };
}
