# Flexoki（dark）。kepano/flexoki-neovim の色（lua/flexoki/palette.lua）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Flexoki Dark"; # Ghostty に入っているので、そのまま使う
  nvim = "flexoki"; # kepano/flexoki-neovim（nvim/init.lua）
  bat = "flexoki-dark"; # Neovim（kepano/flexoki-neovim）の実際の色の割り当てから作った（bat/flexoki-dark.tmTheme）
  btop = "flexoki-dark"; # btop に入っている
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#d56c60"
    "#c18015"
    "#8c9927"
    "#2da872"
    "#00a6b4"
    "#4095dc"
  ];

  # tmux のユーザー名のブロックと右端の三角。既定（fg_dim と fg）だと三角が明るくて浮くので、Neovim のステータスラインのノーマルモードと同じ色にする
  tmuxUser = {
    block = "#6f6e69"; # fg_muted
    arrow = "#878580"; # comment
  };

  palette = {
    # 色
    black = "#1c1b1a"; # 950
    red = "#d14d41"; # re
    green = "#879a39"; # gr
    yellow = "#d0a215"; # ye
    blue = "#4385be"; # bl
    magenta = "#8b7ec8"; # pu
    cyan = "#3aa99f"; # cy
    cyan_light = "#89cbc5"; # cyan を白に4割寄せた色（tmux の prefix 中の三角など、ブロックより1段明るい区切りに使う）
    white = "#cecdc3"; # tx
    orange = "#da702c"; # or
    pink = "#ce5d97"; # ma

    comment = "#878580"; # tx-2。バーの文字などに使う

    bg_bar = "#0a0909"; # バー・浮かぶウィンドウ・選んでいないタブ（Flexoki に無いので、bg を黒に 40% 寄せた）
    bg = "#100f0f"; # 通常の背景（bg）
    bg_alt = "#1c1b1a"; # bg-2
    bg_band = "#343331"; # sketchybar のアプリ名の帯など（ui-2）
    border = "#403e3c"; # 枠線（ui-3）

    fg_bright = "#e6e4d9"; # 明るい文字（100）
    fg = "#cecdc3"; # 通常の文字（tx）
    fg_dim = "#878580"; # 暗い文字（tx-2）
    fg_muted = "#6f6e69"; # さらに暗い文字（600）

    selection = "#282726"; # 選んでいる行の背景（ui）
    search = "#4d3a0b"; # 検索結果などの背景（yellow-900）

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#222415";
    diff_delete = "#2d1816";
    diff_change = "#182129";
    diff_text = "#1f3244";
    diff_add_emph = "#34391c";
    diff_delete_emph = "#4a221e";
  };
}
