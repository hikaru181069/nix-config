# Kanso の ink（zen より少し明るい種類）。webhooked/kanso.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Kanso Ink"; # Ghostty に入っている
  nvim = "kanso-ink"; # webhooked/kanso.nvim（nvim/init.lua の extra_themes）
  bat = "kanso-ink"; # Neovim の実際の色の割り当てから作った（bat/kanso-ink.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#c5928d"
    "#bc9978"
    "#a5a476"
    "#87ac8a"
    "#72aea7"
    "#77a9c0"
  ];

  palette = {
    # 色
    black = "#14171d";
    red = "#c4746e";
    green = "#8a9a7b";
    yellow = "#c4b28a";
    blue = "#8ba4b0";
    magenta = "#a292a3";
    cyan = "#8ea4a2";
    white = "#c8c093";
    orange = "#dca561";
    pink = "#938aa9";

    comment = "#75797f";

    bg_bar = "#0f1116"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#14171d"; # 通常の背景
    bg_alt = "#1b1e25"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#22262d"; # sketchybar のアプリ名の帯など
    border = "#404448"; # 枠線（背景に文字の色を 25% 混ぜた）

    fg_bright = "#d6d9d8"; # 明るい文字
    fg = "#c5c9c7"; # 通常の文字
    fg_dim = "#999c9c"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#5c6066"; # さらに暗い文字

    selection = "#393b44"; # 選んでいる行の背景
    search = "#2d4f67"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#262b2b";
    diff_delete = "#2e2529";
    diff_change = "#262c33";
    diff_text = "#384149";
    diff_add_emph = "#373e39";
    diff_delete_emph = "#493335";
  };
}
