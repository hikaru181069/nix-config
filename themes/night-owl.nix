# Night Owl。oxfist/night-owl.nvim の色
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Night Owl"; # Ghostty に入っている
  ghosttyOverride = {
    background = "#021727"; # Neovim 版の背景にそろえる
  };
  nvim = "night-owl"; # oxfist/night-owl.nvim（nvim/init.lua）
  bat = "night-owl"; # Neovim（oxfist/night-owl.nvim）の実際の色の割り当てから作った（bat/night-owl.tmTheme）
  btop = "night-owl"; # btop に入っている
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ff8e86"
    "#e9a33d"
    "#a6c051"
    "#37cfa3"
    "#02c8eb"
    "#8db2ff"
  ];

  palette = {
    # 色
    black = "#011627";
    red = "#ef5350";
    green = "#22da6e";
    yellow = "#ecc48d";
    blue = "#82aaff";
    magenta = "#c792ea";
    cyan = "#7fdbca";
    cyan_light = "#b2e9df"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#d6deeb";
    orange = "#f78c6c";
    pink = "#ff5874";

    comment = "#637777";

    bg_bar = "#010d18"; # バー・浮かぶウィンドウ・選んでいないタブ
    bg = "#021727"; # 通常の背景
    bg_alt = "#0e293f"; # 通常と少し違う背景
    bg_band = "#1d3b53"; # sketchybar のアプリ名の帯など
    border = "#2d4f67"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#d6deeb"; # 通常の文字
    fg_dim = "#a1acba"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#4b6479"; # さらに暗い文字

    selection = "#1d3b53"; # 選んでいる行の背景
    search = "#063e5d"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#073432";
    diff_delete = "#26202d";
    diff_change = "#152d47";
    diff_text = "#284368";
    diff_add_emph = "#0c523c";
    diff_delete_emph = "#492933";
  };
}
