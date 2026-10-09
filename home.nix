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
  };

  programs.starship.enable = true;
}
