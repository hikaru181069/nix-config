# Everforest（Dark Hard。いちばん暗い種類）。Neovim の neanias/everforest-nvim の色（lua/everforest/colours.lua の hard と dark）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）。everforest-nvim での名前は、それぞれのコメントに書いた
# Ghostty の Everforest Dark Hard は、背景に bg_dim（#1e2326）を使っていて、Neovim の hard の背景 bg0（#272e33）より暗い。
# Neovim を開いたところだけ明るく見えないよう、Neovim の背景を Ghostty に合わせる（nvim/init.lua）
{
  # 各ツールで使う、最初から入っているテーマの名前
  ghostty = "Everforest Dark Hard"; # Ghostty に入っているので、そのまま使う
  nvim = "everforest"; # everforest-nvim の hard（nvim/init.lua）
  bat = "everforest-dark-hard"; # bat には入っていないので、Neovim（neanias/everforest-nvim）の実際の色の割り当てから作って足した（bat/everforest-dark-hard.tmTheme）
  btop = "everforest-dark-hard";
  k9s = "everforest-dark";
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#e69898"
    "#e0a077"
    "#cbac68"
    "#a9b973"
    "#81c293"
    "#62c4b8"
  ];

  palette = {
    # 色
    black = "#2e383c"; # bg1
    red = "#e67e80";
    green = "#a7c080";
    yellow = "#dbbc7f";
    blue = "#7fbbb3";
    magenta = "#d699b6"; # purple
    cyan = "#83c092"; # aqua
    cyan_light = "#b5d9be"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#d3c6aa"; # fg
    orange = "#e69875";
    pink = "#d699b6"; # purple

    comment = "#859289"; # grey1

    bg_bar = "#1a1e20"; # バー・浮かぶウィンドウ・選んでいないタブ（Everforest に無いので、bg_dim を黒に 15% 寄せた。通常の背景より少し暗い）
    bg = "#1e2326"; # 通常の背景（ターミナル・エディタ。bg_dim。Ghostty の Everforest Dark Hard と同じ）
    bg_alt = "#272e33"; # bg0
    bg_band = "#2e383c"; # 帯（sketchybar の今のアプリなど）（bg1）
    border = "#495156"; # 枠線（bg4）

    fg_bright = "#d3c6aa"; # 明るい文字（fg）
    fg = "#d3c6aa"; # 通常の文字（fg）
    fg_dim = "#9da9a0"; # 暗い文字（ステータスライン。grey2）
    fg_muted = "#7a8478"; # さらに暗い文字（行番号。grey0）

    selection = "#374145"; # 選んでいる行の背景（fzf・lazygit など。bg2）
    search = "#414b50"; # 検索結果などの背景（bg3）

    # 差分の背景（everforest-nvim の hard の値）
    # 行の中で実際に変わった部分（_emph）は、everforest-nvim に無いので、green / red を背景に 30% 混ぜた色
    diff_add = "#3c4841"; # bg_green
    diff_delete = "#493b40"; # bg_red
    diff_change = "#384b55"; # bg_blue
    diff_text = "#45443c"; # bg_yellow
    diff_add_emph = "#475241";
    diff_delete_emph = "#5a3e41";
  };
}
