# GitHub Dark Dimmed。Neovim の projekt0n/github-nvim-theme の色（lua/github-theme/palette/github_dark_dimmed.lua と primitives/dark_dimmed.lua）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。github-nvim-theme での名前は、それぞれのコメントに書いた
# github-nvim-theme の一部の色は、背景（canvas.default）にほかの色を混ぜて作られる。その色は同じ計算をして書いた
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "GitHub Dark Dimmed"; # Ghostty に入っているので、そのまま使う
  # Ghostty の GitHub Dark Dimmed はカーソルが青（#539bf5）だが、github-nvim-theme のカーソルは通常の文字の色（Cursor = fg）なので、そちらに合わせる
  ghosttyOverride = {
    cursor-color = "#adbac7"; # fg
    cursor-text = "#22272e"; # bg
  };
  nvim = "github_dark_dimmed"; # projekt0n/github-nvim-theme（nvim/init.lua）
  bat = "github-dark-dimmed"; # bat には入っていないので、Neovim の github-nvim-theme の色の割り当てに合わせて作って足した（bat/github-dark-dimmed.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ed7e75"
    "#d8932c"
    "#9cae3d"
    "#33be8b"
    "#00bad2"
    "#64a5f8"
  ];

  palette = {
    # 色
    black = "#545d68"; # gray[6]（ターミナルの0番と同じ）
    red = "#f47067"; # red.base（red[4]）
    green = "#57ab5a"; # green.base（green[4]）
    yellow = "#c69026"; # yellow.base（yellow[4]）
    blue = "#539bf5"; # blue.base（blue[4]）
    magenta = "#b083f0"; # magenta.base（purple[4]）
    cyan = "#76e3ea"; # cyan.base
    white = "#909dab"; # white.base（gray[3]）
    orange = "#e0823d"; # orange（orange[4]）
    pink = "#e275ad"; # pink.base（pink[4]）

    comment = "#768390"; # syntax.comment

    bg_bar = "#1e232a"; # バー・浮かぶウィンドウ・選んでいないタブ（bg0。通常の背景より少し暗い）
    bg = "#22272e"; # 通常の背景（ターミナル・エディタ。bg1 = canvas.default）
    bg_alt = "#282e36"; # bg2
    bg_band = "#30363d"; # 帯（sketchybar の今のアプリなど）（bg3）
    border = "#444c56"; # 枠線（border.default = gray[7]）

    fg_bright = "#cdd9e5"; # 明るい文字（gray[1]。ターミナルの15番と同じ）
    fg = "#adbac7"; # 通常の文字（fg1 = fg.default）
    fg_dim = "#768390"; # 暗い文字（ステータスライン。fg2 = fg.muted）
    fg_muted = "#636e7b"; # さらに暗い文字（行番号。fg3）

    selection = "#2a4b79"; # 選んでいる行の背景（fzf・lazygit など。sel1 = 浮かぶウィンドウで選んでいる行）
    search = "#4d4c42"; # 検索結果などの背景（sel2 = 検索）

    # 差分の背景。行全体（diff_add / diff_delete / diff_change）は github-nvim-theme の diff の色（green[6] / red[6] / yellow[6] を背景に 15% 混ぜた色）
    # 行の中で実際に変わった部分（_emph）と diff_text は、ほかのテーマとそろえて 30% 混ぜた色
    diff_add = "#253430";
    diff_delete = "#3b2a2f";
    diff_change = "#333027";
    diff_text = "#453a20";
    diff_add_emph = "#274131";
    diff_delete_emph = "#542d31";
  };
}
