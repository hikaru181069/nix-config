# 選べるフォント（font コマンド）。どれも 18.5pt で幅 22px。行の高さが 49px になるよう adjust（px）を足す
# （Ghostty の余白とシェーダーは、1行 49px で計算してある）
# lineRatio: 文字の上端〜下端の高さ（文字の大きさの何倍か）
# arrowRatio: Nerd Font の三角（e0b0）の実際の高さ（文字の大きさの何倍か）。sketchybar の三角の大きさの計算に使う
#   lineRatio より少し大きいフォントがあり、そのまま lineRatio で計算すると三角が帯より少しはみ出す（fontTools で測った）
{
  jetbrains = {
    family = "JetBrainsMono Nerd Font";
    lineRatio = 1.32;
    arrowRatio = 1.332;
    adjust = 0;
  };
  # IBM Plex Mono に合字を足したもの
  lilex = {
    family = "Lilex Nerd Font";
    lineRatio = 1.3;
    arrowRatio = 1.314;
    adjust = 1;
  };
  # IBM Plex Mono（合字なし）
  blex = {
    family = "BlexMono Nerd Font";
    lineRatio = 1.3;
    arrowRatio = 1.314;
    adjust = 1;
  };
  maple = {
    family = "Maple Mono NF";
    lineRatio = 1.32;
    arrowRatio = 1.32;
    adjust = 0;
  };
}
