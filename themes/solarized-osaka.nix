# Solarized Osaka。craftzdog/solarized-osaka.nvim の色
# Ghostty の「Solarized Osaka Night」は Tokyo Night と同じ色なので使わない
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty のテーマは使わず、下の色を直接使う（home.nix）
  nvim = "solarized-osaka"; # craftzdog/solarized-osaka.nvim（nvim/init.lua）
  bat = "solarized-osaka"; # Neovim（craftzdog/solarized-osaka.nvim）の実際の色の割り当てから作った（bat/solarized-osaka.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#d15b51"
    "#b77502"
    "#858e00"
    "#009f63"
    "#0398a0"
    "#158cd9"
  ];

  palette = {
    # 色
    black = "#002c38";
    red = "#db302d";
    green = "#849900";
    yellow = "#b28500";
    blue = "#268bd3";
    magenta = "#d23681";
    cyan = "#29a298";
    white = "#adb7b7";
    orange = "#c94c16";
    pink = "#d23681";

    comment = "#576d74";

    bg_bar = "#000f13"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#001419"; # 通常の背景
    bg_alt = "#002c38"; # 通常と少し違う背景
    bg_band = "#063540"; # sketchybar のアプリ名の帯など
    border = "#154e50"; # 枠線

    fg_bright = "#adb7b7"; # 明るい文字
    fg = "#9eabac"; # 通常の文字
    fg_dim = "#768587"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#465b62"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#063540"; # 選んでいる行の背景
    search = "#154e50"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#142815";
    diff_delete = "#21181c";
    diff_change = "#062635";
    diff_text = "#0b3851";
    diff_add_emph = "#283c12";
    diff_delete_emph = "#421c1f";
  };
}
