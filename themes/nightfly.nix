# Nightfly。bluz71/vim-nightfly-colors の色（lua/nightfly/init.lua）。Moonfly と同じ作者
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty に入っていないので、下の色を直接使う（home.nix）
  nvim = "nightfly"; # bluz71/vim-nightfly-colors（nvim/init.lua）
  bat = "nightfly"; # Neovim（bluz71/vim-nightfly-colors）の実際の色の割り当てから作った（bat/nightfly.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ff9289"
    "#e9a747"
    "#a9c35a"
    "#44d1a6"
    "#18caed"
    "#8ab4ff"
  ];

  palette = {
    # 色
    black = "#1d3b53";
    red = "#fc514e";
    green = "#a1cd5e";
    yellow = "#e3d18a";
    blue = "#82aaff";
    magenta = "#c792ea"; # violet
    cyan = "#7fdbca"; # turquoise
    cyan_light = "#b2e9df"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#a1aab8";
    orange = "#f78c6c";
    pink = "#e39aa6"; # orchid

    comment = "#7c8f8f"; # grey_blue

    bg0 = "#01101d"; # バー・浮かぶウィンドウ・選んでいないタブ（Nightfly に無いので、背景を黒に 25% 寄せた）
    bg1 = "#011627"; # 通常の背景（black）
    bg2 = "#092236"; # dark_blue
    bg3 = "#1d3b53"; # sketchybar のアプリ名の帯など（regal_blue）
    bg4 = "#334e65"; # 枠線（carbon_blue）

    fg0 = "#d6deeb"; # 明るい文字（white_blue）
    fg1 = "#c3ccdc"; # 通常の文字（white）
    fg2 = "#a1aab8"; # 暗い文字（cadet_blue）
    fg3 = "#4b6479"; # さらに暗い文字（steel_blue）

    sel0 = "#1d3b53"; # 選んでいる行の背景（regal_blue）
    sel1 = "#24567f"; # 検索結果などの背景（bay_blue）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#19312f";
    diff_delete = "#271f2d";
    diff_change = "#142c47";
    diff_text = "#284268";
    diff_add_emph = "#314d38";
    diff_delete_emph = "#4c2833";
  };
}
