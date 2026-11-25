{
  config,
  lib,
  pkgs,
  ...
}:

let
  palette = import ./palette.nix;
  # 使うテーマ（theme.nix）。色は palette、各ツールのテーマの名前（ghostty・bat・btop・k9s）はここから取る
  theme = import ./theme.nix;
  # ファイルの種類のアイコン（絵と色）。Neovim の nvim-material-icon から取り出したもので、eza・yazi・lazygit を同じにそろえる
  # 作り直すとき: Neovim で require("nvim-web-devicons") の get_icons_by_filename / get_icons_by_extension を JSON にする
  fileIcons = lib.importJSON ./icons/material.json;
  # 使うフォント（font.nix）。大きさなどは fonts.nix
  font = (import ./fonts.nix).${import ./font.nix};
  # true にすると、ターミナルを半透明にする。透けるのはテーマのメインの背景色（bg1）だけ。false のときの設定は何も変わらない
  # transparent.nix に書いてあり、`transparent` コマンドで切り替える
  transparent = (import ./transparent.nix).on;
  # 半透明のときの Ghostty の背景の透け具合（1 は不透明）
  backgroundOpacity = (import ./transparent.nix).opacity;
  # Ghostty の色: テーマが Ghostty に入っていれば、その名前を使う。入っていなければ、palette の色を直接決める
  ghosttyColors =
    if theme.ghostty != null then
      # ghosttyOverride: Ghostty のテーマの色のうち、上書きしたいもの（テーマのファイルに書いたときだけ）
      { theme = theme.ghostty; } // (theme.ghosttyOverride or { })
    else
      {
        background = palette.bg1;
        foreground = palette.fg1;
        cursor-color = palette.fg1;
        selection-background = palette.sel1;
        selection-foreground = palette.fg0;
        # ターミナルの16色（0〜7 がふつう、8〜15 が明るい色。明るい色も同じ色を使う）
        palette = [
          "0=${palette.black}"
          "1=${palette.red}"
          "2=${palette.green}"
          "3=${palette.yellow}"
          "4=${palette.blue}"
          "5=${palette.magenta}"
          "6=${palette.cyan}"
          "7=${palette.fg1}"
          "8=${palette.fg3}"
          "9=${palette.red}"
          "10=${palette.green}"
          "11=${palette.yellow}"
          "12=${palette.blue}"
          "13=${palette.magenta}"
          "14=${palette.cyan}"
          "15=${palette.fg0}"
        ];
      };
  # 壁紙: ターミナルの背景（palette の bg1）と同じ色の無地の画像。色ごとに別の名前になるので、テーマを変えると別の画像になる
  # Ghostty は色を sRGB で出すので、画像にも macOS の sRGB の色の基準を付ける（付けないと、macOS が別の基準の色と受け取り、ずれて見える）
  wallpaper = pkgs.runCommand "wallpaper-${lib.removePrefix "#" palette.bg1}.png" {
    nativeBuildInputs = [ pkgs.imagemagick ];
  } "magick -size 64x64 'xc:${palette.bg1}' -type TrueColor -profile '/System/Library/ColorSync/Profiles/sRGB Profile.icc' PNG24:$out";
  # テーマを切り替える（`theme 名前`。`theme` だけで一覧）
  # theme.nix を書き換えて rebuild し、tmux・sketchybar・Ghostty に読み込み直させる（Ghostty は SIGUSR2 で読み込み直す）
  # Neovim は開き直すと新しい色になる
  theme-switch = pkgs.writeShellApplication {
    name = "theme";
    text = ''
      dir="$HOME/nix-config"
      current=$(sed -n 's|^import ./themes/\(.*\)\.nix$|\1|p' "$dir/theme.nix")
      list() {
        echo "使えるテーマ（* が今のテーマ）:"
        for f in "$dir"/themes/*.nix; do
          n=$(basename "$f" .nix)
          if [ "$n" = "$current" ]; then echo "  * $n"; else echo "    $n"; fi
        done
      }
      write_theme() {
        printf '%s\nimport ./themes/%s.nix\n' \
          "# 使うテーマ（themes/ の中のファイル名）。\`theme 名前\` で書き換えて rebuild する（\`theme\` だけで一覧）" \
          "$1" >"$dir/theme.nix"
      }
      if [ $# -eq 0 ]; then
        list
        exit 0
      fi
      # 壁紙だけを、このコマンドの作られたときのテーマの色にする（切り替えのあと、新しい theme コマンドから呼ばれる）
      if [ "$1" = "--set-wallpaper" ]; then
        # 半透明のときは壁紙が透けて見えるので、変えない
        if ! grep -q "on = true;" "$dir/transparent.nix"; then
          osascript -e 'tell application "System Events" to tell every desktop to set picture to "${wallpaper}"'
        fi
        exit 0
      fi
      name=$1
      if [ ! -f "$dir/themes/$name.nix" ]; then
        echo "テーマ「''${name}」はありません" >&2
        list >&2
        exit 1
      fi
      write_theme "$name"
      if ! ${lib.getExe config.programs.nh.package} darwin switch "$dir"; then
        echo "rebuild に失敗したので、テーマを「''${current}」に戻しました" >&2
        write_theme "$current"
        exit 1
      fi
      tmux source-file "${config.xdg.configHome}/tmux/tmux.conf" 2>/dev/null || true
      sketchybar --reload 2>/dev/null || true
      pkill -USR2 -x ghostty 2>/dev/null || true
      # Ghostty は読み込み直しても、開いている画面のカーソルの色だけは前のテーマの色のまま残る。
      # 読み込み直しが終わるのを少し待ってから、tmux につながっている画面に「カーソルの色を設定の色に戻して」（OSC 112）を送る
      sleep 0.5
      for client in $(tmux list-clients -F '#{client_name}' 2>/dev/null); do
        printf '\033]112\007' >"$client" 2>/dev/null || true
      done
      # 壁紙を、新しいテーマのターミナルの背景と同じ色の無地にする（新しくできた theme コマンドに入っている画像を使う）
      "$(command -v theme)" --set-wallpaper || true
      echo "テーマを「''${name}」にしました。Neovim は開き直すと新しい色になります"
    '';
  };
  # Claude Code の状態を、いまいる tmux のパネルに記録する（Claude Code の hooks から呼ばれる。~/.claude/settings.json）
  # working: 作業中 / waiting: 返事待ち / idle: 指示待ち / clear: 終わった。tmux のバーの ● の色になる
  claude-tmux = pkgs.writeShellApplication {
    name = "claude-tmux";
    text = ''
      pane=''${TMUX_PANE:-}
      # 裏で動く Claude Code は自分のパネルを知らない。画面側のプロセスの端末（tty）と同じパネルを探す
      if [ -z "$pane" ]; then
        panes=$(tmux list-panes -a -F '#{pane_tty} #{pane_id}' 2>/dev/null) || exit 0
        pane_of() { awk -v t="/dev/$1" '$1 == t { print $2 }' <<<"$panes"; }
        # 会話の番号（hooks は標準入力の JSON でも渡してくる）の頭で、つながっている「claude attach 番号」を探す
        id=''${CLAUDE_CODE_SESSION_ID:-}
        if [ -z "$id" ] && [ ! -t 0 ]; then
          id=$(sed -n 's/.*"session_id" *: *"\([^"]*\)".*/\1/p' | head -n 1)
        fi
        if [ -n "$id" ]; then
          tty=$(/bin/ps -axo tty=,command= | awk -v a="claude attach ''${id:0:8}" 'index($0, a) && !/awk/ { print $1; exit }')
          [ -z "$tty" ] || pane=$(pane_of "$tty")
        fi
        # 見つからなければ、親のプロセスをたどる
        pid=$PPID
        while [ -z "$pane" ] && [ -n "$pid" ] && [ "$pid" -gt 1 ]; do
          read -r parent tty <<<"$(/bin/ps -o ppid=,tty= -p "$pid")"
          pane=$(pane_of "$tty")
          pid=$parent
        done
      fi
      [ -n "$pane" ] || exit 0
      case "''${1:-}" in
        working | waiting | idle) tmux set -p -t "$pane" @claude "$1" ;;
        clear) tmux set -p -u -t "$pane" @claude ;;
        *) exit 1 ;;
      esac
      # バーは1秒ごとにしか書き換わらないので、つながっている画面のバーをすぐ書き換えさせる
      tmux list-clients -F '#{client_name}' | while read -r client; do
        tmux refresh-client -S -t "$client" || true
      done
    '';
  };
  # "#rrggbb" を、ターミナルの色の指定（r;g;b）にする
  rgb =
    hex:
    lib.concatMapStringsSep ";" (i: toString (lib.fromHexString (builtins.substring i 2 hex))) [
      1
      3
      5
    ];
  # tmux のセッションを選んで切り替える（tmux の prefix + g）。よく行くフォルダ（zoxide）を選ぶと、そこで新しいセッションを作る
  sesh-pick = pkgs.writeShellApplication {
    name = "sesh-pick";
    runtimeInputs = [
      pkgs.sesh
      pkgs.fzf
      pkgs.zoxide
    ];
    text = ''
      # 1列目: 名前（sesh に渡す）、2列目: 見せる文字（アイコンと名前と、Claude Code の状態の ●）
      # ● の色は tmux のバーと同じ（赤: 返事待ち / 黄: 作業中 / 緑: 指示待ち。セッションの中でいちばん急ぐもの）
      # （macOS の awk は -v で改行の入った値を受け取れないので、環境変数で渡す）
      states=$(tmux list-panes -a -F '#{session_name}	#{pane_current_command}	#{@claude}' 2>/dev/null || true)
      name=$(
        paste <(sesh list --tmux --zoxide) <(sesh list --tmux --zoxide --icons) | states="$states" awk -F '\t' '
          function color(hex) { return sprintf("\033[38;2;%sm", hex) }
          BEGIN {
            rank["idle"] = 1; rank["working"] = 2; rank["waiting"] = 3
            rgb[1] = "${rgb palette.green}"; rgb[2] = "${rgb palette.yellow}"; rgb[3] = "${rgb palette.red}"
            n = split(ENVIRON["states"], lines, "\n")
            for (i = 1; i <= n; i++) {
              split(lines[i], f, "\t")
              if (f[2] !~ /sh$/ && rank[f[3]] > best[f[1]]) best[f[1]] = rank[f[3]]
            }
          }
          { print $1 "\t" $2 (best[$1] ? " " color(rgb[best[$1]]) "●\033[0m" : "") }
        ' | fzf --ansi --no-sort --layout=reverse --delimiter="\t" --with-nth=2 --prompt="セッション > " | cut -f 1
      ) || exit 0
      [ -n "$name" ] || exit 0
      sesh connect "$name"
    '';
  };
  # フォントを切り替える（`font 名前`。`font` だけで一覧）
  # font.nix を書き換え、今のテーマで theme コマンドを呼ぶ（rebuild と読み込み直し）。失敗したら元に戻す
  font-switch = pkgs.writeShellApplication {
    name = "font";
    text = ''
      dir="$HOME/nix-config"
      file="$dir/font.nix"
      current=$(tail -n 1 "$file" | tr -d '"')
      names="${lib.concatStringsSep " " (lib.attrNames (import ./fonts.nix))}"
      list() {
        echo "使えるフォント（* が今のフォント）:"
        for n in $names; do
          if [ "$n" = "$current" ]; then echo "  * $n"; else echo "    $n"; fi
        done
      }
      if [ $# -eq 0 ]; then
        list
        exit 0
      fi
      name=$1
      case " $names " in
        *" $name "*) ;;
        *)
          echo "フォント「''${name}」はありません" >&2
          list >&2
          exit 1
          ;;
      esac
      if [ "$name" = "$current" ]; then
        echo "もう「''${name}」です"
        exit 0
      fi
      write() {
        printf '%s\n"%s"\n' \
          "# 使うフォント（fonts.nix の名前）。\`font 名前\` で書き換えて rebuild する（\`font\` だけで一覧）" \
          "$1" >"$file"
      }
      write "$name"
      if ! theme "$(sed -n 's|^import ./themes/\(.*\)\.nix$|\1|p' "$dir/theme.nix")"; then
        write "$current"
        echo "フォントを「''${current}」に戻しました" >&2
        exit 1
      fi
      echo "フォントを「''${name}」にしました。Ghostty は Cmd-Q で終了して開き直してください"
    '';
  };
  # ターミナルの半透明を切り替える（`transparent on`・`transparent off`・`transparent 0.8`。`transparent` だけで今の状態）
  # transparent.nix を書き換え、今のテーマで theme コマンドを呼ぶ（rebuild と読み込み直し）。失敗したら元に戻す
  transparent-switch = pkgs.writeShellApplication {
    name = "transparent";
    text = ''
      dir="$HOME/nix-config"
      file="$dir/transparent.nix"
      on=$(sed -n 's/^{ on = \([a-z]*\);.*/\1/p' "$file")
      opacity=$(sed -n 's/.*opacity = "\([0-9.]*\)".*/\1/p' "$file")
      label() { if [ "$1" = true ]; then echo "半透明（$2）"; else echo "不透明"; fi; }
      usage="使い方: transparent on / transparent off / transparent 0.8（0.1〜0.99。1 に近いほど透けない）"
      case "''${1:-}" in
        on) new_on=true new_opacity=$opacity ;;
        off) new_on=false new_opacity=$opacity ;;
        0.[1-9] | 0.[1-9][0-9]) new_on=true new_opacity=$1 ;;
        "")
          echo "今は$(label "$on" "$opacity")です"
          echo "$usage"
          exit 0
          ;;
        *)
          echo "$usage" >&2
          exit 1
          ;;
      esac
      if [ "$new_on $new_opacity" = "$on $opacity" ]; then
        echo "もう$(label "$on" "$opacity")です"
        exit 0
      fi
      write() {
        printf '%s\n%s\n{ on = %s; opacity = "%s"; }\n' \
          "# ターミナルを半透明にするか（on）と、その透け具合（opacity。1 に近いほど透けない）" \
          "# \`transparent on\`・\`transparent off\`・\`transparent 0.8\` で書き換えて rebuild する（\`transparent\` だけで今の状態）" \
          "$1" "$2" >"$file"
      }
      write "$new_on" "$new_opacity"
      if ! theme "$(sed -n 's|^import ./themes/\(.*\)\.nix$|\1|p' "$dir/theme.nix")"; then
        write "$on" "$opacity"
        echo "$(label "$on" "$opacity")に戻しました" >&2
        exit 1
      fi
      echo "$(label "$new_on" "$new_opacity")にしました。Ghostty を Cmd-Q で終了して開き直してください"
      if [ "$new_on" != "$on" ]; then echo "Neovim も開き直してください"; fi
    '';
  };
  # sketchybar の Apple ロゴ・アプリのメニューが使う小さなプログラム（旧設定の helpers/menus。毎回 make していたものを Nix でビルドする）
  sketchybar-menus = pkgs.stdenv.mkDerivation {
    name = "sketchybar-menus";
    src = ./sketchybar/helpers/menus;
    buildPhase = ''
      $CC -std=c99 -O3 -F/System/Library/PrivateFrameworks/ -framework Carbon -framework SkyLight menus.c -o sketchybar-menus
    '';
    installPhase = "install -Dm755 sketchybar-menus $out/bin/sketchybar-menus";
  };
  # sketchybar の CPU・メモリ・通信量の数値を送る常駐プログラム（joncrangle/sketchybar-system-stats）。nixpkgs にないのでビルドする
  # 版は旧環境（Homebrew）で使っていたものと同じ 0.9.0
  sketchybar-system-stats = pkgs.rustPlatform.buildRustPackage {
    pname = "sketchybar-system-stats";
    version = "0.9.0";
    src = pkgs.fetchFromGitHub {
      owner = "joncrangle";
      repo = "sketchybar-system-stats";
      tag = "0.9.0";
      hash = "sha256-UQk4Q5Rs7NFMEsQzcZzj/EHUZ2ryC3gzVopA4I4663U=";
    };
    cargoHash = "sha256-AlMdC1yQGwSn/omF01aRwiJlmjoQoAl+l1cMyjbmQ1E=";
  };
  # ミュージック.app をターミナルから操作する（helmedeiros/amp）。nixpkgs にないのでビルドする
  # 中身は osascript でミュージック.app を動かすだけ（2026-10-12 にソースを確認）。amp が本体、amd は任意の常駐プログラム
  amp = pkgs.buildGoModule {
    pname = "amp";
    version = "0.6.0";
    src = pkgs.fetchFromGitHub {
      owner = "helmedeiros";
      repo = "amp";
      tag = "v0.6.0";
      hash = "sha256-cuMZA3QT+AAxrVumO23BBeVXj8Q5pOKHjIL1zxJaLo0=";
    };
    vendorHash = "sha256-il19j8GN3EOsrJ5CrrkrWPpwl/QfFZLbkNAReqwPRgQ=";
    subPackages = [
      "cmd/amp"
      "cmd/amd"
    ];
    # zsh で Tab を押すとコマンドやプレイリスト名を補完する
    nativeBuildInputs = [ pkgs.installShellFiles ];
    postInstall = ''
      installShellCompletion --cmd amp --zsh <($out/bin/amp completion zsh)
    '';
  };
in
{
  home.username = "hikarusato";
  home.homeDirectory = "/Users/hikarusato";
  home.stateVersion = "26.05";

  # 旧環境（~/.config）と分けるため、Nix 環境の設定はすべて ~/.config-nix に置く
  xdg.enable = true;
  xdg.configHome = "${config.home.homeDirectory}/.config-nix";

  programs.home-manager.enable = true;

  # Claude Code（claude）と uv は自分で ~/.local/bin に入れているので、PATH に足す
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.cargo/bin"
  ];

  # git は ~/.gitconfig（旧環境）も読んでしまうので、Nix 環境では読む先を1つに絞る
  home.sessionVariables.GIT_CONFIG_GLOBAL = "${config.xdg.configHome}/git/config";
  # tmux のサーバーは1ユーザーに1つ（/tmp/tmux-<uid>/default）なので、そのままだと旧環境の tmux に
  # つながってしまう。Nix 環境ではソケットを macOS のユーザー専用一時フォルダ（$TMPDIR）に置いて分ける
  home.sessionVariables.TMUX_TMPDIR = "\${TMPDIR}";

  programs.git = {
    enable = true;
    settings = {
      user.name = "Hikaru Sato";
      user.email = "174260688+hikaru181069@users.noreply.github.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      fetch.prune = true;
      merge.conflictStyle = "zdiff3";
      rerere.enabled = true;
      # GitHub との通信は SSH。~/.ssh/config は旧環境と共有なので触らず、Nix 環境用の設定を指定する
      # UseKeychain は macOS 標準の ssh だけが対応しているので /usr/bin/ssh を使う
      core.sshCommand = "/usr/bin/ssh -F ${config.xdg.configHome}/ssh/config";
      # コミット署名も同じ SSH 鍵で行う（GitHub に Signing key として登録）
      user.signingKey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
      commit.gpgSign = true;
      tag.gpgSign = true;
    };
    ignores = [
      ".DS_Store"
      ".direnv/"
      "result"
      "**/.claude/settings.local.json"
    ];
  };
  # GitHub の CLI。Nix 環境では設定の置き場所が ~/.config-nix に変わり、旧環境の ~/.config/gh を読まないので、ここで用意する
  # トークンはファイルではなく macOS のキーチェーンにあり、ユーザー名を書いておけば旧環境と同じものを使う
  programs.gh = {
    enable = true;
    settings = {
      # git と同じく SSH でつなぐ（clone などで使われる）
      git_protocol = "ssh";
      aliases.co = "pr checkout";
    };
    hosts."github.com" = {
      user = "hikaru181069";
      git_protocol = "ssh";
      users.hikaru181069 = { };
    };
  };

  # 自分の署名を手元で検証するための一覧（git log --show-signature で Good signature と出る）
  xdg.configFile."git/allowed_signers".text =
    "174260688+hikaru181069@users.noreply.github.com namespaces=\"git\" ${builtins.readFile ./keys/id_ed25519.pub}";
  # 鍵のパスフレーズはキーチェーンに保存し、初回に ssh-agent へ読み込む（毎回入力しない）
  xdg.configFile."ssh/config".text = ''
    Host *
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
  '';

  # git diff / log / show の表示を delta で見やすくする（色はテーマ統一の Step 5.5 で合わせる）
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      # 構文の色は bat に最初から入っているテーマ（theme.nix の bat）、追加・削除の背景は palette.nix の差分の色
      syntax-theme = theme.bat;
      plus-style = "syntax ${palette.diff_add}";
      plus-emph-style = "syntax ${palette.diff_add_emph}";
      minus-style = "syntax ${palette.diff_delete}";
      minus-emph-style = "syntax ${palette.diff_delete_emph}";
    };
  };
  # delta は構文の色を bat の配色から取る。テーマ（theme.nix の bat）は、ほとんど bat に最初から入っているもの
  programs.bat = {
    enable = true;
    config.theme = theme.bat;
    # bat に入っていないので足したテーマ（bat/ の中のファイル全部。名前はファイル名から .tmTheme を除いたもの。作り方はファイルの先頭に書いた）
    themes = lib.mapAttrs' (
      file: _:
      lib.nameValuePair (lib.removeSuffix ".tmTheme" file) {
        src = ./bat;
        inherit file;
      }
    ) (builtins.readDir ./bat);
  };
  # rebuild のときに bat がテーマの一覧の控え（キャッシュ）を作る処理は、設定の置き場所（~/.config-nix）を知らないので、
  # ~/.config/bat を見て、足したテーマが入らない控えを作ってしまう。home-manager の処理と同じものに、置き場所（BAT_CONFIG_DIR）を足して置きかえる
  home.activation.batCache = lib.mkForce (
    lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      (
        export XDG_CACHE_HOME=${config.xdg.cacheHome}
        export BAT_CONFIG_DIR=${config.xdg.configHome}/bat
        verboseEcho "Rebuilding bat theme cache"
        cd "${pkgs.emptyDirectory}"
        run ${lib.getExe config.programs.bat.package} cache --build
      )
    ''
  );

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    # EDITOR に vi が含まれると zsh は vi 式の行編集になるので、Emacs 式を明示する
    defaultKeymap = "emacs";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # macOS の既定だと約1000件で古い履歴が消えていくので、大きく取る
    history = {
      size = 100000;
      save = 100000;
      ignoreAllDups = true;
      extended = true;
    };
    # tree コマンドの別名はやめ、ツリー表示は eza にまとめる
    shellAliases = {
      ll = "eza -lah";
      lt = "eza --tree --level=2";
      lt3 = "eza --tree --level=3";
      lta = "eza --tree --level=2 -a";
      # Nix の設定（home.nix・darwin.nix）を Mac に適用する。nh は進み具合と、変わったものの一覧を出す（中で sudo を使う）
      # 反映したあと、読み込み済みの目印を消してシェルを入れ替え、新しい設定（PATH など）をすぐ使えるようにする
      rebuild = "nh darwin switch ~/nix-config && unset __HM_SESS_VARS_SOURCED __HM_ZSH_SESS_VARS_SOURCED __NIX_DARWIN_SET_ENVIRONMENT_DONE && exec zsh";
      # 東京から見える今の星空を、色付き・星座の線付きで（astroterm は設定ファイルがないのでオプションで指定する）
      astroterm = "astroterm --city Tokyo --color --constellations --unicode";
    };
    initContent = lib.mkMerge [
      # fzf-tab: Tab の補完の候補を fzf で絞り込む。補完の準備（compinit）のあと、autosuggestions より前に読む
      (lib.mkOrder 600 ''
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        # 候補の一覧は fzf-tab に任せる。色は fzf の設定（テーマの色）を使う
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:*' use-fzf-default-opts yes
        # cd の候補では、フォルダの中身を横に出す
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=always $realpath'
      '')
      # Ctrl-X Ctrl-E で、入力中のコマンドをエディタで編集する
      ''
        autoload -Uz edit-command-line
        zle -N edit-command-line
        bindkey '^X^E' edit-command-line
        # キーチェーンに保存したパスフレーズで SSH 鍵を ssh-agent に読み込む（コミット署名に必要）
        /usr/bin/ssh-add --apple-load-keychain -q 2>/dev/null
      ''
    ];
  };

  # 時刻やホスト名は tmux / sketchybar に任せ、プロンプトには作業に要るものだけ出す
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";
      # 色は palette.nix から（どの部品に何色を使うかは starship の既定と同じ）
      directory.style = "bold ${palette.cyan}";
      git_branch.style = "bold ${palette.magenta}";
      git_status.style = "bold ${palette.red}";
      nix_shell.style = "bold ${palette.blue}";
      cmd_duration.style = "bold ${palette.yellow}";
      character = {
        success_symbol = "[❯](bold ${palette.green})";
        error_symbol = "[❯](bold ${palette.red})";
      };
    };
  };

  # ls を eza に置き換える（ls / ll / lt などの別名は eza が用意し、上で一部上書き）
  programs.eza = {
    enable = true;
    icons = "auto";
  };
  # アイコンの絵と色だけを替える（ファイル名などの色は eza のまま）
  home.sessionVariables.EZA_CONFIG_DIR = "${config.xdg.configHome}/eza";
  xdg.configFile."eza/theme.yml".text = builtins.toJSON (
    lib.mapAttrs (
      _:
      lib.mapAttrs (
        _: i: {
          icon = {
            glyph = i.icon;
            style.foreground = i.color;
          };
        }
      )
    ) { inherit (fileIcons) filenames extensions; }
  );
  # Ctrl-R で履歴検索、Ctrl-T でファイル検索、Alt-C でディレクトリ移動
  # ファイル一覧は fd で作る（.gitignore を尊重し、隠しファイルも含める）
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
    fileWidget.command = "fd --type f --hidden --exclude .git";
    changeDirWidget.command = "fd --type d --hidden --exclude .git";
    # Ctrl-R（履歴検索）は atuin に任せる（空にすると、fzf は Ctrl-R を使わない）
    historyWidget.command = "";
    # 背景は端末のまま。選んでいる行は Neovim の選択範囲と同じ色
    colors = {
      fg = palette.fg2;
      "fg+" = palette.fg1;
      "bg+" = palette.sel0;
      hl = palette.blue;
      "hl+" = palette.cyan;
      info = palette.yellow;
      prompt = palette.cyan;
      pointer = palette.magenta;
      marker = palette.green;
      spinner = palette.magenta;
      header = palette.comment;
      border = palette.bg4;
    };
  };
  # 履歴検索（Ctrl-R）を atuin にする。フォルダ・セッションごとに探せて、日時・かかった時間・成功したかも残る
  # fzf の Ctrl-T・Alt-C はそのまま。上矢印は今までどおり「1つ前のコマンド」にする
  # 記録は手元（~/.local/share/atuin）だけ。ほかの Mac との共有と、新しい版の確認は切る
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = false;
      sync_frequency = "0";
      update_check = false;
      style = "compact";
      inline_height = 20;
    };
  };

  # 検索ツール。Neovim の telescope（live_grep / find_files）からも使う
  programs.ripgrep = {
    enable = true;
    # 小文字だけなら大文字小文字を区別しない
    arguments = [ "--smart-case" ];
  };
  programs.fd.enable = true;
  programs.jq.enable = true;

  # CPU・メモリ・プロセスを見る画面
  programs.btop = {
    enable = true;
    settings = {
      # btop に最初から入っているテーマ（theme.nix の btop）。背景は塗らずにターミナルの色（palette.nix の bg1）を使う
      color_theme = theme.btop;
      theme_background = false;
      # Neovim と同じく hjkl で動く
      vim_keys = true;
    };
  };
  # OS・PC の情報をロゴと一緒に表示する。まずは初期設定のまま
  programs.fastfetch.enable = true;

  # Docker のコンテナ・ログ・イメージを画面で見て操作する
  programs.lazydocker = {
    enable = true;
    # 色は lazygit と同じ。いま操作している枠は青、選んでいる行は Neovim の選択範囲と同じ色
    settings.gui.theme = {
      activeBorderColor = [
        palette.blue
        "bold"
      ];
      inactiveBorderColor = [ palette.bg4 ];
      selectedLineBgColor = [ palette.sel0 ];
      optionsTextColor = [ palette.blue ];
    };
  };
  # Kubernetes（kind の coffee-app）を画面で見て操作する
  programs.k9s = {
    enable = true;
  }
  # k9s に最初から入っているスキン（theme.nix の k9s）。入っていないテーマ（null）は、k9s の標準の見た目
  // lib.optionalAttrs (theme.k9s != null) {
    skins.${theme.k9s} = "${pkgs.k9s}/share/k9s/skins/${theme.k9s}.yaml";
    settings.k9s.ui.skin = theme.k9s;
  };
  # 音に合わせて棒グラフが動く（遊び）。ミュージック.app などの Mac から出ている音に反応する
  # cava 1.0 は macOS 14.2 からの公式の仕組み（Core Audio tap）に対応しているので、BlackHole などの仮想の機器は要らない
  # 初回は「画面と音声の収録」の許可が要る（Ghostty に対して）
  programs.cava = {
    enable = true;
    settings.input = {
      method = "coreaudio";
      source = "tap";
    };
    settings.color = {
      # 下から上へ Gruvbox の 水色 → 緑 → 黄 → オレンジ → 赤
      gradient = 1;
      gradient_count = 5;
      gradient_color_1 = "'${palette.cyan}'";
      gradient_color_2 = "'${palette.green}'";
      gradient_color_3 = "'${palette.yellow}'";
      gradient_color_4 = "'${palette.orange}'";
      gradient_color_5 = "'${palette.red}'";
    };
  };
  # ターミナルで動くファイル操作の画面。`y` で開くと、閉じたときにそのフォルダへ移動する
  # rebuild の進み具合と、何が変わったかを見やすく出す（nh darwin switch。flake の場所は覚えさせてある）
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/nix-config";
  };
  programs.yazi = {
    enable = true;
    theme.icon =
      let
        rules = lib.mapAttrsToList (
          name: i: {
            inherit name;
            text = i.icon;
            fg = i.color;
          }
        );
      in
      {
        prepend_files = rules fileIcons.filenames;
        prepend_exts = rules fileIcons.extensions;
      };
  };
  # コマンドの使い方を、よく使う例だけ短く見せる（コマンドは tldr）。説明はネットから取ってくるので自動で更新する
  # home-manager の settings は macOS だと ~/Library/Application Support に書くが、tealdeer は XDG_CONFIG_HOME（~/.config-nix）を
  # 優先して読むので、設定ファイルは自分で ~/.config-nix に置く
  programs.tealdeer.enable = true;
  xdg.configFile."tealdeer/config.toml".text = ''
    [updates]
    auto_update = true
  '';

  # Git の操作画面。diff は delta で表示する
  programs.lazygit = {
    enable = true;
    settings = {
      git.diffRenderers = [ { command = "delta --paging=never"; } ];
      # 色は palette.nix から。いま操作している枠は青、選んでいる行は Neovim の選択範囲と同じ色
      # ファイルの種類のアイコンを出す（絵と色は Neovim と同じ。拡張子には点を付けて書く）
      gui.nerdFontsVersion = "3";
      gui.customIcons = {
        filenames = fileIcons.filenames;
        extensions = lib.mapAttrs' (name: lib.nameValuePair ".${name}") fileIcons.extensions;
      };
      gui.theme = {
        activeBorderColor = [
          palette.blue
          "bold"
        ];
        inactiveBorderColor = [ palette.bg4 ];
        searchingActiveBorderColor = [
          palette.yellow
          "bold"
        ];
        optionsTextColor = [ palette.blue ];
        selectedLineBgColor = [ palette.sel0 ];
        inactiveViewSelectedLineBgColor = [ palette.bg2 ];
        cherryPickedCommitFgColor = [ palette.blue ];
        cherryPickedCommitBgColor = [ palette.sel1 ];
        markedBaseCommitFgColor = [ palette.blue ];
        markedBaseCommitBgColor = [ palette.yellow ];
        unstagedChangesColor = [ palette.red ];
        defaultFgColor = [ palette.fg1 ];
      };
    };
  };

  # tmux（~/.config/tmux から引き継ぎ）。ペイン分割とセッションは tmux、ターミナルは描画と IME だけを担当
  programs.tmux = {
    enable = true;
    # tmux は ~/.tmux.conf・$XDG_CONFIG_HOME/tmux/tmux.conf・~/.config/tmux/tmux.conf のうち、
    # あるものを全部読む。旧環境の ~/.config/tmux/tmux.conf まで読まれないよう、-f で1つに絞る
    # また、プロセス名を nix-tmux にする（下の continuum の説明を参照）
    package = pkgs.symlinkJoin {
      name = "tmux";
      paths = [ pkgs.tmux ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/tmux --argv0 nix-tmux --add-flags "-f ${config.xdg.configHome}/tmux/tmux.conf"
      '';
    };
    prefix = "C-a";
    terminal = "tmux-256color";
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    # prefix + hjkl でペイン移動、prefix + HJKL でサイズ変更（5 ずつ）
    customPaneNavigationAndResize = true;
    resizeAmount = 5;
    # 旧環境で tmux-sensible が有効にしていたもののうち、効いていたものだけ残す
    sensibleOnTop = false;
    focusEvents = true;
    aggressiveResize = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      # C-hjkl で Neovim の分割と tmux のペインを区別なく移動
      vim-tmux-navigator
      {
        plugin = resurrect;
        # 旧環境の保存データ（~/.local/share/tmux/resurrect）と混ざらないよう別の場所に保存する
        extraConfig = "set -g @resurrect-dir '${config.xdg.dataHome}/tmux/resurrect-nix'";
      }
      {
        # 30 分ごとにセッションを保存し、tmux の起動時に復元する
        # continuum は「tmux という名前のプロセスがほかにあれば自動保存しない」ので、旧環境の tmux と
        # 同時に動かすと、どちらも保存しなくなる。Nix 側はプロセス名を nix-tmux にし、数えるのも nix-tmux だけにする
        plugin = continuum.overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            substituteInPlace $target/scripts/helpers.sh \
              --replace-fail '\grep "^tmux"' '\grep "^nix-tmux"' \
              --replace-fail '\grep -v "^tmux source"' '\grep -v "^nix-tmux source"'
          '';
        });
        extraConfig = ''
          set -g @continuum-save-interval '30'
          set -g @continuum-restore 'on'
        '';
      }
    ];
  };
  # 自分の設定は、プラグインより前に読ませる。continuum は読み込み時に status-right へ自動保存の処理を足すので、
  # status-right をプラグインより後で設定すると自動保存が止まってしまう
  xdg.configFile."tmux/tmux.conf".text = lib.mkOrder 800 (
    let
      p = palette;
      # Nerd Font の区切り記号（右向きの三角、右向きの線、左向きの三角）
      # 見えない文字なので、直接書くと抜け落ちやすい。文字コードで指定する
      r = builtins.fromJSON ''"\ue0b0"'';
      rThin = builtins.fromJSON ''"\ue0b1"'';
      l = builtins.fromJSON ''"\ue0b2"'';
      # Claude Code の状態（claude-tmux が記録した @claude）。ウィンドウの中のパネルを見て、いちばん急ぐものの色の ● を出す
      # 赤: 返事待ち / 黄: 作業中 / 緑: 指示待ち。シェルに戻っているパネルの古い記録は見ない
      claudePanes = "#{P:#{?#{m:*sh,#{pane_current_command}},,#{@claude}}}";
      claudeDot =
        "#{?#{m:*waiting*,${claudePanes}},#[fg=${p.red}]● ,"
        + "#{?#{m:*working*,${claudePanes}},#[fg=${p.yellow}]● ,"
        + "#{?#{m:*idle*,${claudePanes}},#[fg=${p.green}]● ,}}}";
      # 返事待ちのパネルの数だけ赤い ●（ほかのセッションも含む）
      claudeWaiting = "#[fg=${p.red}]#{S:#{W:#{P:#{?#{m:*sh,#{pane_current_command}},,#{?#{m:waiting,#{@claude}},● ,}}}}}";
      # ユーザー名のブロックと右端の三角の色。テーマのファイルに tmuxUser があれば、その色にする
      tmuxUser =
        theme.tmuxUser or {
          block = p.fg2;
          arrow = p.fg1;
        };
      # 右端の虹色の三角。前の色の上に次の色の三角を重ねていく
      # 色はテーマのファイルの rainbow（6色）で決められる。決めていなければ、赤 → オレンジ → 黄 → 緑 → 水色 → 青
      rainbow = [
        p.bg0
      ]
      ++ (
        theme.rainbow or [
          p.red
          p.orange
          p.yellow
          p.green
          p.cyan
          p.blue
        ]
      )
      ++ [ p.bg0 ];
      rainbowArrows = lib.concatStrings (
        lib.zipListsWith (bg: fg: "#[fg=${fg},bg=${bg}]${l}") (lib.init rainbow) (lib.tail rainbow)
      );
    in
    ''
      # ペインの zsh に ZDOTDIR を渡さない。渡すと zsh は ~/.zshenv を飛ばして
      # ~/.config-nix/zsh/.zshenv を直接読むので、新しいタブと同じ順番で読み込ませる
      set-environment -gu ZDOTDIR
      # 「設定は読み込み済み」という目印も渡さない。tmux を起動したシェルの目印が残っていると、
      # ペインの zsh が home-manager・nix-darwin の設定（PATH の ~/.local/bin、NVIM_APPNAME など）を読み飛ばし、
      # tmux を起動した後に足した設定が反映されない（claude が見つからない・nvim が初期状態になる）
      set-environment -gu __HM_SESS_VARS_SOURCED
      set-environment -gu __HM_ZSH_SESS_VARS_SOURCED
      set-environment -gu __NIX_DARWIN_SET_ENVIRONMENT_DONE

      # コマンド入力（prefix + :）の行編集は Emacs 式（tmux-sensible と同じ）
      set -g status-keys emacs
      set -g display-time 4000
      set -s set-clipboard on
      set -g renumber-windows on
      set -as terminal-features ",*:RGB"
      set -as terminal-features ",*:usstyle"

      bind r source-file ${config.xdg.configHome}/tmux/tmux.conf \; display-message "tmux config reloaded"

      unbind %
      unbind '"'
      bind - split-window -v
      bind | split-window -h
      bind m resize-pane -Z
      # セッションを fzf で選んで切り替える
      bind g display-popup -E -w 60% -h 60% ${lib.getExe sesh-pick}

      # コピーモード: v で選択開始、y か Enter でクリップボードへ
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe "pbcopy"
      bind -T copy-mode-vi Enter send-keys -X copy-pipe "pbcopy"
      bind -T copy-mode-vi Escape send-keys -X cancel

      # ステータスライン（見た目は旧環境のまま、色だけ palette.nix のものに置き換え）
      set -g mode-style "fg=${p.fg1},bg=${p.sel0}"
      set -g message-style "fg=${p.fg2},bg=${p.bg0}"
      set -g message-command-style "fg=${p.fg2},bg=${p.bg0}"
      # パネルの区切りは線だけに色を付け、背景は塗らない（不透明でも半透明でも Ghostty の背景と同じになる）
      # 選んでいないパネルの間の線は描かない（hidden）。背景と同じ色で隠すと、半透明のときに黒い線として見えてしまう
      set -g pane-border-style "fg=${p.bg1},bg=default,hidden"
      set -g pane-active-border-style "fg=${theme.tmuxPaneBorder or p.bg3},bg=default"

      set -g status on
      set -g status-interval 1
      set -g status-justify left
      set -g status-style "fg=${p.fg2},bg=${p.bg0}"
      set -g status-left-length 100
      set -g status-right-length 100
      set -g status-left-style NONE
      set -g status-right-style NONE

      # 左: セッション名（prefix を押している間は色が変わる）とユーザー名
      # 区切りの三角の一部は、旧環境と同じくブロックより1段明るい色にする（prefix 中の三角・ユーザー名の右端）
      set -g status-left "#[fg=#{?client_prefix,${p.bg0},${p.comment}},bg=#{?client_prefix,${p.cyan},${p.bg0}},bold] #S ${claudeWaiting}#[fg=#{?client_prefix,${p.cyan_light},${p.bg0}},bg=${tmuxUser.block},nobold]${r}#[fg=${p.bg0},bg=${tmuxUser.block},bold] #(whoami) #[fg=${tmuxUser.arrow},bg=${p.bg0},nobold]${r}"
      # 右: 虹色の三角とホスト名
      set -g status-right "${rainbowArrows}#[fg=${p.fg3},bg=${p.bg0},bold] #h "

      # ウィンドウ一覧: 番号とディレクトリ名
      setw -g window-status-separator ""
      setw -g window-status-style "fg=${p.comment},bg=${p.bg0}"
      setw -g window-status-activity-style "underscore,fg=${p.comment},bg=${p.bg0}"
      setw -g window-status-format "#[fg=${p.bg0},bg=${p.bg0}]${r}#[default] #I ${rThin} #{b:pane_current_path} ${claudeDot}#[fg=${p.bg0},bg=${p.bg0}]${r}"
      # 選んでいるウィンドウ: 番号の右の三角と右端の三角は、旧環境と同じくブロックより1段明るい色
      setw -g window-status-current-format "#[fg=${p.bg0},bg=${p.fg1}]${r}#[fg=${p.fg3},bg=${p.fg1}] #I #[fg=${p.fg0},bg=${p.fg3}]${r} #{b:pane_current_path} ${claudeDot}#[fg=${p.comment},bg=${p.bg0}]${r}"
    ''
  );
  # プロジェクトのフォルダに入ると、その .envrc（flake.nix の devShell）の環境に自動で切り替わる
  # nix-direnv は devShell を保存しておき、2回目からすぐ読み込む（ガベージコレクションでも消さない）
  # 旧環境には direnv がないので、プロジェクトに .envrc を置いても旧環境の動きは変わらない
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # 切り替えのたびに出る環境変数の一覧は長いので出さない
    config.global.hide_env_diff = true;
  };

  # z <ディレクトリ名の一部> で、よく行くディレクトリへ移動
  programs.zoxide.enable = true;

  # Neovim。設定（Lua）は ~/nix-config/nvim に置き、リンクして編集がすぐ反映されるようにする
  programs.neovim = {
    enable = true;
    # EDITOR / VISUAL を nvim にする（Ctrl-X Ctrl-E や git のコミットメッセージで使われる）
    defaultEditor = true;
    # home-manager が作る設定は init.lua に書かず、起動時に読ませる（init.lua は自分の設定だけにする）
    sideloadInitLua = true;
    # 構文解析（色付けなど）。パーサはコンパイル済みのものを nixpkgs から取る（Mason や実行時のビルドは使わない）
    # nvim-treesitter のクエリはパーサの版と合わせる必要があるので、これだけは vim.pack ではなく Nix で入れる
    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        p: with p; [
          bash
          css
          html
          javascript
          json
          lua
          markdown
          markdown_inline
          nix
          python
          regex # noice がコマンド入力の色付けに使う
          tsx
          typescript
          vim
          vimdoc
        ]
      ))
      # 補完。あいまい検索の部品（Rust）のコンパイル済みのものが要るので、vim.pack ではなく Nix で入れる
      pkgs.vimPlugins.blink-cmp
    ];
    # 言語サーバー（LSP）。Mason は使わず nixpkgs から入れる。Neovim の中だけで見え、シェルの PATH には出ない
    extraPackages = with pkgs; [
      vtsls # TypeScript / JavaScript（VS Code と同じ中身）
      vscode-langservers-extracted # HTML・CSS・JSON・ESLint
      tailwindcss-language-server
      emmet-language-server
      basedpyright # Python の型チェック・補完
      ruff # Python の lint・整形
      lua-language-server
      nixd # Nix（この設定を書くため）
      nixfmt # Nix の整形（nixd が保存のときに使う）
      # 整形（conform.nvim が使う）。プロジェクトの node_modules に prettier があれば、そちらが優先される
      prettier
      stylua
    ];
  };
  # palette.nix の色を Neovim の Lua から require("palette") で読めるようにする（色の定義を1か所に保つ）
  xdg.dataFile."nvim-nix/site/lua/palette.lua".text = "return " + lib.generators.toLua { } palette;
  # Neovim で使うテーマの名前（nvim/init.lua が読む）
  xdg.dataFile."nvim-nix/site/lua/theme.lua".text = "return " + lib.generators.toLua { } {
    inherit (theme) nvim;
    inherit transparent;
  };
  # Nix で入れたプラグインは、データ置き場の site/pack/hm へのリンクから読み込まれる。
  # home-manager は ~/.local/share/nvim（旧環境の置き場）に作るので、NVIM_APPNAME に合わせた場所に移す
  xdg.dataFile."nvim/site/pack/hm".enable = lib.mkForce false;
  xdg.dataFile."nvim-nix/site/pack/hm".source = config.xdg.dataFile."nvim/site/pack/hm".source;
  # 設定・データ・状態・キャッシュをまとめて旧環境（~/.config/nvim, ~/.local/share/nvim など）と分ける
  home.sessionVariables.NVIM_APPNAME = "nvim-nix";
  xdg.configFile."nvim-nix".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/nvim";

  # ウィンドウ管理（yabai）とキー操作（skhd）。デスクトップは1つなので、旧環境・Nix 環境どちらのタブでもこれが動く
  # 起動は launchd（ログイン時に自動で起動し、落ちたら起こし直す）。Homebrew の起動設定は止めてある（docs/log.md 参照）
  # どちらも「アクセシビリティ」の許可が要る。Nix で版が上がると本体の場所が変わるので、そのたびに許可し直す
  home.packages = [
    pkgs.yabai
    # sketchybar でアプリのアイコンを出すフォント（~/Library/Fonts/HomeManager に入る）
    pkgs.sketchybar-app-font
    # ターミナル（Ghostty）のフォント
    pkgs.nerd-fonts.jetbrains-mono
    # font コマンドで選べるフォント（fonts.nix。Maple Mono は cask で入れている）
    pkgs.nerd-fonts.blex-mono
    pkgs.nerd-fonts.lilex
    # テーマを切り替える（theme 名前）
    theme-switch
    # tmux のセッションを選んで切り替える（prefix + g は sesh-pick を使う）
    pkgs.sesh
    # Claude Code の状態を tmux に伝える（hooks から呼ぶ）
    claude-tmux
    # フォントを切り替える（font 名前）
    font-switch
    # 半透明を切り替える（transparent on / off / 0.8）
    transparent-switch
    # よく打つコマンドに名前を付けて呼ぶ（プロジェクトの justfile に書く。Makefile の代わり）
    pkgs.just
    # テトリス風の落ちものパズル（tetris で起動）
    # そのままだと、メニューで Enter を押すと trace trap で落ちる。設定をメモするとき、入れ物の最後の4文字の欄（tp_key[4]）に
    # 長い名前を書く昔の C の書き方で、メモリは足りているのに、文字列のはみ出しの見張り（fortify）が勘違いして止めるため
    # Nix の指定だけでなく macOS の開発キットも見張りを付けるので、-D_FORTIFY_SOURCE=0 でも外す
    (pkgs.vitetris.overrideAttrs (old: {
      hardeningDisable = [ "fortify" ];
      env = (old.env or { }) // {
        NIX_CFLAGS_COMPILE = "-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0";
      };
    }))
    # ping の応答時間をグラフで見る
    pkgs.gping
    # どのフォルダが容量を食っているかを見る
    pkgs.dust
    # Markdown をターミナルで読む
    pkgs.glow
    # ls を sl と打ち間違えると SL が走る（遊び）
    pkgs.sl
    # 忙しく作業しているふりをする（遊び）。hollywood は macOS で半分以上の画面が動かないので、こちらにした
    pkgs.genact
    # ミュージック.app をターミナルから操作する（定義は上の let の中）
    amp
    # API を試す画面（ターミナル版の Postman のようなもの）
    pkgs.posting
    # 今見える星空を描く（遊び）。オプションは zsh のエイリアスで指定
    pkgs.astroterm
    # 英語のタイピング練習（時間制・単語数制などのモード、記録も残る）
    pkgs.typioca
    # Homebrew から移したもの（2026-10-13）
    # coffee-app の Kubernetes（kind のクラスタ）
    pkgs.kind
    # PDF を読む道具（Claude Code が PDF を読むときや、yazi のプレビューで使う）
    pkgs.poppler-utils
    # 画像を変換する道具（yazi のプレビューなどで使う）
    pkgs.imagemagick
    # git の履歴を書き換える道具（いざというとき用）
    pkgs.git-filter-repo
    # 入力ソース（日本語・英字）をコマンドで切り替える。Neovim で編集モードを抜けたときに英字へ戻すのに使う（nvim/init.lua）
    pkgs.macism
    # ターミナルで使う AI のコーディング道具（メインは Claude Code。試しに使う用）
    pkgs.opencode
  ];
  # ユーザーの世代（~/.local/state/nix/profiles）の掃除。Mac 全体の掃除（darwin.nix の nix.gc）は root で動き、ここまで届かない
  # home-manager の nix.gc は Mac だと options を1つの引数で渡してしまい、nix-collect-garbage が受け付けないので、自分で書く
  # Mac 全体の掃除（日曜 3:15）より先に動かす
  launchd.agents.nix-gc-user = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.nix}/bin/nix-collect-garbage"
        "--delete-older-than"
        "14d"
      ];
      StartCalendarInterval = [
        {
          Weekday = 7;
          Hour = 3;
          Minute = 0;
        }
      ];
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/nix-gc-user.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/nix-gc-user.log";
    };
  };
  launchd.agents.yabai = {
    enable = true;
    config = {
      # -c で設定を指定する（指定しないと旧環境の ~/.config/yabai/yabairc を読む）
      ProgramArguments = [
        (lib.getExe pkgs.yabai)
        "-c"
        "${config.home.homeDirectory}/nix-config/yabai/yabairc"
      ];
      # yabairc の中で yabai コマンドを呼ぶので、Nix のコマンドが見えるようにする
      EnvironmentVariables.PATH = "${config.home.profileDirectory}/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      ProcessType = "Interactive";
      Nice = -20;
      RunAtLoad = true;
      # 落ちたときだけ起こし直す（Homebrew の起動設定と同じ）
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/yabai/yabai.out.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/yabai/yabai.err.log";
    };
  };
  services.skhd.enable = true;
  launchd.agents.skhd.config = {
    ProgramArguments = lib.mkForce [
      (lib.getExe pkgs.skhd)
      "-c"
      "${config.home.homeDirectory}/nix-config/skhd/skhdrc"
    ];
    # キーに割り当てたコマンドは $SHELL で動く。zsh だと ~/.zshenv などまで読んで遅くなるので、sh にする
    EnvironmentVariables = {
      PATH = "${config.home.profileDirectory}/bin:/usr/bin:/bin:/usr/sbin:/sbin";
      SHELL = "/bin/sh";
    };
  };

  # メニューバーの代わりのバー（sketchybar）。設定は ~/nix-config/sketchybar（Lua）で、ゼロから作り直したもの
  # yabai と同じく、デスクトップは1つなので旧環境・Nix 環境どちらでもこれが動く。Homebrew の起動設定は止めてある
  programs.sketchybar = {
    enable = true;
    configType = "lua";
    # スペースを押したときの yabai、アプリのメニューのプログラム、メニューを出すスクリプトが使う jq
    extraPackages = [
      pkgs.yabai
      sketchybar-menus
      pkgs.jq
      # 音量を押したときの、音の出力先の一覧と切り替え
      pkgs.switchaudio-osx
    ];
  };
  # -c ではなく --config で設定を指定する（指定しないと旧環境の ~/.config/sketchybar を読む）
  launchd.agents.sketchybar.config.Program = lib.mkForce null;
  launchd.agents.sketchybar.config.ProgramArguments = [
    (lib.getExe config.programs.sketchybar.finalPackage)
    "--config"
    "${config.home.homeDirectory}/nix-config/sketchybar/sketchybarrc"
  ];
  # sketchybar に CPU・メモリ・通信量の数値を送る常駐プログラム。引数は旧環境の起動設定（com.sketchybar.stats-provider）と同じ
  # sketchybar を読み込み直しても止まらないよう、sketchybar の中からではなく launchd で起動する（旧設定と同じ考え方）
  launchd.agents.sketchybar-stats = {
    enable = true;
    config = {
      ProgramArguments = [
        "${sketchybar-system-stats}/bin/stats_provider"
        "--cpu"
        "usage"
        "--memory"
        "ram_usage"
        "--network"
        "en0"
        "--interval"
        "1"
        "--no-units"
      ];
      ProcessType = "Interactive";
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/sketchybar/stats.out.log";
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/sketchybar/stats.err.log";
    };
  };

  # 色（palette.nix）と、アプリ名からアイコンを引く表（アイコンのフォントと同じパッケージのもの）を置く
  # テーマのファイルに frontApp があれば、今のアプリの名前とアイコンの色にする（sketchybar/items/front_app）
  xdg.configFile."sketchybar/palette.lua".text =
    "return "
    + lib.generators.toLua { } (
      palette // lib.optionalAttrs (theme ? frontApp) { front_app = theme.frontApp; }
    );
  # 文字のフォント（sketchybar/settings.lua が読む）
  xdg.configFile."sketchybar/font.lua".text = "return " + lib.generators.toLua { } font;
  # 右側の区切りの画像（sketchybar/items/init.lua）。テーマの fg3 の色で作る
  xdg.configFile."sketchybar/sep_thin_left.png".source =
    pkgs.runCommand "sep-thin-left.png" { nativeBuildInputs = [ pkgs.imagemagick ]; }
      "magick -size 22x50 xc:none -fill none -stroke '${palette.fg3}' -strokewidth 2 -draw 'polyline 21,-1 1,25 21,51' PNG32:$out";
  xdg.configFile."sketchybar/icon_map.lua".source =
    "${pkgs.sketchybar-app-font}/lib/sketchybar-app-font/icon_map.lua";

  # 本体は /Applications の Ghostty.app（cask）を使い、設定だけ管理する。中身は wezterm.lua から引き継ぎ
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      # 英字は font コマンドで選んだもの（fonts.nix）。日本語は Maple Mono CN に任せる
      # 行の高さがどのフォントでも 49px になるよう、足りない分を足す（カーソルも同じだけ高くする）
      font-family = [
        font.family
        "Maple Mono NF CN"
      ];
      adjust-cell-height = font.adjust;
      adjust-cursor-height = font.adjust;
      font-size = 18.5;
      window-width = 130;
      window-height = 38;
      window-padding-x = 10;
      # 余白を、隣のマスの背景の色で塗る（tmux のステータスバーの行は、左右の余白もバーの色になる）
      # extend だと、三角などの記号がある行では上下に広がらず、Neovim のタブの行と sketchybar の間に隙間が見えるので、必ず広げる
      window-padding-color = "extend-always";
      # 下は 0（tmux のステータスバーをウィンドウのいちばん下に置く）
      # 上は 4: 全画面の高さのウィンドウ（2262px、1行 49px × 46行）で、行の高さで割り切れない余りが下に残らないようにした値
      window-padding-y = "4,0";
      # 枠をなくして、ウィンドウの四隅を角にする（hidden はタイトルバーだけ消えて、角は丸いまま）。Ghostty のタブは使えなくなるが、tmux を使っているので困らない
      window-decoration = "none";
      macos-titlebar-style = "hidden";
      # ウィンドウの影を消す（影と一緒に付く、まわりの細い線も消える）
      macos-window-shadow = false;
      scrollbar = "never";
      # Cmd-U: 半透明と不透明を、そのウィンドウだけその場で切り替える（開き直すと半透明に戻る。transparent off のときは何も起きない）
      keybind = [ "super+u=toggle_background_opacity" ];
      # 文字を打っている間はマウスの矢印を隠す（マウスを動かすとまた出る）
      mouse-hide-while-typing = true;
    }
    # 高さを変えて下に余りが出たとき、tmux のバーの色が伸びないよう、余りを背景色で塗る（ghostty/padding.glsl）
    # 半透明のときは、背景と同じ透け具合で塗る
    // {
      custom-shader = "${pkgs.writeText "padding.glsl" (
        builtins.replaceStrings
          [ "opacity = 1.0" ]
          [ "opacity = ${if transparent then backgroundOpacity else "1.0"}" ]
          (builtins.readFile ./ghostty/padding.glsl)
      )}";
      custom-shader-animation = false;
    }
    // lib.optionalAttrs transparent {
      background-opacity = backgroundOpacity;
      background-blur = 20;
    }
    // ghosttyColors;
  };

  # Ghostty は Dock から起動するので ~/.config-nix を見ない。old / nix どちらのシェルでも使うため、
  # 生成した設定を ~/.config-nix ではなく Ghostty が必ず読む場所に置く
  xdg.configFile."ghostty/config".enable = false;
  home.file."Library/Application Support/com.mitchellh.ghostty/config.ghostty".source =
    config.xdg.configFile."ghostty/config".source;
}
