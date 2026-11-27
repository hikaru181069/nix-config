# Embark。embark-theme/vim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Embark"; # Ghostty に入っている
  nvim = "embark"; # embark-theme/vim（nvim/init.lua の extra_themes）
  bat = "embark"; # Neovim（embark-theme/vim）の実際の色の割り当てから作った（bat/embark.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ffadc4"
    "#ffb58f"
    "#dfc774"
    "#a2da98"
    "#6adfd4"
    "#84d3ff"
  ];

  palette = {
    # 色
    black = "#1e1c31";
    red = "#f0719b";
    green = "#a1efd3";
    yellow = "#ffe9aa";
    blue = "#57c7ff";
    magenta = "#c792ea";
    cyan = "#87dfeb";
    white = "#f8f8f2";
    orange = "#f2b482";
    pink = "#a742ea";

    comment = "#8a889d";

    bg_bar = "#161525"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#1e1c31"; # 通常の背景
    bg_alt = "#17152a"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#100e23"; # sketchybar のアプリ名の帯など
    border = "#cbe3e7"; # 枠線

    fg_bright = "#dbebee"; # 明るい文字
    fg = "#cbe3e7"; # 通常の文字
    fg_dim = "#a0b1ba"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#585273"; # さらに暗い文字

    selection = "#3e3859"; # 選んでいる行の背景
    search = "#625a55"; # 検索結果などの背景（背景に黄を 30% 混ぜた）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#323c49";
    diff_delete = "#3e2941";
    diff_change = "#273650";
    diff_text = "#2f4f6f";
    diff_add_emph = "#455b62";
    diff_delete_emph = "#5d3651";
  };
}
