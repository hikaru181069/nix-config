# Synthweave（VS Code の Synthwave '84 を移したもの）。samharju/synthweave.nvim の色（Neovim で読みこんだ実際の色）
# ターミナルの色はプラグインの色の表（lua/synthweave/palette.lua）から。青と水色はどちらも水色系（元の Synthwave '84 も同じ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty に入っていないので、下の色を直接使う（home.nix）
  nvim = "synthweave"; # samharju/synthweave.nvim（nvim/init.lua の extra_themes）
  bat = "synthweave"; # Neovim の実際の色の割り当てから作った（bat/synthweave.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ffaaa6"
    "#ffb06e"
    "#e1c328"
    "#97da6a"
    "#01e4b8"
    "#02dcf5"
  ];

  palette = {
    # 色
    black = "#353163";
    red = "#fe4450";
    green = "#72f1b8";
    yellow = "#ffe347";
    blue = "#2ee2fa";
    magenta = "#ff7edb";
    cyan = "#3bf4fb";
    white = "#a2c7e5";
    orange = "#f39237";
    pink = "#ff7edb";

    comment = "#848bbd";

    bg_bar = "#1c1a28"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#262335"; # 通常の背景
    bg_alt = "#2a2642"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#2e2a4f"; # sketchybar のアプリ名の帯など
    border = "#a2c7e5"; # 枠線

    fg_bright = "#bed8ed"; # 明るい文字（文字を白に 3 割寄せた）
    fg = "#a2c7e5"; # 通常の文字
    fg_dim = "#839eb9"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#7176a2"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#353163"; # 選んでいる行の背景
    search = "#675d3a"; # 検索結果などの背景（背景に黄を 30% 混ぜた）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#314249";
    diff_delete = "#462839";
    diff_change = "#274053";
    diff_text = "#285c70";
    diff_add_emph = "#3d615c";
    diff_delete_emph = "#672d3d";
  };
}
