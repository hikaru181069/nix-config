# Poimandres。olivercederborg/poimandres.nvim の色
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Poimandres"; # Ghostty に入っている
  ghosttyOverride = {
    background = "#1b1e28"; # Neovim 版の背景にそろえる
    selection-background = "#506477"; # 元は文字が読みにくい
  };
  nvim = "poimandres"; # olivercederborg/poimandres.nvim（nvim/init.lua）
  bat = "poimandres"; # Neovim（olivercederborg/poimandres.nvim）の実際の色の割り当てから作った（bat/poimandres.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ffb9d9"
    "#ffc0ae"
    "#efcc86"
    "#badf9c"
    "#86e6d2"
    "#8ddeff"
  ];

  palette = {
    # 色
    black = "#171922";
    red = "#d0679d";
    green = "#5de4c7";
    yellow = "#fffac2";
    blue = "#89ddff";
    magenta = "#fcc5e9";
    cyan = "#add7ff";
    cyan_light = "#cee7ff"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#e4f0fb";
    orange = "#fffac2";
    pink = "#fae4fc";

    comment = "#767c9d";

    bg_bar = "#171922"; # バー・浮かぶウィンドウ・選んでいないタブ
    bg = "#1b1e28"; # 通常の背景
    bg_alt = "#252b37"; # 通常と少し違う背景
    bg_band = "#303340"; # sketchybar のアプリ名の帯など
    border = "#506477"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#e4f0fb"; # 通常の文字
    fg_dim = "#a6accd"; # 暗い文字
    fg_muted = "#506477"; # さらに暗い文字

    selection = "#303340"; # 選んでいる行の背景
    search = "#506477"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#253c40";
    diff_delete = "#36293a";
    diff_change = "#2c3b48";
    diff_text = "#3c5768";
    diff_add_emph = "#2f5958";
    diff_delete_emph = "#51344b";
  };
}
