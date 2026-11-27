# GitHub Dark（無印）。projekt0n/github-nvim-theme の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "GitHub Dark"; # Ghostty に入っている
  ghosttyOverride = {
    background = "#30363d"; # Neovim 版の背景にそろえる（Ghostty 版は #101216）
  };
  nvim = "github_dark"; # projekt0n/github-nvim-theme（nvim/init.lua）
  bat = "github-dark"; # Neovim の実際の色の割り当てから作った（bat/github-dark.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ef8269"
    "#d39927"
    "#94b348"
    "#21c095"
    "#06b9d4"
    "#6da6fb"
  ];

  palette = {
    # 色
    black = "#000000";
    red = "#f78166";
    green = "#56d364";
    yellow = "#e3b341";
    blue = "#6ca4f8";
    magenta = "#db61a2";
    cyan = "#2b7489";
    white = "#ffffff";
    orange = "#ffa657";
    pink = "#e281b5";

    comment = "#8b949e";

    bg_bar = "#24282e"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#30363d"; # 通常の背景
    bg_alt = "#3c424a"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#484f58"; # sketchybar のアプリ名の帯など
    border = "#161b22"; # 枠線

    fg_bright = "#ffffff"; # 明るい文字
    fg = "#e6edf3"; # 通常の文字
    fg_dim = "#b8bfc6"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#6e7681"; # さらに暗い文字

    selection = "#304d75"; # 選んでいる行の背景
    search = "#585951"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#364e43";
    diff_delete = "#4e4143";
    diff_change = "#394659";
    diff_text = "#425775";
    diff_add_emph = "#3b6549";
    diff_delete_emph = "#6c4c49";
  };
}
