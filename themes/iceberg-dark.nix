# Iceberg（dark）。本家の cocopon/iceberg.vim の色（colors/iceberg.vim）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Iceberg Dark"; # Ghostty に入っているので、そのまま使う
  nvim = "iceberg"; # cocopon/iceberg.vim（nvim/init.lua）
  bat = "iceberg-dark"; # Neovim（cocopon/iceberg.vim）の実際の色の割り当てから作った（bat/iceberg-dark.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#de9896"
    "#d1a472"
    "#abb476"
    "#7bbf9d"
    "#68bdca"
    "#8ab0e3"
  ];

  palette = {
    # 色
    black = "#1e2132";
    red = "#e27878";
    green = "#b4be82";
    yellow = "#e2a478";
    blue = "#84a0c6";
    magenta = "#a093c7";
    cyan = "#89b8c2";
    white = "#c6c8d1";
    orange = "#e9b189"; # Iceberg に orange はないので、明るい yellow（ターミナルの11番）
    pink = "#ada0d3"; # Iceberg に pink はないので、明るい magenta（ターミナルの13番）

    comment = "#6b7089"; # Comment

    bg_bar = "#0f1117"; # バー・浮かぶウィンドウ・選んでいないタブ（TabLine）
    bg = "#161821"; # 通常の背景（Normal）
    bg_alt = "#1e2132"; # CursorLine
    bg_band = "#272c42"; # sketchybar のアプリ名の帯など（Visual）
    border = "#3e445e"; # 枠線（StatusLineNC）

    fg_bright = "#d2d4de"; # 明るい文字（ターミナルの15番）
    fg = "#c6c8d1"; # 通常の文字（Normal）
    fg_dim = "#818596"; # 暗い文字（StatusLine）
    fg_muted = "#5b6389"; # さらに暗い文字（PmenuSel の背景。LineNr の #444b71 は、バーのブロックの色にすると上の文字が読みにくいので使わない）

    selection = "#272c42"; # 選んでいる行の背景（Visual）
    search = "#3d425b"; # 検索結果などの背景（Pmenu の背景）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#2e3130";
    diff_delete = "#35262e";
    diff_change = "#272c3a";
    diff_text = "#374152";
    diff_add_emph = "#454a3e";
    diff_delete_emph = "#53353b";
  };
}
