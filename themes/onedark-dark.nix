# One Dark Pro の onedark_dark（背景が真っ黒の種類）。olimorris/onedarkpro.nvim の色（lua/onedarkpro/themes/onedark_dark.lua）
# onedark-darker（navarasu/onedark.nvim の darker）とは作者が違う別のテーマ
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty に入っていないので、下の色を直接使う（home.nix）
  nvim = "onedark_dark"; # olimorris/onedarkpro.nvim（nvim/init.lua）
  bat = "onedark-dark"; # Neovim（olimorris/onedarkpro.nvim）の実際の色の割り当てから作った（bat/onedark-dark.tmTheme）
  btop = "TTY"; # 背景が真っ黒なので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ee8992"
    "#e39854"
    "#b4b04b"
    "#67c286"
    "#14c2c9"
    "#63b2f4"
  ];

  palette = {
    # 色
    black = "#000000";
    red = "#ef596f";
    green = "#89ca78";
    yellow = "#e5c07b";
    blue = "#61afef";
    magenta = "#d55fde"; # purple
    cyan = "#2bbac5";
    cyan_light = "#80d6dc"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#abb2bf";
    orange = "#d19a66";
    pink = "#e089e7"; # pink はないので、明るい purple（作者のターミナルの13番）

    comment = "#7f848e"; # comment

    bg_bar = "#0e0e0e"; # バー・浮かぶウィンドウ・選んでいないタブ（bg_statusline。背景が真っ黒なので、少し明るい色）
    bg = "#000000"; # 通常の背景（bg）
    bg_alt = "#171717"; # cursorline
    bg_band = "#282c34"; # sketchybar のアプリ名の帯など（標準の One Dark Pro の背景）
    border = "#434852"; # 枠線（gray）

    fg_bright = "#c8cdd5"; # 明るい文字（作者のターミナルの15番）
    fg = "#abb2bf"; # 通常の文字（fg）
    fg_dim = "#7f848e"; # 暗い文字（comment）
    fg_muted = "#5c6370"; # さらに暗い文字（標準の One Dark Pro の gray）

    selection = "#212121"; # 選んでいる行の背景（selection）
    search = "#434852"; # 検索結果などの背景（gray）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#151e12";
    diff_delete = "#240d11";
    diff_change = "#0f1a24";
    diff_text = "#1d3448";
    diff_add_emph = "#293d24";
    diff_delete_emph = "#481b21";
  };
}
