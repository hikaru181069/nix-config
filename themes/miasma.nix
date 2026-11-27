# Miasma。xero/miasma.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Miasma"; # Ghostty に入っている
  nvim = "miasma"; # xero/miasma.nvim（nvim/init.lua の extra_themes）
  bat = "miasma"; # Neovim（xero/miasma.nvim）の実際の色の割り当てから作った（bat/miasma.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#a07843"
    "#9b7b41"
    "#947e40"
    "#8d8242"
    "#858545"
    "#7d874a"
  ];

  palette = {
    # 色
    black = "#000000";
    red = "#685742";
    green = "#5f875f";
    yellow = "#b36d43";
    blue = "#78824b";
    magenta = "#bb7744";
    cyan = "#c9a554";
    white = "#d7c483";
    orange = "#bb7744";
    pink = "#c99269";

    comment = "#666666";

    bg_bar = "#1a1a1a"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#222222"; # 通常の背景
    bg_alt = "#1f1f1f"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#1c1c1c"; # sketchybar のアプリ名の帯など
    border = "#d7c483"; # 枠線

    fg_bright = "#e3d6a8"; # 明るい文字
    fg = "#d7c483"; # 通常の文字
    fg_dim = "#aa9c6b"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#585858"; # さらに暗い文字（コメントの色を背景に 20% 寄せた。comment より暗くして、今アクティブなものの三角がブロックより明るくなるように）

    selection = "#78824b"; # 選んでいる行の背景
    search = "#4e382c"; # 検索結果などの背景（背景に黄を 30% 混ぜた）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#2b312b";
    diff_delete = "#2c2a27";
    diff_change = "#2f3028";
    diff_text = "#3c3f2e";
    diff_add_emph = "#344034";
    diff_delete_emph = "#37322c";
  };
}
