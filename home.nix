{ config, lib, pkgs, ... }:

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
    };
    ignores = [ ".DS_Store" ".direnv/" "result" "**/.claude/settings.local.json" ];
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
  programs.fzf.enable = true;
  # z <ディレクトリ名の一部> で、よく行くディレクトリへ移動
  programs.zoxide.enable = true;

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
