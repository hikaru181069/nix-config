# Catppuccin Mocha。公式の色（https://catppuccin.com/palette）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。Catppuccin での名前は、それぞれのコメントに書いた
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "Catppuccin Mocha"; # Ghostty に入っているので、そのまま使う
  nvim = "catppuccin"; # catppuccin/nvim の mocha（nvim/init.lua）
  bat = "catppuccin-mocha"; # Neovim（catppuccin/nvim）の実際の色の割り当てから作った（bat/catppuccin-mocha.tmTheme）。bat に最初から入っている同じ名前のテーマは、割り当てが Neovim と違うので使わない
  btop = "TTY"; # btop には入っていないので、ターミナルの16色（Ghostty の Catppuccin Mocha）をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#ffacc1"
    "#fbb689"
    "#d0cc7d"
    "#8fdbad"
    "#70daea"
    "#a8c9ff"
  ];

  palette = {
    # 色
    black = "#11111b"; # crust
    red = "#f38ba8";
    green = "#a6e3a1";
    yellow = "#f9e2af";
    blue = "#89b4fa";
    magenta = "#cba6f7"; # mauve
    cyan = "#94e2d5"; # teal
    cyan_light = "#bfeee6"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#bac2de"; # subtext1
    orange = "#fab387"; # peach
    pink = "#f5c2e7";

    comment = "#7f849c"; # overlay1

    bg_bar = "#181825"; # バー・浮かぶウィンドウ・選んでいないタブ（mantle。通常の背景より少し暗い）
    bg = "#1e1e2e"; # 通常の背景（ターミナル・エディタ。base）
    bg_alt = "#313244"; # surface0
    bg_band = "#45475a"; # 帯（sketchybar の今のアプリなど）（surface1）
    border = "#585b70"; # 枠線（surface2）

    fg_bright = "#cdd6f4"; # 明るい文字（text）
    fg = "#bac2de"; # 通常の文字（subtext1）
    fg_dim = "#a6adc8"; # 暗い文字（ステータスライン。subtext0）
    fg_muted = "#6c7086"; # さらに暗い文字（行番号。overlay0）

    selection = "#313244"; # 選んでいる行の背景（fzf・lazygit など。surface0）
    search = "#45475a"; # 検索結果などの背景（surface1）

    # 差分の背景。Catppuccin に決まった値は無いので、green / red / blue を背景 base に混ぜた色
    # 行全体は 15%、行の中で実際に変わった部分（_emph）と diff_text は 30%
    diff_add = "#323c3f";
    diff_delete = "#3e2e40";
    diff_change = "#2e344d";
    diff_text = "#3e4b6b";
    diff_add_emph = "#475950";
    diff_delete_emph = "#5e3f53";
  };
}
