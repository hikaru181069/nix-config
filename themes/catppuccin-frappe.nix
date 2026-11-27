# Catppuccin Frappé。catppuccin/nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Catppuccin Frappe"; # Ghostty に入っている
  nvim = "catppuccin-frappe"; # catppuccin/nvim（nvim/init.lua の extra_themes）
  bat = "catppuccin-frappe"; # Neovim（catppuccin/nvim）の実際の色の割り当てから作った（bat/catppuccin-frappe.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#f09d9d"
    "#e1ab6f"
    "#b1c075"
    "#73ccaa"
    "#63c7e0"
    "#99b6f8"
  ];

  palette = {
    # 色
    black = "#51576d";
    red = "#e78284";
    green = "#a6d189";
    yellow = "#e5c890";
    blue = "#8caaee";
    magenta = "#f4b8e4";
    cyan = "#81c8be";
    white = "#a5adce";
    orange = "#ef9f76";
    pink = "#f2a4db";

    comment = "#949cbb";

    bg_bar = "#242734"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#303446"; # 通常の背景
    bg_alt = "#363a4c"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#3b3f52"; # sketchybar のアプリ名の帯など
    border = "#8caaee"; # 枠線

    fg_bright = "#d7def8"; # 明るい文字
    fg = "#c6d0f5"; # 通常の文字
    fg_dim = "#a0a9c9"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#8087a4"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#51576d"; # 選んでいる行の背景
    search = "#506373"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#424c50";
    diff_delete = "#4b404f";
    diff_change = "#3e465f";
    diff_text = "#4c5778";
    diff_add_emph = "#53635a";
    diff_delete_emph = "#674b59";
  };
}
