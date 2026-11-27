# GitHub Dark Default。Neovim の projekt0n/github-nvim-theme の色（lua/github-theme/palette/github_dark_default.lua と primitives/dark.lua）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。github-nvim-theme での名前は、それぞれのコメントに書いた
# github-nvim-theme の一部の色は、背景（canvas.default）にほかの色を混ぜて作られる。その色は同じ計算をして書いた
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "GitHub Dark Default"; # Ghostty に入っているので、そのまま使う
  # Ghostty の GitHub Dark Default はカーソルが青（#2f81f7）だが、github-nvim-theme のカーソルは通常の文字の色（Cursor = fg）なので、そちらに合わせる
  ghosttyOverride = {
    cursor-color = "#e6edf3"; # fg
    cursor-text = "#0d1117"; # bg
  };
  nvim = "github_dark_default"; # projekt0n/github-nvim-theme（nvim/init.lua）
  bat = "github-dark-default"; # Neovim（projekt0n/github-nvim-theme）の実際の色の割り当てから作った（bat/github-dark-default.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#fb8279"
    "#e49927"
    "#a5b638"
    "#32c78e"
    "#00c4db"
    "#62aeff"
  ];

  palette = {
    # 色
    black = "#484f58"; # gray[6]（ターミナルの0番と同じ）
    red = "#ff7b72"; # red.base（red[4]）
    green = "#3fb950"; # green.base（green[4]）
    yellow = "#d29922"; # yellow.base（yellow[4]）
    blue = "#58a6ff"; # blue.base（blue[4]）
    magenta = "#bc8cff"; # magenta.base（purple[4]）
    cyan = "#76e3ea"; # cyan.base
    white = "#b1bac4"; # white.base（gray[3]）
    orange = "#f0883e"; # orange（orange[4]）
    pink = "#f778ba"; # pink.base（pink[4]）

    comment = "#8b949e"; # syntax.comment

    bg_bar = "#04070c"; # バー・浮かぶウィンドウ・選んでいないタブ（bg0。通常の背景より少し暗い）
    bg = "#0d1117"; # 通常の背景（ターミナル・エディタ。bg1 = canvas.default）
    bg_alt = "#171b22"; # bg2
    bg_band = "#484f58"; # sketchybar のアプリ名の帯など（bg3 = gray[6]。Neovim のカーソル行は nvim/init.lua で暗くしている）
    border = "#30363d"; # 枠線（GitHub の border.default = gray[7]。プラグインの border.default は gray[9] で、背景とほぼ同じ色なので使わない）

    fg_bright = "#f0f6fc"; # 明るい文字（gray[1]）
    fg = "#e6edf3"; # 通常の文字（fg1 = fg.default）
    fg_dim = "#7d8590"; # 暗い文字（ステータスライン。fg2 = fg.muted）
    fg_muted = "#6e7681"; # さらに暗い文字（行番号。fg3）

    selection = "#1c3d6a"; # 選んでいる行の背景（fzf・lazygit など。sel1 = 浮かぶウィンドウで選んでいる行）
    search = "#3c3b33"; # 検索結果などの背景（sel2 = 検索）

    # 差分の背景。行全体（diff_add / diff_delete / diff_change）は github-nvim-theme の diff の色（green[6] / red[6] / yellow[6] を背景に 15% 混ぜた色）
    # 行の中で実際に変わった部分（_emph）と diff_text は、ほかのテーマとそろえて 30% 混ぜた色
    diff_add = "#10231c";
    diff_delete = "#2c171b";
    diff_change = "#231e14";
    diff_text = "#382c11";
    diff_add_emph = "#143420";
    diff_delete_emph = "#4a1c1f";
  };
}
