# Vague。vague-theme/vague.nvim の色
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Vague"; # Ghostty に入っている
  nvim = "vague"; # vague-theme/vague.nvim（nvim/init.lua）
  bat = "vague"; # Neovim（vague-theme/vague.nvim）の実際の色の割り当てから作った（bat/vague.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#dd919e"
    "#d79a70"
    "#b5ac65"
    "#80ba89"
    "#59bcbc"
    "#74b1e0"
  ];

  palette = {
    # 色
    black = "#252530";
    red = "#d8647e";
    green = "#7fa563";
    yellow = "#f3be7c";
    blue = "#6e94b2";
    magenta = "#bb9dbd";
    cyan = "#b4d4cf";
    cyan_light = "#d2e5e2"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#cdcdcd";
    orange = "#e0a363";
    pink = "#c48282";

    comment = "#606079";

    bg_bar = "#0f0f10"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#141415"; # 通常の背景
    bg_alt = "#1c1c24"; # 通常と少し違う背景
    bg_band = "#252530"; # sketchybar のアプリ名の帯など
    border = "#405065"; # 枠線

    fg_bright = "#d7d7d7"; # 明るい文字
    fg = "#cdcdcd"; # 通常の文字
    fg_dim = "#9f9f9f"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#515165"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#333738"; # 選んでいる行の背景
    search = "#405065"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#242a21";
    diff_delete = "#312025";
    diff_change = "#22272d";
    diff_text = "#2f3a44";
    diff_add_emph = "#34402c";
    diff_delete_emph = "#4f2c34";
  };
}
