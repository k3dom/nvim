{
  description = "A nixvim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    useNightly = false;
    eachSupportedSystem = f:
      nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system:
        f {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            overlays = nixpkgs.lib.optionals useNightly [
              inputs.neovim-nightly.overlays.default
            ];
          };
        });
    nixvimModule = pkgs: {
      inherit pkgs;
      module = ./config;
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  in {
    packages = eachSupportedSystem ({
      pkgs,
      system,
    }: {
      default = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule (nixvimModule pkgs);
    });
    checks = eachSupportedSystem ({
      pkgs,
      system,
    }: {
      default = inputs.nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule (nixvimModule pkgs);
    });
    devShells = eachSupportedSystem ({pkgs, ...}: let
      # Single entry point so CI and local runs cannot drift apart.
      ci = pkgs.writeShellApplication {
        name = "ci";
        runtimeInputs = with pkgs; [alejandra statix];
        text = ''
          alejandra --check .
          statix check
        '';
      };
    in {
      default = pkgs.mkShell {
        packages =
          [ci]
          ++ (with pkgs; [
            alejandra
            statix
            zizmor
          ]);
      };
    });
    # `nix fmt` invokes the formatter without arguments, and bare alejandra then
    # reads stdin instead of the tree.
    formatter = eachSupportedSystem ({pkgs, ...}:
      pkgs.writeShellScriptBin "alejandra" ''
        exec ${pkgs.lib.getExe pkgs.alejandra} "''${@:-.}"
      '');
  };
}
