# Mac 全体の設定（nix-darwin）。適用は `sudo darwin-rebuild switch --flake ~/nix-config`
# ユーザーの設定（ツール・dotfiles）は home.nix。home-manager は nix-darwin の中で一緒に適用される
{ config, lib, pkgs, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 7;
  # Homebrew や macOS の設定など、ユーザーごとのものを当てる相手
  system.primaryUser = "hikarusato";
  users.users.hikarusato.home = "/Users/hikarusato";

  # Mac の名前。ネットワーク上の名前（ローカルホスト名）は flake.nix の darwinConfigurations の名前と同じにする
  # （darwin-rebuild はこの名前で設定を選ぶ）。ほかの人の MacBook-Pro とかぶらないよう、自分だけの名前にした
  networking.computerName = "hikaru-mbp";
  networking.localHostName = "hikaru-mbp";

  # Nix 本体（nix-daemon と /etc/nix/nix.conf）も nix-darwin で管理する
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # sudo を Touch ID で通す（/etc/pam.d/sudo_local。macOS のアップデートでも消えない場所）
  # reattach は tmux の中でも Touch ID を使えるようにするため（ないとパスワードしか聞かれない）
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  # /etc/zshenv・/etc/zshrc は nix-darwin が作る。ユーザーの zsh の設定は home.nix（home-manager）にある
  programs.zsh = {
    enable = true;
    # 補完の初期化（compinit）とプロンプトは home-manager の zsh・starship で行うので、ここでは二重にしない
    enableGlobalCompInit = false;
    promptInit = "";
  };

  # nix-darwin は PATH を作り直す。Homebrew の場所は macOS の /etc/paths.d で足されていたので、ここで明示する
  # （Nix のものより後ろ、/usr/bin などより前）
  environment.systemPath = lib.mkOrder 1100 [ "${config.homebrew.prefix}/bin" ];

  # macOS の設定。2026-10-12 時点の値をそのまま宣言したもの（A）と、この機会に変えたもの（B）
  system.defaults = {
    NSGlobalDomain = {
      # A: ダークモード。メニューバーは隠す（代わりに sketchybar を出す）
      AppleInterfaceStyle = "Dark";
      _HIHideMenuBar = true;
      # B: キーを押しっぱなしにしたら、アクセント記号の候補ではなく文字をくり返す（Neovim で hjkl を押しっぱなしにできる）
      ApplePressAndHoldEnabled = false;
      # B: くり返しを速く。システム設定で選べるいちばん速い値（くり返しの間隔 2 = 30ms、始まるまで 15 = 225ms）
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      # B: 文字の自動修正はすべてやめる（コードやコマンドを書くときに邪魔になる）
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
    };
    dock = {
      # A: 左側に、自動で隠す、大きさ 40
      autohide = true;
      orientation = "left";
      tilesize = 40;
      # B: スペースを「最近使った順」に並び替えない（yabai・sketchybar のスペース番号がずれるため）
      mru-spaces = false;
    };
    # A: Finder はカラム表示
    finder.FXPreferredViewStyle = "clmv";
    trackpad = {
      # A: タップでクリックしない、3本指ドラッグなし、2本指で右クリック
      Clicking = false;
      TrackpadThreeFingerDrag = false;
      TrackpadRightClick = true;
    };
    # A: スクリーンショットの保存先
    screencapture.location = "${config.system.primaryUserHome}/screenshots";
    WindowManager = {
      # A: macOS のタイル機能で並べたときの余白なし
      EnableTiledWindowMargins = false;
      # B: 壁紙をクリックしてもウィンドウをよけない（ステージマネージャ使用時だけにする）
      EnableStandardClickToShowDesktop = false;
    };
  };

  # Homebrew は GUI アプリ・フォント（cask）と、Nix にないか Nix で困るものだけ
  # ここに書いていないものは、適用のときに消す（cleanup = "uninstall"）。片付け前の一覧は ~/old-env-backup-2026-10-13
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "uninstall";
    };
    taps = [ "mongodb/brew" ];
    brews = [
      # mlb-app の MongoDB（27017）。Homebrew のサービスとしてログイン時に起動している
      "mongodb/brew/mongodb-community@8.0"
      "mongodb/brew/mongodb-database-tools"
      # Nix の gh（Go 1.27 で作られた版）が学内のネットワークで GitHub につながらないので、その間の逃げ道
      # PATH では Nix の gh が先なので、使うときは /opt/homebrew/bin/gh と打つ
      "gh"
    ];
    # 2026-10-12 時点で入っていたものをそのまま宣言した
    casks = [
      "codex"
      "font-maple-mono-nf"
      "font-maple-mono-nf-cn"
      "font-moralerspace"
      "font-recursive-mono-nerd-font"
      "font-sketchybar-app-font"
      "ghostty"
      "hammerspoon"
      "orbstack"
      "stats"
      "wezterm"
    ];
  };
}
