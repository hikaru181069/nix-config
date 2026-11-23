# Material（Darker）。Neovim の marko-cerovac/material.nvim の色（lua/material/colors/init.lua の main と darker）
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。material.nvim での名前は、それぞれのコメントに書いた
{
  # 各ツールで使う、最初から入っているテーマの名前
  # Ghostty の Material Darker は文字の色（#eeffff）が Neovim（#b0bec5）と違うので、palette の色を直接使う（home.nix）
  ghostty = null;
  nvim = "material-darker"; # material.nvim の darker（nvim/init.lua）
  bat = "material-darker"; # bat には入っていないので、Neovim（marko-cerovac/material.nvim）の実際の色の割り当てから作って足した（bat/material-darker.tmTheme）
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
    black = "#000000";
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

    comment = "#8c8b8b"; # fg_dark（darker のコメントの色 #515151 は、バーの文字には暗すぎるので）

    bg0 = "#1a1a1a"; # バー・浮かぶウィンドウ・選んでいないタブ（bg_alt。通常の背景より少し暗い）
    bg1 = "#212121"; # 通常の背景（ターミナル・エディタ。bg）
    bg2 = "#323232"; # active
    bg3 = "#3f3f3f"; # カーソル行（highlight）
    bg4 = "#474747"; # 枠線（disabled）

    fg0 = "#eeffff"; # 明るい文字（white）
    fg1 = "#b0bec5"; # 通常の文字（fg）
    fg2 = "#8c8b8b"; # 暗い文字（ステータスライン。fg_dark）
    fg3 = "#424242"; # さらに暗い文字（行番号。line_numbers）

    sel0 = "#404040"; # 選んでいる行の背景（fzf・lazygit など。selection）
    sel1 = "#3f3f3f"; # 検索結果などの背景（highlight）

    # 差分の背景。green / red / blue を背景 bg に混ぜた色
    # 行全体は 15%、行の中で実際に変わった部分（_emph）と diff_text は 30%
    diff_add = "#393f31";
    diff_delete = "#402d2e";
    diff_change = "#303642";
    diff_text = "#3e4a64";
    diff_add_emph = "#525d41";
    diff_delete_emph = "#5f393b";
  };
}
