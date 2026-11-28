# LaserWave（VS Code の LaserWave を移したもの。80年代の Outrun 風）。lettertwo/laserwave.nvim の色（Neovim で読みこんだ実際の色）
# ターミナルの色はプラグインのもの（赤はピンク寄り）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty に入っていないので、下の色を直接使う（home.nix）
  nvim = "laserwave"; # lettertwo/laserwave.nvim（nvim/init.lua の extra_themes）
  bat = "laserwave"; # Neovim の実際の色の割り当てから作った（bat/laserwave.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#f9a0d3"
    "#ffa698"
    "#f0b461"
    "#b9cc6d"
    "#6dd9ab"
    "#46d6ea"
  ];

  palette = {
    # 色
    black = "#91889b";
    red = "#eb64b9";
    green = "#74dfc4";
    yellow = "#ffe261";
    blue = "#40b4c4";
    magenta = "#b381c5";
    cyan = "#b4dce7";
    white = "#ffffff";
    orange = "#ffb85b";
    pink = "#eb64b9";

    comment = "#91889b";

    bg_bar = "#1d1922"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#27212e"; # 通常の背景
    bg_alt = "#302838"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#392e42"; # sketchybar のアプリ名の帯など
    border = "#eb64b9"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字（文字と同じ（もう白に近い））
    fg = "#ffffff"; # 通常の文字
    fg_dim = "#c9c8cb"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#7c7385"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#3f334a"; # 選んでいる行の背景
    search = "#684e79"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#333e44";
    diff_delete = "#442b43";
    diff_change = "#2b3744";
    diff_text = "#2e4d5b";
    diff_add_emph = "#3e5a5b";
    diff_delete_emph = "#623558";
  };
}
