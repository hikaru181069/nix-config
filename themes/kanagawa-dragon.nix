# Kanagawa（Dragon。いちばん暗い種類）。Neovim の rebelot/kanagawa.nvim の色（lua/kanagawa/colors.lua と themes.lua の dragon）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。kanagawa.nvim での名前は、それぞれのコメントに書いた
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "Kanagawa Dragon"; # Ghostty に入っているので、そのまま使う
  nvim = "kanagawa"; # kanagawa.nvim の dragon（nvim/init.lua）
  bat = "kanagawa-dragon"; # bat には入っていないので、Neovim（rebelot/kanagawa.nvim）の実際の色の割り当てから作って足した（bat/kanagawa-dragon.tmTheme）
  btop = "kanagawa-dragon";
  k9s = "kanagawa";
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#bc918c"
    "#b4977a"
    "#a19f79"
    "#88a68a"
    "#76a8a3"
    "#7aa4b7"
  ];

  palette = {
    # 色（dragon のターミナルの色）
    black = "#0d0c0c"; # dragonBlack0
    red = "#c4746e"; # dragonRed
    green = "#8a9a7b"; # dragonGreen2
    yellow = "#c4b28a"; # dragonYellow
    blue = "#8ba4b0"; # dragonBlue2
    magenta = "#a292a3"; # dragonPink
    cyan = "#8ea4a2"; # dragonAqua
    cyan_light = "#bbc8c7"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#c8c093"; # oldWhite
    orange = "#b6927b"; # dragonOrange
    pink = "#a292a3"; # dragonPink

    comment = "#737c73"; # dragonAsh（dragon のコメントの色）

    bg_bar = "#12120f"; # バー・浮かぶウィンドウ・選んでいないタブ（dragonBlack1。通常の背景より少し暗い）
    bg = "#181616"; # 通常の背景（ターミナル・エディタ。dragonBlack3）
    bg_alt = "#282727"; # dragonBlack4
    bg_band = "#393836"; # 帯（sketchybar の今のアプリなど）（dragonBlack5）
    border = "#625e5a"; # 枠線（dragonBlack6）

    fg_bright = "#c5c9c5"; # 明るい文字（dragonWhite）
    fg = "#c5c9c5"; # 通常の文字（dragonWhite）
    fg_dim = "#a6a69c"; # 暗い文字（ステータスライン。dragonGray）
    fg_muted = "#625e5a"; # さらに暗い文字（行番号。dragonBlack6）

    selection = "#393836"; # 選んでいる行の背景（fzf・lazygit など。dragonBlack5）
    search = "#2d4f67"; # 検索結果などの背景（waveBlue2。kanagawa.nvim の検索の背景）

    # 差分の背景（kanagawa.nvim の値）
    # 行の中で実際に変わった部分（_emph）は、kanagawa.nvim に無いので、green / red を背景に 30% 混ぜた色
    diff_add = "#2b3328"; # winterGreen
    diff_delete = "#43242b"; # winterRed
    diff_change = "#252535"; # winterBlue
    diff_text = "#49443c"; # winterYellow
    diff_add_emph = "#3a3e34";
    diff_delete_emph = "#4c3230";
  };
}
