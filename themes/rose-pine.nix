# Rosé Pine（main。3つの種類のうち、いちばん暗いもの）。Neovim の rose-pine/neovim の色（lua/rose-pine/palette.lua）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。Rosé Pine での名前は、それぞれのコメントに書いた
# Rosé Pine には緑・水色がないので、ターミナルの色の割り当て（Ghostty の Rose Pine と同じ）に合わせた
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "Rose Pine"; # Ghostty に入っているので、そのまま使う
  nvim = "rose-pine"; # rose-pine/neovim の main（nvim/init.lua）
  bat = "rose-pine"; # bat には入っていないので、Neovim（rose-pine/neovim）の実際の色の割り当てから作って足した（bat/rose-pine.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = "rose-pine";
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#e09bab"
    "#dfa084"
    "#c9ae71"
    "#a2bc81"
    "#79c3a7"
    "#6bc0cf"
  ];

  palette = {
    # 色
    black = "#26233a"; # overlay
    red = "#eb6f92"; # love
    green = "#31748f"; # pine
    yellow = "#f6c177"; # gold
    blue = "#9ccfd8"; # foam
    magenta = "#c4a7e7"; # iris
    cyan = "#ebbcba"; # rose
    white = "#e0def4"; # text
    orange = "#ebbcba"; # Rosé Pine に orange はないので rose
    pink = "#ebbcba"; # rose

    comment = "#908caa"; # subtle

    bg_bar = "#16141f"; # バー・浮かぶウィンドウ・選んでいないタブ（_nc。通常の背景より少し暗い）
    bg = "#191724"; # 通常の背景（ターミナル・エディタ。base）
    bg_alt = "#1f1d2e"; # surface
    bg_band = "#26233a"; # 帯（sketchybar の今のアプリなど）（overlay）
    border = "#524f67"; # 枠線（highlight_high）

    fg_bright = "#e0def4"; # 明るい文字（text）
    fg = "#e0def4"; # 通常の文字（text）
    fg_dim = "#908caa"; # 暗い文字（ステータスライン。subtle）
    fg_muted = "#6e6a86"; # さらに暗い文字（行番号。muted）

    selection = "#26233a"; # 選んでいる行の背景（fzf・lazygit など。overlay）
    search = "#403d52"; # 検索結果などの背景（highlight_med）

    # 差分の背景。決まった値は無いので、foam / love / rose を背景 base に混ぜた色
    # 行全体は 15%、行の中で実際に変わった部分（_emph）と diff_text は 30%
    diff_add = "#2d333f";
    diff_delete = "#382434";
    diff_change = "#38303a";
    diff_text = "#584851";
    diff_add_emph = "#404e5a";
    diff_delete_emph = "#583145";
  };
}
