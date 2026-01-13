{
  description = "Miguel's neovim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      neovim-nightly,
      rust-overlay,
      ...
    }:
    let

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      overlays = [ rust-overlay.overlays.default ];
      mkPkgs =
        system:
        import nixpkgs {
          inherit system overlays;
        };

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            forEachSystem = nixpkgs.lib.genAttrs systems;
            pkgs = mkPkgs system;
            system = system;
          }
        );
    in
    {
      formatter = nixpkgs.lib.genAttrs systems (system: (mkPkgs system).nixfmt);
      homeManagerModules.default =
        {
          pkgs,
          config,
          lib,
          ...
        }:
        let
          mkIfExists = path: if builtins.pathExists path then path else pkgs.emptyFile;

        in
        {
          home.packages = with pkgs; [
            luajitPackages.jsregexp
            luajitPackages.luarocks
            stylua
            tree-sitter
            yamlfmt
          ];

          programs.neovim = {
            enable = true;
            defaultEditor = true;
            viAlias = true;
            vimAlias = true;

            package = neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;
            extraLuaPackages = ps: [
              ps.lua
              ps.luarocks-nix
              ps.magick
            ];
          };

          home.file = {
            ".config/nvim" = {
              recursive = true;
              source = pkgs.lib.cleanSourceWith {
                src = builtins.toString ./.;
                filter =
                  path: type:
                  let
                    baseName = baseNameOf path;
                  in
                  baseName != "lazy-lock.json";
              };
            };
          };
          home.activation.copyLazyLock =
            let
              src = ./lazy-lock.json;
              target = "${config.home.homeDirectory}/.config/nvim/lazy-lock.json";
            in
            lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              mkdir -p $(dirname ${target})
              cp ${src} ${target}
              chmod +w ${target}
            '';

        };

      homeConfigurations = forAllSystems (
        { system, ... }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          modules = [ self.homeManagerModules.default ];
        }
      );
    };
}
