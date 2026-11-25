# Oxocarbon。nyoom-engineering/oxocarbon.nvim の色
# Ghostty の「Oxocarbon」は赤が水色になっているので使わない。黄とオレンジは、このテーマでは青緑
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty のテーマは使わず、下の色を直接使う（home.nix）
  nvim = "oxocarbon"; # nyoom-engineering/oxocarbon.nvim（nvim/init.lua）
  bat = "oxocarbon"; # Neovim（nyoom-engineering/oxocarbon.nvim）の実際の色の割り当てから作った（bat/oxocarbon.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#f17ca9"
    "#f28847"
    "#baaa0d"
    "#44c37e"
    "#05bdd1"
    "#75a7ff"
  ];

  palette = {
    # 色
    black = "#262626";
    red = "#ee5396";
    green = "#42be65";
    yellow = "#3ddbd9";
    blue = "#78a9ff";
    magenta = "#be95ff";
    cyan = "#33b1ff";
    cyan_light = "#85d0ff"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#d0d0d0";
    orange = "#08bdba";
    pink = "#ff7eb6";

    comment = "#6f6f6f";

    bg_bar = "#0c0c0c"; # バー・浮かぶウィンドウ・選んでいないタブ
    bg = "#161616"; # 通常の背景
    bg_alt = "#1e1e1e"; # 通常と少し違う背景（bg と bg_band の間の色）
    bg_band = "#262626"; # sketchybar のアプリ名の帯など
    border = "#393939"; # 枠線

    fg_bright = "#f2f4f8"; # 明るい文字
    fg = "#d0d0d0"; # 通常の文字
    fg_dim = "#a2a2a2"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#525252"; # さらに暗い文字

    selection = "#393939"; # 選んでいる行の背景
    search = "#2f3f5c"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#1d2f22";
    diff_delete = "#361f29";
    diff_change = "#252c39";
    diff_text = "#33425c";
    diff_add_emph = "#23482e";
    diff_delete_emph = "#57283c";
  };
}
