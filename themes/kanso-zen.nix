# Kanso の zen（いちばん暗い種類）。webhooked/kanso.nvim の色
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Kanso Zen"; # Ghostty に入っている
  nvim = "kanso-zen"; # webhooked/kanso.nvim（nvim/init.lua）
  bat = "kanso-zen"; # Neovim（webhooked/kanso.nvim）の実際の色の割り当てから作った（bat/kanso-zen.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#bc918c"
    "#b4977a"
    "#a19f79"
    "#88a68a"
    "#76a8a3"
    "#7aa4b7"
  ];

  palette = {
    # 色
    black = "#0d0c0c";
    red = "#c4746e";
    green = "#8a9a7b";
    yellow = "#c4b28a";
    blue = "#8ba4b0";
    magenta = "#a292a3";
    cyan = "#8ea4a2";
    cyan_light = "#bbc8c7"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#c8c093";
    orange = "#b6927b";
    pink = "#a292a3";

    comment = "#75797f";

    bg_bar = "#070a0e"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#090e13"; # 通常の背景
    bg_alt = "#161a20"; # 通常と少し違う背景（bg と bg_band の間の色）
    bg_band = "#22262d"; # sketchybar のアプリ名の帯など
    border = "#393b44"; # 枠線

    fg_bright = "#f2f1ef"; # 明るい文字
    fg = "#c5c9c7"; # 通常の文字
    fg_dim = "#a4a7a4"; # 暗い文字
    fg_muted = "#5c6066"; # さらに暗い文字

    selection = "#393b44"; # 選んでいる行の背景
    search = "#2d4f67"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#1c2323";
    diff_delete = "#251d21";
    diff_change = "#1c242b";
    diff_text = "#303b42";
    diff_add_emph = "#303832";
    diff_delete_emph = "#412d2e";
  };
}
