# OneDark の darker。Neovim の onedark.nvim（style = "darker"）の色（lua/onedark/palette.lua）
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。onedark.nvim での名前は、それぞれのコメントに書いた
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = null; # Ghostty には入っていないので、palette の色を直接使う（home.nix）
  nvim = "onedark"; # onedark.nvim の darker（nvim/init.lua）
  bat = "onedark-darker"; # Neovim（navarasu/onedark.nvim）の実際の色の割り当てから作った（bat/onedark-darker.tmTheme）。bat に最初から入っている同じ名前のテーマは、割り当てが Neovim と違うので使わない
  btop = "onedark";
  k9s = "one-dark";
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#e68285"
    "#d99249"
    "#a9aa45"
    "#5cba81"
    "#03bac2"
    "#5caaec"
  ];

  # sketchybar の今のアプリの名前とアイコンの色。既定（fg2）だと帯（bg3）の上で読みにくいので、選んでいるデスクトップのアプリのアイコンと同じ色にする
  frontApp = "#abb2bf"; # fg0

  palette = {
    # 色
    black = "#0e1013";
    red = "#e55561";
    green = "#8ebd6b";
    yellow = "#e2b86b";
    blue = "#4fa6ed";
    magenta = "#bf68d9"; # onedark.nvim の purple
    cyan = "#48b0bd";
    cyan_light = "#91d0d7"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#abb2bf"; # onedark.nvim の darker には無いので、同じ OneDark の dark の fg
    orange = "#cc9057";
    pink = "#bf68d9"; # OneDark に pink はないので purple と同じ

    comment = "#7a818e"; # onedark.nvim の light_grey

    bg0 = "#181b20"; # バー・浮かぶウィンドウ・選んでいないタブ（onedark.nvim の bg_d。通常の背景より少し暗い）
    bg1 = "#1f2329"; # 通常の背景（ターミナル・エディタ。onedark.nvim の bg0）
    bg2 = "#282c34"; # onedark.nvim の bg1
    bg3 = "#30363f"; # カーソル行（onedark.nvim の bg2）
    bg4 = "#535965"; # 枠線（onedark.nvim の grey）

    fg0 = "#abb2bf"; # 明るい文字（darker には無いので、同じ OneDark の dark の fg）
    fg1 = "#a0a8b7"; # 通常の文字（onedark.nvim の fg）
    fg2 = "#7a818e"; # 暗い文字（ステータスライン。onedark.nvim の light_grey）
    fg3 = "#535965"; # さらに暗い文字（行番号。onedark.nvim の grey）

    sel0 = "#30363f"; # 選んでいる行の背景（fzf・lazygit など。onedark.nvim の bg2）
    sel1 = "#323641"; # 検索結果などの背景（onedark.nvim の bg3）

    # 差分の背景（onedark.nvim の値）
    # 行の中で実際に変わった部分（_emph）は、onedark.nvim に無いので、green / red を背景 bg1 に 30% 混ぜた色
    diff_add = "#272e23";
    diff_delete = "#2d2223";
    diff_change = "#172a3a";
    diff_text = "#274964";
    diff_add_emph = "#40513d";
    diff_delete_emph = "#5a323a";
  };
}
