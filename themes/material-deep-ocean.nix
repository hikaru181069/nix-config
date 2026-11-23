# Material（Deep Ocean。いちばん暗い種類）。Neovim の marko-cerovac/material.nvim の色（lua/material/colors/init.lua の main と deep ocean）
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。material.nvim での名前は、それぞれのコメントに書いた
{
  # 各ツールで使う、最初から入っているテーマの名前
  # Ghostty の Material Ocean は文字の色（#8f93a2）が Neovim（#a6accd）と違うので、palette の色を直接使う（home.nix）
  ghostty = null;
  nvim = "material-deep-ocean"; # material.nvim の deep ocean（nvim/init.lua）
  bat = "material-deep-ocean"; # bat には入っていないので、Neovim（marko-cerovac/material.nvim）の実際の色の割り当てから作って足した（bat/material-deep-ocean.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#fea0a2"
    "#f4ad5c"
    "#b8c863"
    "#5ed8ab"
    "#3bd2f1"
    "#9ebdfe"
  ];

  palette = {
    # 色（main）
    black = "#546e7a"; # ターミナルの black（背景がとても暗いので、Ghostty の Material Ocean と同じく見える色にする）
    red = "#f07178";
    green = "#c3e88d";
    yellow = "#ffcb6b";
    blue = "#82aaff";
    magenta = "#c792ea"; # purple
    cyan = "#89ddff";
    cyan_light = "#b8ebff"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#eeffff";
    orange = "#f78c6c";
    pink = "#ff9cac"; # material.nvim で使われていない pink

    # バー（tmux・sketchybar）の灰色の役割（comment・fg2・fg3）は、色みの少ない青灰色だけで、明るさの段にする
    # material.nvim の fg_dark（#717cb4）は青紫で鮮やかすぎ、ほかの落ち着いた色から浮いてまとまらないので使わない
    comment = "#8f93a2"; # Ghostty の Material Ocean の文字の色（落ち着いた青灰色）

    bg0 = "#090b10"; # バー・浮かぶウィンドウ・選んでいないタブ（bg_alt。通常の背景より少し暗い）
    bg1 = "#0f111a"; # 通常の背景（ターミナル・エディタ。bg）
    bg2 = "#1a1c25"; # active
    bg3 = "#1f2233"; # カーソル行（highlight）
    bg4 = "#464b5d"; # 枠線（disabled）

    fg0 = "#eeffff"; # 明るい文字（white）
    fg1 = "#a6accd"; # 通常の文字（fg）
    fg2 = "#8f93a2"; # 暗い文字（ステータスライン。comment と同じ）
    fg3 = "#464b5d"; # さらに暗い文字（disabled。line_numbers の #3b3f51 は、バーのかたまりには暗すぎるので1段明るいもの）

    sel0 = "#1f2233"; # 選んでいる行の背景（fzf・lazygit など。selection）
    sel1 = "#232637"; # 検索結果などの背景（border）

    # 差分の背景。green / red / blue を背景 bg に混ぜた色
    # 行全体は 15%、行の中で実際に変わった部分（_emph）と diff_text は 30%
    diff_add = "#2a312b";
    diff_delete = "#311f28";
    diff_change = "#20283c";
    diff_text = "#323f5f";
    diff_add_emph = "#45523c";
    diff_delete_emph = "#522e36";
  };
}
