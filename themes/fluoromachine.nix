# Fluoromachine（Synthwave × Fluoromachine。光る効果 glow は切った）。maxmx03/fluoromachine.nvim の色（Neovim で読みこんだ実際の色）
# ターミナルの色はプラグインの色の表（lua/fluoromachine/colors/fluoromachine.lua）から。青に当たる色が無いので、紫（purple）を青に当てた
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty に入っていないので、下の色を直接使う（home.nix）
  nvim = "fluoromachine"; # maxmx03/fluoromachine.nvim（nvim/init.lua の extra_themes）
  bat = "fluoromachine"; # Neovim の実際の色の割り当てから作った（bat/fluoromachine.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ff9491"
    "#eea803"
    "#85ce55"
    "#07d1cb"
    "#74beff"
    "#c9a0ff"
  ];

  palette = {
    # 色
    black = "#241b2f";
    red = "#fe4450";
    green = "#72f1b8";
    yellow = "#ffcc00";
    blue = "#af6df9";
    magenta = "#fc199a";
    cyan = "#61e2ff";
    white = "#8ba7a7";
    orange = "#ff8b39";
    pink = "#fc199a";

    comment = "#495495";

    bg_bar = "#1c1a28"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#262335"; # 通常の背景
    bg_alt = "#362c4d"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#463465"; # sketchybar のアプリ名の帯など
    border = "#3f4452"; # 枠線（背景に文字の色を 25% 混ぜた）

    fg_bright = "#aec1c1"; # 明るい文字（文字を白に 3 割寄せた）
    fg = "#8ba7a7"; # 通常の文字
    fg_dim = "#72868a"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#424a82"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#463465"; # 選んでいる行の背景
    search = "#463465"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#314249";
    diff_delete = "#462839";
    diff_change = "#3b2e52";
    diff_text = "#4f3970";
    diff_add_emph = "#3d615c";
    diff_delete_emph = "#672d3d";
  };
}
