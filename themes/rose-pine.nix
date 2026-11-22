# Rosé Pine（main。3つの種類のうち、いちばん暗いもの）。Neovim の rose-pine/neovim の色（lua/rose-pine/palette.lua）
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。Rosé Pine での名前は、それぞれのコメントに書いた
# Rosé Pine には緑・水色がないので、ターミナルの色の割り当て（Ghostty の Rose Pine と同じ）に合わせた
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "Rose Pine"; # Ghostty に入っているので、そのまま使う
  nvim = "rose-pine"; # rose-pine/neovim の main（nvim/init.lua）
  bat = "ansi"; # bat には入っていないので、ターミナルの16色（Ghostty の Rose Pine）をそのまま使う
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = "rose-pine";
  # tmux のステータスバーの右端の三角（6色）。Rosé Pine には赤から青へ並べられる色がそろっていないので、
  # love（ピンク）→ iris（紫）→ foam（水色）の間をなめらかにつないだ色にする（love と iris、iris と foam を混ぜた）
  rainbow = [
    "#eb6f92" # love
    "#db85b4"
    "#cc9cd6"
    "#bcafe4"
    "#acbfde"
    "#9ccfd8" # foam
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
    cyan_light = "#f3d7d6"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#e0def4"; # text
    orange = "#ebbcba"; # Rosé Pine に orange はないので rose
    pink = "#ebbcba"; # rose

    comment = "#908caa"; # subtle

    bg0 = "#16141f"; # バー・浮かぶウィンドウ・選んでいないタブ（_nc。通常の背景より少し暗い）
    bg1 = "#191724"; # 通常の背景（ターミナル・エディタ。base）
    bg2 = "#1f1d2e"; # surface
    bg3 = "#26233a"; # カーソル行（overlay）
    bg4 = "#524f67"; # 枠線（highlight_high）

    fg0 = "#e0def4"; # 明るい文字（text）
    fg1 = "#e0def4"; # 通常の文字（text）
    fg2 = "#908caa"; # 暗い文字（ステータスライン。subtle）
    fg3 = "#6e6a86"; # さらに暗い文字（行番号。muted）

    sel0 = "#26233a"; # 選んでいる行の背景（fzf・lazygit など。overlay）
    sel1 = "#403d52"; # 検索結果などの背景（highlight_med）

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
