# 選べるフォント（font コマンド）。どれも 18.5pt で幅 22px。行の高さが 49px になるよう adjust（px）を足す
# （Ghostty の余白とシェーダーは、1行 49px で計算してある）
# lineRatio: 文字の上端〜下端の高さ（文字の大きさの何倍か）。sketchybar の三角の大きさの計算に使う
{
  jetbrains = {
    family = "JetBrainsMono Nerd Font";
    lineRatio = 1.32;
    adjust = 0;
  };
  # IBM Plex Mono に合字を足したもの
  lilex = {
    family = "Lilex Nerd Font";
    lineRatio = 1.3;
    adjust = 1;
  };
  # IBM Plex Mono（合字なし）
  blex = {
    family = "BlexMono Nerd Font";
    lineRatio = 1.3;
    adjust = 1;
  };
  maple = {
    family = "Maple Mono NF";
    lineRatio = 1.32;
    adjust = 0;
  };
}
