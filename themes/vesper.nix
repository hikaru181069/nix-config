# Vesper。datsfilipe/vesper.nvim の色
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Vesper"; # Ghostty に入っている
  ghosttyOverride = {
    selection-background = "#505050"; # 元は黄土色
    selection-foreground = "#ffffff"; # 元は灰色
  };
  nvim = "vesper"; # datsfilipe/vesper.nvim（nvim/init.lua）
  bat = "vesper"; # Neovim（datsfilipe/vesper.nvim）の実際の色の割り当てから作った（bat/vesper.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#eda4a2"
    "#dbb37a"
    "#a7c68c"
    "#74cdc3"
    "#87c2ed"
    "#bfb0ed"
  ];

  palette = {
    # 色
    black = "#232323";
    red = "#ff8080";
    green = "#90b99f";
    yellow = "#e6b99d";
    blue = "#aca1cf";
    magenta = "#e29eca";
    cyan = "#82d9c2";
    white = "#a0a0a0";
    orange = "#ffc799";
    pink = "#ea83a5";

    comment = "#7e7e7e";

    bg_bar = "#0c0c0c"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#101010"; # 通常の背景
    bg_alt = "#161616"; # 通常と少し違う背景
    bg_band = "#282828"; # sketchybar のアプリ名の帯など
    border = "#505050"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#cccccc"; # 通常の文字
    fg_dim = "#a0a0a0"; # 暗い文字
    fg_muted = "#656565"; # さらに暗い文字

    selection = "#343434"; # 選んでいる行の背景
    search = "#505050"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#232925";
    diff_delete = "#342121";
    diff_change = "#27262d";
    diff_text = "#3f3c49";
    diff_add_emph = "#36433b";
    diff_delete_emph = "#583232";
  };
}
