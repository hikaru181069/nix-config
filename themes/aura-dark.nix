# Aura（dark）。daltonmenezes/aura-theme の色（packages/neovim と packages/vscode）
# 色の数が少なく、Ghostty の Aura は青と紫、緑と水色が同じ色。ここでは見分けやすいように、公式の別の色（blue・pink）を水色と紫に当てた
# 色の名前（bg0〜bg4・fg0〜fg3 など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Aura"; # Ghostty に入っているので、そのまま使う
  nvim = "aura-dark"; # daltonmenezes/aura-theme（nvim/init.lua）
  bat = "aura-dark"; # Neovim（daltonmenezes/aura-theme）の実際の色の割り当てから作った（bat/aura-dark.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ff9c97"
    "#f4b64b"
    "#a0d572"
    "#15dfd1"
    "#63cdff"
    "#caafff"
  ];

  palette = {
    # 色
    black = "#110f18";
    red = "#ff6767"; # red
    green = "#61ffca"; # green
    yellow = "#ffca85"; # orange
    blue = "#a277ff"; # purple（ターミナルの4番と同じ）
    magenta = "#f694ff"; # pink
    cyan = "#82e2ff"; # blue
    cyan_light = "#b4eeff"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#edecee";
    orange = "#ffca85"; # orange
    pink = "#f694ff"; # pink

    comment = "#6d6d6d"; # gray

    bg0 = "#110f18"; # バー・浮かぶウィンドウ・選んでいないタブ（VS Code 版の sideBar）
    bg1 = "#15141b"; # 通常の背景（black）
    bg2 = "#1f1d27"; # bg1 と bg3 の間の色
    bg3 = "#2e2b38"; # sketchybar のアプリ名の帯など（VS Code 版の選んでいる行）
    bg4 = "#3d375e"; # 枠線（purple_faded）

    fg0 = "#edecee"; # 明るい文字（white）
    fg1 = "#edecee"; # 通常の文字（white）
    fg2 = "#bdbdbd"; # 暗い文字（soft-text の white）
    fg3 = "#6d6d6d"; # さらに暗い文字（gray）

    sel0 = "#2e2b38"; # 選んでいる行の背景（VS Code 版の選んでいる行）
    sel1 = "#3d375e"; # 検索結果などの背景（purple_faded）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#203735";
    diff_delete = "#382026";
    diff_change = "#2a233d";
    diff_text = "#3f325f";
    diff_add_emph = "#2c5a4f";
    diff_delete_emph = "#5b2d32";
  };
}
