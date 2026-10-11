# 色の定義はここ1か所。各ツール（tmux, sketchybar, starship, delta, lazygit, fzf など）はここから色を取る
# Nightfox（EdenEast/nightfox.nvim の lua/nightfox/palette/nightfox.lua）の値
{
  black = "#393b44";
  red = "#c94f6d";
  green = "#81b29a";
  yellow = "#dbc074";
  blue = "#719cd6";
  magenta = "#9d79d6";
  cyan = "#63cdcf";
  white = "#dfdfe0";
  orange = "#f4a261";
  pink = "#d67ad2";

  comment = "#738091";

  bg0 = "#131a24"; # 暗い背景（ステータスライン、フロート）
  bg1 = "#192330"; # 通常の背景
  bg2 = "#212e3f"; # 少し明るい背景
  bg3 = "#29394f"; # さらに明るい背景（カーソル行）
  bg4 = "#39506d"; # 枠線

  fg0 = "#d6d6d7"; # 明るい文字
  fg1 = "#cdcecf"; # 通常の文字
  fg2 = "#aeafb0"; # 暗い文字（ステータスライン）
  fg3 = "#71839b"; # さらに暗い文字（行番号）

  sel0 = "#2b3b51"; # 選択範囲の背景
  sel1 = "#3c5372"; # 検索結果の背景

  # 差分の背景（nightfox.nvim の DiffAdd / DiffDelete / DiffChange / DiffText と同じ値）
  diff_add = "#26343c";
  diff_delete = "#2f2837";
  diff_change = "#243244";
  diff_text = "#253f4a";
  # 差分のうち、行の中で実際に変わった部分の背景（green / red を背景 bg1 に 30% 混ぜた色）
  diff_add_emph = "#384e50";
  diff_delete_emph = "#4e3042";
}
