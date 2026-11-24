# Nightfox。EdenEast/nightfox.nvim の nightfox の色（lua/nightfox/palette/nightfox.lua）
# この環境で前に使っていたテーマで、bg0〜bg4・fg0〜fg3 などの名前は、もともと Nightfox のもの
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Nightfox"; # Ghostty に入っているので、そのまま使う
  nvim = "nightfox"; # EdenEast/nightfox.nvim（nvim/init.lua）
  bat = "nightfox"; # Neovim（EdenEast/nightfox.nvim）の実際の色の割り当てから作った（bat/nightfox.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = "nightfox";
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#e28b9b"
    "#db9662"
    "#afad59"
    "#6abc8d"
    "#41bbc9"
    "#7baaeb"
  ];

  palette = {
    # 色
    black = "#393b44";
    red = "#c94f6d";
    green = "#81b29a";
    yellow = "#dbc074";
    blue = "#719cd6";
    magenta = "#9d79d6";
    cyan = "#63cdcf";
    cyan_light = "#a1e1e2"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#dfdfe0";
    orange = "#f4a261";
    pink = "#d67ad2";

    comment = "#738091";

    bg0 = "#131a24";
    bg1 = "#192330";
    bg2 = "#212e3f";
    bg3 = "#29394f";
    bg4 = "#39506d";

    fg0 = "#d6d6d7";
    fg1 = "#cdcecf";
    fg2 = "#aeafb0";
    fg3 = "#71839b";

    sel0 = "#2b3b51";
    sel1 = "#3c5372";

    # 差分の背景（nightfox.nvim の DiffAdd / DiffDelete / DiffChange / DiffText と同じ値。_emph は green / red を背景に 30% 混ぜた色）
    diff_add = "#26343c";
    diff_delete = "#2f2837";
    diff_change = "#243244";
    diff_text = "#253f4a";
    diff_add_emph = "#384e50";
    diff_delete_emph = "#4e3042";
  };
}
