# Sonokai。sainnhe/sonokai の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Sonokai"; # Ghostty に入っている
  nvim = "sonokai"; # sainnhe/sonokai（nvim/init.lua の extra_themes）
  bat = "sonokai"; # Neovim（sainnhe/sonokai）の実際の色の割り当てから作った（bat/sonokai.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#fe909f"
    "#f89c60"
    "#d3b342"
    "#93c86d"
    "#39d1af"
    "#16cbea"
  ];

  palette = {
    # 色
    black = "#181819";
    red = "#fc5d7c";
    green = "#9ed072";
    yellow = "#e7c664";
    blue = "#76cce0";
    magenta = "#b39df3";
    cyan = "#f39660";
    white = "#e2e2e3";
    orange = "#f39660";
    pink = "#c2b1f5";

    comment = "#7f8490";

    bg_bar = "#212227"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#2c2e34"; # 通常の背景
    bg_alt = "#30323a"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#33353f"; # sketchybar のアプリ名の帯など
    border = "#7f8490"; # 枠線

    fg_bright = "#ebebeb"; # 明るい文字
    fg = "#e2e2e3"; # 通常の文字
    fg_dim = "#b4b5b7"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#595f6f"; # さらに暗い文字

    selection = "#414550"; # 選んでいる行の背景
    search = "#645c42"; # 検索結果などの背景（背景に黄を 30% 混ぜた）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#3d463d";
    diff_delete = "#4b353f";
    diff_change = "#37464e";
    diff_text = "#425d68";
    diff_add_emph = "#4e5f47";
    diff_delete_emph = "#6a3c4a";
  };
}
