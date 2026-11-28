# Xcode Dark HC（Xcode の公式の配色の、高いコントラスト版）。lunacookies/vim-colors-xcode の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Xcode Dark hc"; # Ghostty に入っている
  nvim = "xcodedarkhc"; # lunacookies/vim-colors-xcode（nvim/init.lua の extra_themes）
  bat = "xcode-dark-hc"; # Neovim の実際の色の割り当てから作った（bat/xcode-dark-hc.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#fa9b8d"
    "#eaaa63"
    "#c3bd60"
    "#8acc88"
    "#50d1be"
    "#52caec"
  ];

  palette = {
    # 色
    black = "#43454b";
    red = "#ff8a7a";
    green = "#83c9bc";
    yellow = "#d9c668";
    blue = "#4ec4e6";
    magenta = "#ff85b8";
    cyan = "#cda1ff";
    white = "#ffffff";
    orange = "#eca871"; # 赤と黄を半分ずつ混ぜた
    pink = "#ff9dc6";

    comment = "#838991";

    bg_bar = "#17171b"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#1f1f24"; # 通常の背景
    bg_alt = "#222228"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#26262b"; # sketchybar のアプリ名の帯など
    border = "#57575b"; # 枠線（背景に文字の色を 25% 混ぜた）

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#ffffff"; # 通常の文字
    fg_dim = "#c7c7c8"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#52555c"; # さらに暗い文字

    selection = "#43454b"; # 選んでいる行の背景
    search = "#43454b"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#2e383b";
    diff_delete = "#412f31";
    diff_change = "#263841";
    diff_text = "#2d505e";
    diff_add_emph = "#3d5252";
    diff_delete_emph = "#623f3e";
  };
}
