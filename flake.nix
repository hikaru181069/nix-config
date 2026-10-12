{
  description = "hikarusato の開発環境";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-darwin, ... }: {
    # 名前は Mac のローカルホスト名と同じにする（darwin-rebuild が自動でこれを選ぶ）
    darwinConfigurations."MacBook-Pro-5" = nix-darwin.lib.darwinSystem {
      modules = [
        ./darwin.nix
        # home-manager も nix-darwin の中で一緒に適用する
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.hikarusato = import ./home.nix;
        }
      ];
    };
  };
}
