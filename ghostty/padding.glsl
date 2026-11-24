// ウィンドウの余白の色を直す: 上の余白はすぐ下の行とつなげ、下の余り（行の高さで割り切れない分）は背景色で塗る
// window-padding-color = extend-always は、余りを真上のマスの色で塗るので、tmux のバーが下に伸びて見える
// 8 は上の余白（window-padding-y の 4pt）、49 は1行の高さ（どちらも画面の px）。文字の大きさを変えたら直す
// 背景の透け具合（1.0 は不透明）。半透明のときは home.nix が書きかえる
const float opacity = 1.0;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    fragColor = texture(iChannel0, fragCoord / iResolution.xy);
    float rest = mod(iResolution.y - 8.0, 49.0);
    if (fragCoord.y > iResolution.y - rest) {
        fragColor = vec4(iBackgroundColor * opacity, opacity);
    }
    // 上の余白は、すぐ下の行のいちばん上の 1px と同じ色にする
    // Ghostty はマスの背景色で塗るので、Neovim のタブの斜めの区切り（背景はタブの色）の上だけ、隙間のように見える
    if (fragCoord.y < 8.0) {
        fragColor = texture(iChannel0, vec2(fragCoord.x, 8.5) / iResolution.xy);
    }
}
