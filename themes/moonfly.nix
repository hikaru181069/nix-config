# Moonfly。bluz71/vim-moonfly-colors の色（lua/moonfly/init.lua）。背景がほぼ黒（#080808）
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Moonfly"; # Ghostty に入っているので、そのまま使う
  nvim = "moonfly"; # bluz71/vim-moonfly-colors（nvim/init.lua）
  bat = "moonfly"; # Neovim（bluz71/vim-moonfly-colors）の実際の色の割り当てから作った（bat/moonfly.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#fa8f89"
    "#e4a348"
    "#a4bf5a"
    "#41cca6"
    "#29c5eb"
    "#8faeff"
  ];

  palette = {
    # 色
    black = "#323437";
    red = "#ff5d5d";
    green = "#8cc85f";
    yellow = "#e3c78a";
    blue = "#80a0ff";
    magenta = "#cf87e8"; # violet
    cyan = "#79dac8"; # turquoise
    cyan_light = "#afe9de"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#c6c6c6";
    orange = "#de935f";
    pink = "#e196a2"; # orchid

    comment = "#949494"; # grey58（Comment）

    bg0 = "#121212"; # バー・浮かぶウィンドウ・選んでいないタブ（grey7。背景がほぼ黒で、これより暗い色を作れないので、少し明るい色）
    bg1 = "#080808"; # 通常の背景（black）
    bg2 = "#1c1c1c"; # grey11
    bg3 = "#2e2e2e"; # sketchybar のアプリ名の帯など（grey18）
    bg4 = "#3a3a3a"; # 枠線（grey23）

    fg0 = "#e4e4e4"; # 明るい文字（grey89）
    fg1 = "#c6c6c6"; # 通常の文字（white）
    fg2 = "#9e9e9e"; # 暗い文字（grey62）
    fg3 = "#626262"; # さらに暗い文字（grey39）

    sel0 = "#323437"; # 選んでいる行の背景（grey0（Visual））
    sel1 = "#4d5d8d"; # 検索結果などの背景（bay）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#1c2515";
    diff_delete = "#2d1515";
    diff_change = "#1a1f2d";
    diff_text = "#2c3652";
    diff_add_emph = "#304222";
    diff_delete_emph = "#522121";
  };
}
