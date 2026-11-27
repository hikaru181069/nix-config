# Cyberdream。scottmckendry/cyberdream.nvim の色
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = null; # Ghostty のテーマは使わず、下の色を直接使う（home.nix）
  nvim = "cyberdream"; # scottmckendry/cyberdream.nvim（nvim/init.lua）
  bat = "cyberdream"; # Neovim（scottmckendry/cyberdream.nvim）の実際の色の割り当てから作った（bat/cyberdream.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ffb1a6"
    "#ffb94f"
    "#bad749"
    "#23eaae"
    "#0ae0fd"
    "#a6caff"
  ];

  palette = {
    # 色
    black = "#1e2124";
    red = "#ff6e5e";
    green = "#5eff6c";
    yellow = "#f1ff5e";
    blue = "#5ea1ff";
    magenta = "#bd5eff";
    cyan = "#5ef1ff";
    white = "#ffffff";
    orange = "#ffbd5e";
    pink = "#ff5ea0";

    comment = "#7b8496";

    bg_bar = "#101214"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#16181a"; # 通常の背景
    bg_alt = "#1e2124"; # 通常と少し違う背景
    bg_band = "#3c4048"; # sketchybar のアプリ名の帯など
    border = "#4f535a"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#ffffff"; # 通常の文字
    fg_dim = "#c5c5c6"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#676e7d"; # さらに暗い文字（コメントの色を背景に 20% 寄せた）

    selection = "#3c4048"; # 選んでいる行の背景
    search = "#4f535a"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#213b26";
    diff_delete = "#392524";
    diff_change = "#212d3c";
    diff_text = "#2c415f";
    diff_add_emph = "#2c5d33";
    diff_delete_emph = "#5c322e";
  };
}
