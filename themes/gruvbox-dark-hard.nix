# Gruvbox Dark Hard。Ghostty 同梱の「Gruvbox Dark Hard」と、Neovim の gruvbox.nvim（contrast = "hard"）の値
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "Gruvbox Dark Hard"; # Ghostty に入っているので、そのまま使う
  nvim = "gruvbox"; # gruvbox.nvim（nvim/init.lua）
  bat = "gruvbox-dark"; # bat・delta の構文の色
  btop = "gruvbox_dark_v2";
  k9s = "gruvbox-dark-hard";
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#f88572"
    "#ed9142"
    "#d3a31e"
    "#aab438"
    "#72c16a"
    "#12c79c"
  ];

  palette = {
    # 色（暗い背景で使う、明るいほうの Gruvbox の色）
    black = "#1d2021";
    red = "#fb4934";
    green = "#b8bb26";
    yellow = "#fabd2f";
    blue = "#83a598";
    magenta = "#d3869b";
    cyan = "#8ec07c"; # Gruvbox の aqua
    cyan_light = "#bbd9b0"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#ebdbb2";
    orange = "#fe8019";
    pink = "#d3869b"; # Gruvbox に pink はないので purple と同じ

    comment = "#928374"; # Gruvbox の gray

    bg0 = "#282828"; # バー・浮かぶウィンドウ・選んでいないタブ（通常の背景と少しだけ変える）
    bg1 = "#1d2021"; # 通常の背景（ターミナル・エディタ）
    bg2 = "#32302f";
    bg3 = "#3c3836"; # カーソル行
    bg4 = "#504945"; # 枠線

    fg0 = "#fbf1c7"; # 明るい文字
    fg1 = "#ebdbb2"; # 通常の文字
    fg2 = "#bdae93"; # 暗い文字（ステータスライン）
    fg3 = "#7c6f64"; # さらに暗い文字（行番号）

    sel0 = "#3c3836"; # 選んでいる行の背景（fzf・lazygit など）
    sel1 = "#504945"; # 検索結果などの背景

    # 差分の背景
    # 行の中で実際に変わった部分（_emph）は、Neovim の gruvbox.nvim の DiffAdd / DiffDelete と同じ色
    # 行全体（diff_add / diff_delete）は、green / red を背景 bg1 に 15% 混ぜた、より控えめな色
    diff_add = "#343722";
    diff_delete = "#3e2624";
    diff_change = "#3e4934"; # gruvbox.nvim の DiffChange
    diff_text = "#fabd2f"; # gruvbox.nvim の DiffText（黄色の地に暗い文字）
    diff_add_emph = "#5a633a";
    diff_delete_emph = "#792329";
  };
}
