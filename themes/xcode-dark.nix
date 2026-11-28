# Xcode Dark（Xcode の公式の配色）。lunacookies/vim-colors-xcode の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Xcode Dark"; # Ghostty に入っている
  nvim = "xcodedark"; # lunacookies/vim-colors-xcode（nvim/init.lua の extra_themes）
  bat = "xcode-dark"; # Neovim の実際の色の割り当てから作った（bat/xcode-dark.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#f39082"
    "#e39f53"
    "#bbb44f"
    "#7ec47c"
    "#37c9b5"
    "#39c1e5"
  ];

  palette = {
    # 色
    black = "#414453";
    red = "#ff8170";
    green = "#78c2b3";
    yellow = "#d9c97c";
    blue = "#4eb0cc";
    magenta = "#ff7ab2";
    cyan = "#b281eb";
    white = "#dfdfe0";
    orange = "#ffa14f";
    pink = "#ff95c1";

    comment = "#7f8c98";

    bg_bar = "#1f2024"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#292a30"; # 通常の背景
    bg_alt = "#2c2d34"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#2f3037"; # sketchybar のアプリ名の帯など
    border = "#56575c"; # 枠線（背景に文字の色を 25% 混ぜた）

    fg_bright = "#e9e9e9"; # 明るい文字
    fg = "#dfdfe0"; # 通常の文字
    fg_dim = "#b2b2b4"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#53606e"; # さらに暗い文字

    selection = "#414453"; # 選んでいる行の背景
    search = "#414453"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#354144";
    diff_delete = "#49373a";
    diff_change = "#2f3e47";
    diff_text = "#34525f";
    diff_add_emph = "#415857";
    diff_delete_emph = "#694443";
  };
}
