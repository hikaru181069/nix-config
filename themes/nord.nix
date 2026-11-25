# Nord（公式）。https://www.nordtheme.com/docs/colors-and-palettes の nord0〜nord15
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。Nord での名前は、それぞれのコメントに書いた
# ほかのテーマより背景が明るい（#2e3440）
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "Nord"; # Ghostty に入っているので、そのまま使う
  nvim = "nord"; # gbprod/nord.nvim（nvim/init.lua）
  bat = "nord"; # Neovim（gbprod/nord.nvim）の実際の色の割り当てから作った（bat/nord.tmTheme）。bat に最初から入っている同じ名前のテーマは、割り当てが Neovim と違うので使わない
  btop = "nord";
  k9s = "nord";
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#d89397"
    "#cf9d71"
    "#acad6e"
    "#7db892"
    "#62b8bf"
    "#7faddb"
  ];

  palette = {
    # 色（ターミナルの色の割り当ては Ghostty の Nord と同じ）
    black = "#3b4252"; # nord1
    red = "#bf616a"; # nord11
    green = "#a3be8c"; # nord14
    yellow = "#ebcb8b"; # nord13
    blue = "#81a1c1"; # nord9
    magenta = "#b48ead"; # nord15
    cyan = "#88c0d0"; # nord8
    cyan_light = "#b8d9e3"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#e5e9f0"; # nord5
    orange = "#d08770"; # nord12
    pink = "#b48ead"; # Nord に pink はないので nord15

    comment = "#616e88"; # Nord のコメントの色（nord3 を明るくしたもの）

    bg_bar = "#272c36"; # バー・浮かぶウィンドウ・選んでいないタブ（Nord に無いので、nord0 を黒に 15% 寄せた。通常の背景より少し暗い）
    bg = "#2e3440"; # 通常の背景（ターミナル・エディタ。nord0）
    bg_alt = "#3b4252"; # nord1
    bg_band = "#434c5e"; # 帯（sketchybar の今のアプリなど）（nord2）
    border = "#4c566a"; # 枠線（nord3）

    fg_bright = "#eceff4"; # 明るい文字（nord6）
    fg = "#d8dee9"; # 通常の文字（nord4）
    fg_dim = "#d8dee9"; # 暗い文字（ステータスライン。Nord はステータスラインも nord4）
    fg_muted = "#616e88"; # さらに暗い文字（行番号。nord3 を明るくしたもの）

    selection = "#434c5e"; # 選んでいる行の背景（fzf・lazygit など。nord2）
    search = "#4c566a"; # 検索結果などの背景（nord3）

    # 差分の背景。決まった値は無いので、green / red / blue を背景 nord0 に混ぜた色
    # 行全体は 15%、行の中で実際に変わった部分（_emph）と diff_text は 30%
    diff_add = "#40494b";
    diff_delete = "#443b46";
    diff_change = "#3a4453";
    diff_text = "#475567";
    diff_add_emph = "#515d57";
    diff_delete_emph = "#5a424d";
  };
}
