# Tokyo Night（Night。いちばん暗い種類）。Neovim の folke/tokyonight.nvim の色（lua/tokyonight/colors/storm.lua と night.lua）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。tokyonight.nvim での名前は、それぞれのコメントに書いた
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "TokyoNight Night"; # Ghostty に入っているので、そのまま使う
  nvim = "tokyonight"; # tokyonight.nvim の night（nvim/init.lua）
  bat = "tokyo-night"; # bat には入っていないので、Neovim（folke/tokyonight.nvim）の実際の色の割り当てから作って足した（bat/tokyo-night.tmTheme）
  btop = "tokyo-night";
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#fb90a1"
    "#f0a058"
    "#b7bd53"
    "#59ce9c"
    "#23c9e6"
    "#8fb3ff"
  ];

  palette = {
    # 色
    black = "#15161e"; # ターミナルの black（Ghostty の TokyoNight Night）
    red = "#f7768e";
    green = "#9ece6a";
    yellow = "#e0af68";
    blue = "#7aa2f7";
    magenta = "#bb9af7";
    cyan = "#7dcfff";
    cyan_light = "#b1e2ff"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#a9b1d6"; # fg_dark
    orange = "#ff9e64";
    pink = "#bb9af7"; # magenta

    comment = "#737aa2"; # dark5（tokyonight.nvim の comment #565f89 は、バーの文字には暗すぎるので1段明るいもの）

    bg_bar = "#16161e"; # バー・浮かぶウィンドウ・選んでいないタブ（bg_dark。通常の背景より少し暗い）
    bg = "#1a1b26"; # 通常の背景（ターミナル・エディタ。bg）
    bg_alt = "#292e42"; # bg_highlight
    bg_band = "#3b4261"; # 帯（sketchybar の今のアプリなど）（fg_gutter）
    border = "#545c7e"; # 枠線（dark3）

    fg_bright = "#c0caf5"; # 明るい文字（fg）
    fg = "#c0caf5"; # 通常の文字（fg）
    fg_dim = "#a9b1d6"; # 暗い文字（ステータスライン。fg_dark）
    fg_muted = "#545c7e"; # さらに暗い文字（行番号。dark3）

    selection = "#292e42"; # 選んでいる行の背景（fzf・lazygit など。bg_highlight）
    search = "#3d59a1"; # 検索結果などの背景（blue0）

    # 差分の背景。green / red / blue を背景 bg に混ぜた色
    # 行全体は 15%、行の中で実際に変わった部分（_emph）と diff_text は 30%
    diff_add = "#2e3630";
    diff_delete = "#3b2936";
    diff_change = "#282f45";
    diff_text = "#374465";
    diff_add_emph = "#42513a";
    diff_delete_emph = "#5c3645";
  };
}
