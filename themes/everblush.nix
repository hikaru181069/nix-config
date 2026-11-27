# Everblush。Everblush/nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Everblush"; # Ghostty に入っている
  nvim = "everblush"; # Everblush/nvim（nvim/init.lua の extra_themes）
  bat = "everblush"; # Neovim（Everblush/nvim）の実際の色の割り当てから作った（bat/everblush.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#f19391"
    "#e2a25e"
    "#b5b75d"
    "#72c690"
    "#3ec7cc"
    "#6db9f4"
  ];

  palette = {
    # 色
    black = "#232a2d";
    red = "#e57474";
    green = "#8ccf7e";
    yellow = "#e5c76b";
    blue = "#67b0e8";
    magenta = "#c47fd5";
    cyan = "#6cbfbf";
    white = "#b3b9b8";
    orange = "#e59e70"; # 赤と黄を半分ずつ混ぜた
    pink = "#ce89df";

    comment = "#404749";

    bg_bar = "#0f1416"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#141b1e"; # 通常の背景
    bg_alt = "#202728"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#2c3333"; # sketchybar のアプリ名の帯など
    border = "#8ccf7e"; # 枠線

    fg_bright = "#e5e5e5"; # 明るい文字
    fg = "#dadada"; # 通常の文字
    fg_dim = "#a8aaab"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#373e40"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#232a2d"; # 選んでいる行の背景
    search = "#534f35"; # 検索結果などの背景（背景に黄を 30% 混ぜた）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#26362c";
    diff_delete = "#33282b";
    diff_change = "#20313c";
    diff_text = "#2d485b";
    diff_add_emph = "#38513b";
    diff_delete_emph = "#533638";
  };
}
