# Duskfox（Nightfox の紫系）。EdenEast/nightfox.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Duskfox"; # Ghostty に入っている
  nvim = "duskfox"; # EdenEast/nightfox.nvim（nvim/init.lua の extra_themes）
  bat = "duskfox"; # Neovim（EdenEast/nightfox.nvim）の実際の色の割り当てから作った（bat/duskfox.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#eb9bae"
    "#e9a27e"
    "#cbb469"
    "#98c485"
    "#66cab8"
    "#69c3e4"
  ];

  palette = {
    # 色
    black = "#393552";
    red = "#eb6f92";
    green = "#a3be8c";
    yellow = "#f6c177";
    blue = "#569fba";
    magenta = "#c4a7e7";
    cyan = "#9ccfd8";
    white = "#e0def4";
    orange = "#f6c177";
    pink = "#ccb1ed";

    comment = "#817c9c";

    bg_bar = "#1a1928"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#232136"; # 通常の背景
    bg_alt = "#2d2a45"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#373354"; # sketchybar のアプリ名の帯など
    border = "#6e6a86"; # 枠線

    fg_bright = "#e2e0f7"; # 明るい文字
    fg = "#e0def4"; # 通常の文字
    fg_dim = "#b1afc4"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#6e6a86"; # さらに暗い文字

    selection = "#433c59"; # 選んでいる行の背景
    search = "#63577d"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#363943";
    diff_delete = "#412d44";
    diff_change = "#2b344a";
    diff_text = "#32475e";
    diff_add_emph = "#495050";
    diff_delete_emph = "#5f3852";
  };
}
