# Monokai Pro。loctvl842/monokai-pro.nvim の色
# ターミナルの青はオレンジなので、ここでは水色を青にも当てた
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Monokai Pro"; # Ghostty に入っている
  nvim = "monokai-pro"; # loctvl842/monokai-pro.nvim（nvim/init.lua）
  bat = "monokai-pro"; # Neovim（loctvl842/monokai-pro.nvim）の実際の色の割り当てから作った（bat/monokai-pro.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ffa5b4"
    "#ffac81"
    "#e7bc50"
    "#abd270"
    "#5cdeaf"
    "#27daec"
  ];

  palette = {
    # 色
    black = "#19181a";
    red = "#ff6188";
    green = "#a9dc76";
    yellow = "#ffd866";
    blue = "#78dce8";
    magenta = "#ab9df2";
    cyan = "#78dce8";
    white = "#c1c0c0";
    orange = "#fc9867";
    pink = "#ff6188";

    comment = "#727072";

    bg_bar = "#221f22"; # バー・浮かぶウィンドウ・選んでいないタブ
    bg = "#2d2a2e"; # 通常の背景
    bg_alt = "#363438"; # 通常と少し違う背景（bg と bg_band の間の色）
    bg_band = "#403e41"; # sketchybar のアプリ名の帯など
    border = "#5b595c"; # 枠線

    fg_bright = "#fcfcfa"; # 明るい文字
    fg = "#fcfcfa"; # 通常の文字
    fg_dim = "#c1c0c0"; # 暗い文字
    fg_muted = "#5b595c"; # さらに暗い文字

    selection = "#403e41"; # 選んでいる行の背景
    search = "#5b595c"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#404539";
    diff_delete = "#4c323c";
    diff_change = "#38454a";
    diff_text = "#445f66";
    diff_add_emph = "#525f44";
    diff_delete_emph = "#6c3a49";
  };
}
