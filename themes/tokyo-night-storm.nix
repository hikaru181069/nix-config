# Tokyo Night Storm。folke/tokyonight.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "TokyoNight Storm"; # Ghostty に入っている
  nvim = "tokyonight-storm"; # folke/tokyonight.nvim（nvim/init.lua の extra_themes）
  bat = "tokyo-night-storm"; # Neovim（folke/tokyonight.nvim）の実際の色の割り当てから作った（bat/tokyo-night-storm.tmTheme）
  btop = "tokyo-storm"; # btop に入っている
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#fb90a1"
    "#f0a058"
    "#b7bd53"
    "#59ce9c"
    "#23c9e6"
    "#8fb3ff"
  ];

  palette = {
    # 色
    black = "#1d202f";
    red = "#f7768e";
    green = "#9ece6a";
    yellow = "#e0af68";
    blue = "#7aa2f7";
    magenta = "#bb9af7";
    cyan = "#7dcfff";
    white = "#a9b1d6";
    orange = "#ff9e64";
    pink = "#c9aef9";

    comment = "#565f89";

    bg_bar = "#1b1e2c"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#24283b"; # 通常の背景
    bg_alt = "#262b3e"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#292e42"; # sketchybar のアプリ名の帯など
    border = "#29a4bd"; # 枠線

    fg_bright = "#d3daf8"; # 明るい文字
    fg = "#c0caf5"; # 通常の文字
    fg_dim = "#99a2c6"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#4c5479"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#2e3c64"; # 選んでいる行の背景
    search = "#3d59a1"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#364142";
    diff_delete = "#443447";
    diff_change = "#313a57";
    diff_text = "#3e4d73";
    diff_add_emph = "#495a49";
    diff_delete_emph = "#633f54";
  };
}
