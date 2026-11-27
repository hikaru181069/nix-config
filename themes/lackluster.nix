# Lackluster（ほぼ白黒）。slugbyte/lackluster.nvim の色
# 紫と水色は無いので、公式の青と灰色がかった青を当てた
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty のテーマは使わず、下の色を直接使う（home.nix）
  nvim = "lackluster"; # slugbyte/lackluster.nvim（nvim/init.lua）
  bat = "lackluster"; # Neovim（slugbyte/lackluster.nvim）の実際の色の割り当てから作った（bat/lackluster.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#c47c71"
    "#b38a4e"
    "#879c5b"
    "#50a58a"
    "#44a0b7"
    "#7592cb"
  ];

  palette = {
    # 色
    black = "#191919";
    red = "#d70000";
    green = "#789978";
    yellow = "#abab77";
    blue = "#7788aa";
    magenta = "#7788aa";
    cyan = "#708090";
    white = "#cccccc";
    orange = "#ffaa88";
    pink = "#ffaa88";

    comment = "#7a7a7a";

    bg_bar = "#0c0c0c"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#101010"; # 通常の背景
    bg_alt = "#191919"; # 通常と少し違う背景
    bg_band = "#242424"; # sketchybar のアプリ名の帯など
    border = "#444444"; # 枠線

    fg_bright = "#deeeed"; # 明るい文字
    fg = "#cccccc"; # 通常の文字
    fg_dim = "#aaaaaa"; # 暗い文字
    fg_muted = "#555555"; # さらに暗い文字

    selection = "#2a2a2a"; # 選んでいる行の背景
    search = "#444444"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#202520";
    diff_delete = "#2e0e0e";
    diff_change = "#1f2227";
    diff_text = "#2f343e";
    diff_add_emph = "#2f392f";
    diff_delete_emph = "#4c0b0b";
  };
}
