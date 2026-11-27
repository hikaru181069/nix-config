# Terafox（Nightfox の緑系）。EdenEast/nightfox.nvim の色（Neovim で読みこんだ実際の色と、Ghostty のテーマ）
# 色の名前（bg・fg など）は、どのテーマでも同じ役割の名前（palette.nix の説明を参照）
{
  # 各ツールで使うテーマの名前
  ghostty = "Terafox"; # Ghostty に入っている
  nvim = "terafox"; # EdenEast/nightfox.nvim（nvim/init.lua の extra_themes）
  bat = "terafox"; # Neovim（EdenEast/nightfox.nvim）の実際の色の割り当てから作った（bat/terafox.tmTheme）
  btop = "TTY"; # btop には入っていないので、ターミナルの16色をそのまま使う
  k9s = null; # k9s には入っていないので、k9s の標準の見た目
  # tmux のステータスバーの右端の三角（6色）。なめらかな虹: 明るさと鮮やかさ（OKLCH の L・C）をテーマの赤〜青の6色の平均にそろえ、
  # 色み（H）だけをテーマの赤から青へ等間隔に変えた
  rainbow = [
    "#df8e84"
    "#d19b60"
    "#aeab5e"
    "#7db881"
    "#50bbb0"
    "#59b4d7"
  ];

  palette = {
    # 色
    black = "#2f3239";
    red = "#e85c51";
    green = "#7aa4a1";
    yellow = "#fda47f";
    blue = "#5a93aa";
    magenta = "#ad5c7c";
    cyan = "#a1cdd8";
    white = "#ebebeb";
    orange = "#ff9664";
    pink = "#b97490";

    comment = "#6d7f8b";

    bg_bar = "#101c1e"; # バー・浮かぶウィンドウ・選んでいないタブ（背景を黒に 25% 寄せた）
    bg = "#152528"; # 通常の背景
    bg_alt = "#1d3338"; # 通常と少し違う背景（bg と bg_band の間）
    bg_band = "#254147"; # sketchybar のアプリ名の帯など
    border = "#587b7b"; # 枠線

    fg_bright = "#eeeeee"; # 明るい文字
    fg = "#e6eaea"; # 通常の文字
    fg_dim = "#b2b9ba"; # 暗い文字（文字を背景に 25% 寄せた）
    fg_muted = "#587b7b"; # さらに暗い文字

    selection = "#293e40"; # 選んでいる行の背景
    search = "#425e5e"; # 検索結果などの背景

    # 差分の背景。ほかのテーマとそろえて、green / red / blue を背景に混ぜた色（行全体は 15%、_emph と diff_text は 30%）
    diff_add = "#24383a";
    diff_delete = "#352d2e";
    diff_change = "#1f363c";
    diff_text = "#2a464f";
    diff_add_emph = "#334b4c";
    diff_delete_emph = "#543634";
  };
}
