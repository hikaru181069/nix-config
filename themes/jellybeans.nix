# Jellybeans。WTFox/jellybeans.nvim（nanotech/jellybeans.vim を今の Neovim 向けに書き直したもの） の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Jellybeans"; # Ghostty に入っている
  ghosttyOverride = {
    background = "#151515"; # Neovim 版の背景にそろえる（Ghostty 版は #121212）
  };
  nvim = "jellybeans"; # WTFox/jellybeans.nvim（nvim/init.lua の extra_themes）
  bat = "jellybeans"; # Neovim の実際の色の割り当てから作った（bat/jellybeans.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#e68f8d"
    "#d89c5f"
    "#afb05e"
    "#73be8b"
    "#46bfc2"
    "#6ab3e7"
  ];

  palette = {
    # 色
    black = "#929292";
    red = "#e27373";
    green = "#94b979";
    yellow = "#ffba7b";
    blue = "#97bedc";
    magenta = "#e1c0fa";
    cyan = "#00988e";
    white = "#dedede";
    orange = "#e6a75a";
    pink = "#fbdaff";

    comment = "#888888";

    bg_bar = "#101010"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#151515"; # 通常の背景
    bg_alt = "#1b1b1b"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#212121"; # sketchybar のアプリ名の帯など
    border = "#403c41"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#e8e8d3"; # 通常の文字
    fg_dim = "#b3b3a4"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#605958"; # さらに暗い文字

    selection = "#404040"; # 選んでいる行の背景
    search = "#302028"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#282e24";
    diff_delete = "#342323";
    diff_change = "#282e33";
    diff_text = "#3c4851";
    diff_add_emph = "#3b4633";
    diff_delete_emph = "#523131";
  };
}
