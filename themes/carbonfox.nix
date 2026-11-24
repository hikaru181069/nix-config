# Carbonfox。EdenEast/nightfox.nvim の carbonfox（Nightfox の、背景がほぼ黒の種類）の色。プラグインの中で計算される色は、実際の値を取り出した
# 黄色とオレンジは、Carbonfox では青緑
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Carbonfox"; # Ghostty に入っているので、そのまま使う
  nvim = "carbonfox"; # EdenEast/nightfox.nvim（nvim/init.lua）
  bat = "carbonfox"; # Neovim（EdenEast/nightfox.nvim）の実際の色の割り当てから作った（bat/carbonfox.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#f17ba8"
    "#f28746"
    "#baaa08"
    "#42c37d"
    "#00c0d9"
    "#6fa6ff"
  ];

  palette = {
    # 色
    black = "#282828";
    red = "#ee5396";
    green = "#25be6a";
    yellow = "#08bdba";
    blue = "#78a9ff";
    magenta = "#be95ff";
    cyan = "#33b1ff";
    cyan_light = "#85d0ff"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#dfdfe0";
    orange = "#3ddbd9";
    pink = "#ff7eb6";

    comment = "#6e6f70";

    bg0 = "#0c0c0c";
    bg1 = "#161616";
    bg2 = "#252525";
    bg3 = "#353535";
    bg4 = "#535353";

    fg0 = "#f9fbff";
    fg1 = "#f2f4f8";
    fg2 = "#b6b8bb";
    fg3 = "#7b7c7e";

    sel0 = "#2a2a2a";
    sel1 = "#525253";

    # 差分の背景（nightfox.nvim の DiffAdd / DiffDelete / DiffChange / DiffText と同じ値。_emph は green / red を背景に 30% 混ぜた色）
    diff_add = "#172b20";
    diff_delete = "#311d26";
    diff_change = "#222833";
    diff_text = "#1c3c51";
    diff_add_emph = "#1a482f";
    diff_delete_emph = "#57283c";
  };
}
