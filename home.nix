{ config, lib, pkgs, ... }:

let
  palette = import ./palette.nix;
in
{
  home.username = "hikarusato";
  home.homeDirectory = "/Users/hikarusato";
  home.stateVersion = "26.05";

  # 旧環境（~/.config）と分けるため、Nix 環境の設定はすべて ~/.config-nix に置く
  xdg.enable = true;
  xdg.configHome = "${config.home.homeDirectory}/.config-nix";

  # flakes を有効化（Nix 環境のときだけ読まれる）
  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.home-manager.enable = true;

  # 旧環境と Nix 環境を切り替える仕組み。~/.zshenv はどのシェルでも最初に読まれるので、
  # home-manager が置く「常に Nix 環境を読む」中身を、モードで分岐する中身に差し替える
  home.file.".zshenv".text = lib.mkForce (builtins.readFile ./envswitch/zshenv);
  home.file.".local/bin/envswitch".source = ./envswitch/envswitch;

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
    ignores = [ ".DS_Store" ".direnv/" "result" "**/.claude/settings.local.json" ];
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
    options.navigate = true;
  };

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
    };
    # Ctrl-X Ctrl-E で、入力中のコマンドをエディタで編集する
    initContent = ''
      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey '^X^E' edit-command-line
      # キーチェーンに保存したパスフレーズで SSH 鍵を ssh-agent に読み込む（コミット署名に必要）
      /usr/bin/ssh-add --apple-load-keychain -q 2>/dev/null
    '';
  };

  # 時刻やホスト名は tmux / sketchybar に任せ、プロンプトには作業に要るものだけ出す
  programs.starship = {
    enable = true;
    settings.format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";
  };

  # ls を eza に置き換える（ls / ll / lt などの別名は eza が用意し、上で一部上書き）
  programs.eza = {
    enable = true;
    icons = "auto";
  };
  # Ctrl-R で履歴検索、Ctrl-T でファイル検索、Alt-C でディレクトリ移動
  # ファイル一覧は fd で作る（.gitignore を尊重し、隠しファイルも含める）
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
    fileWidgetCommand = "fd --type f --hidden --exclude .git";
    changeDirWidgetCommand = "fd --type d --hidden --exclude .git";
  };

  # 検索ツール。Neovim の telescope（live_grep / find_files）からも使う
  programs.ripgrep = {
    enable = true;
    # 小文字だけなら大文字小文字を区別しない
    arguments = [ "--smart-case" ];
  };
  programs.fd.enable = true;
  programs.jq.enable = true;

  # Git の操作画面。diff は delta で表示する
  programs.lazygit = {
    enable = true;
    settings.git.pagers = [ { pager = "delta --paging=never"; } ];
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
      # 右端の虹色の三角。前の色の上に次の色の三角を重ねていく
      rainbow = [ p.bg0 p.red p.orange p.yellow p.green p.cyan p.blue p.bg0 ];
      rainbowArrows = lib.concatStrings (
        lib.zipListsWith (bg: fg: "#[fg=${fg},bg=${bg}]${l}") (lib.init rainbow) (lib.tail rainbow)
      );
    in
    ''
      # ペインの zsh に ZDOTDIR を渡さない。渡すと zsh は ~/.zshenv（envswitch の分岐）を飛ばして
      # ~/.config-nix/zsh/.zshenv を直接読み、Nix の PATH が足されないペインになる
      set-environment -gu ZDOTDIR

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

      # コピーモード: v で選択開始、y か Enter でクリップボードへ
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe "pbcopy"
      bind -T copy-mode-vi Enter send-keys -X copy-pipe "pbcopy"
      bind -T copy-mode-vi Escape send-keys -X cancel

      # ステータスライン（見た目は旧環境のまま、色だけ Nightfox に置き換え）
      set -g mode-style "fg=${p.fg1},bg=${p.sel0}"
      set -g message-style "fg=${p.fg2},bg=${p.bg0}"
      set -g message-command-style "fg=${p.fg2},bg=${p.bg0}"
      set -g pane-border-style "fg=${p.bg1},bg=${p.bg1}"
      set -g pane-active-border-style "fg=${p.bg3},bg=${p.bg1}"

      set -g status on
      set -g status-interval 1
      set -g status-justify left
      set -g status-style "fg=${p.fg2},bg=${p.bg0}"
      set -g status-left-length 100
      set -g status-right-length 100
      set -g status-left-style NONE
      set -g status-right-style NONE

      # 左: セッション名（prefix を押している間は色が変わる）とユーザー名
      set -g status-left "#[fg=#{?client_prefix,${p.bg0},${p.comment}},bg=#{?client_prefix,${p.cyan},${p.bg0}},bold] #S #[fg=#{?client_prefix,${p.cyan},${p.bg0}},bg=${p.fg2},nobold]${r}#[fg=${p.bg0},bg=${p.fg2},bold] #(whoami) #[fg=${p.fg2},bg=${p.bg0},nobold]${r}"
      # 右: 虹色の三角とホスト名
      set -g status-right "${rainbowArrows}#[fg=${p.fg3},bg=${p.bg0},bold] #h "

      # ウィンドウ一覧: 番号とディレクトリ名
      setw -g window-status-separator ""
      setw -g window-status-style "fg=${p.comment},bg=${p.bg0}"
      setw -g window-status-activity-style "underscore,fg=${p.comment},bg=${p.bg0}"
      setw -g window-status-format "#[fg=${p.bg0},bg=${p.bg0}]${r}#[default] #I ${rThin} #{b:pane_current_path} #[fg=${p.bg0},bg=${p.bg0}]${r}"
      setw -g window-status-current-format "#[fg=${p.bg0},bg=${p.fg1}]${r}#[fg=${p.fg3},bg=${p.fg1}] #I #[fg=${p.fg1},bg=${p.fg3}]${r} #{b:pane_current_path} #[fg=${p.fg3},bg=${p.bg0}]${r}"
    ''
  );
  # z <ディレクトリ名の一部> で、よく行くディレクトリへ移動
  programs.zoxide.enable = true;

  # Neovim。設定（Lua）は ~/nix-config/nvim に置き、リンクして編集がすぐ反映されるようにする
  programs.neovim = {
    enable = true;
    # EDITOR / VISUAL を nvim にする（Ctrl-X Ctrl-E や git のコミットメッセージで使われる）
    defaultEditor = true;
    # home-manager が作る設定は init.lua に書かず、起動時に読ませる（init.lua は自分の設定だけにする）
    sideloadInitLua = true;
  };
  # 設定・データ・状態・キャッシュをまとめて旧環境（~/.config/nvim, ~/.local/share/nvim など）と分ける
  home.sessionVariables.NVIM_APPNAME = "nvim-nix";
  xdg.configFile."nvim-nix".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/nvim";

  # 本体は /Applications の Ghostty.app（cask）を使い、設定だけ管理する。中身は wezterm.lua から引き継ぎ
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      font-family = [ "Maple Mono NF" "Maple Mono NF CN" ];
      font-size = 18.5;
      theme = "Nightfox";
      window-width = 130;
      window-height = 38;
      window-padding-x = 10;
      window-padding-y = 10;
      macos-titlebar-style = "hidden";
      scrollbar = "never";
    };
  };

  # Ghostty は Dock から起動するので ~/.config-nix を見ない。old / nix どちらのシェルでも使うため、
  # 生成した設定を ~/.config-nix ではなく Ghostty が必ず読む場所に置く
  xdg.configFile."ghostty/config".enable = false;
  home.file."Library/Application Support/com.mitchellh.ghostty/config.ghostty".source =
    config.xdg.configFile."ghostty/config".source;
}
