# Sora（空）。Aejkatappaja/sora の色（lua/sora/palette.lua）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty に入っていないので、下の色を直接使う（home.nix）
  nvim = "sora"; # Aejkatappaja/sora（nvim/init.lua）
  bat = "sora"; # Neovim（Aejkatappaja/sora）の実際の色の割り当てから作った（bat/sora.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#dd99a0"
    "#d7a07c"
    "#bdae71"
    "#95bb88"
    "#70bfaf"
    "#70bad3"
  ];

  palette = {
    # 色（赤〜水色は、公式のターミナルの16色と同じ）
    black = "#0e1018";
    red = "#c46c78"; # error
    green = "#90c8a0"; # sage
    yellow = "#d4b878"; # gold
    blue = "#80c8e0"; # cyan（このテーマの主役の色）
    magenta = "#b0a0d8"; # purple
    cyan = "#78b8b0"; # teal
    white = "#c8d0e0";
    orange = "#d0a888"; # peach
    pink = "#d0909c"; # rose

    comment = "#586478"; # fg_comment

    bg_bar = "#0a0c12"; # バー・浮かぶウィンドウ・選んでいないタブ（bg_float・bg_statusline）
    bg = "#0e1018"; # 通常の背景（bg）
    bg_alt = "#14161e"; # bg_elevated
    bg_band = "#1e2430"; # sketchybar のアプリ名の帯など（bg_selection）
    border = "#364050"; # 枠線（border）

    fg_bright = "#dce4f0"; # 明るい文字（fg_bright）
    fg = "#c8d0e0"; # 通常の文字（fg）
    fg_dim = "#9aa4b8"; # 暗い文字（fg_dim）
    fg_muted = "#4a5468"; # さらに暗い文字（terminal_bright_black）

    selection = "#283448"; # 選んでいる行の背景（bg_selected。公式の lazygit の設定と同じ）
    search = "#1a3050"; # 検索結果などの背景（bg_search）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    # 公式の差分の色（#0e1c16 など）は、背景とほとんど見分けがつかないので使わない
    diff_add = "#222c2c";
    diff_delete = "#291e26";
    diff_change = "#1f2c36";
    diff_text = "#304754";
    diff_add_emph = "#354741";
    diff_delete_emph = "#452c35";
  };
}
