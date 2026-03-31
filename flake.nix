{
  description = "dooleydevin's dotfiles managed with home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = { system, username, homeDirectory, extraModules ? [] }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home/common.nix
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
            }
          ] ++ extraModules;
        };
    in
    {
      homeConfigurations = {
        "macos-aarch64" = mkHome {
          system = "aarch64-darwin";
          username = "dooleydevin";
          homeDirectory = "/Users/dooleydevin";
          extraModules = [ ./home/macos.nix ];
        };

        "macos-x86_64" = mkHome {
          system = "x86_64-darwin";
          username = "dooleydevin";
          homeDirectory = "/Users/dooleydevin";
          extraModules = [ ./home/macos.nix ];
        };

        "linux" = mkHome {
          system = "x86_64-linux";
          username = "dooleydevin";
          homeDirectory = "/home/dooleydevin";
          extraModules = [ ./home/linux.nix ];
        };

        "devcontainer" =
          let
            envUser = builtins.getEnv "USER";
            envHome = builtins.getEnv "HOME";
          in
          mkHome {
            system = "x86_64-linux";
            username = if envUser != "" then envUser else "codespace";
            homeDirectory = if envHome != "" then envHome else "/home/codespace";
            extraModules = [ ./home/devcontainer.nix ];
          };
      };
    };
}
