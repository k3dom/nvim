{
  description = "A nixvim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    eachSupportedSystem = f:
      nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system:
        f {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfreePredicate = pkg: nixpkgs.lib.getName pkg == "copilot-language-server";
          };
        });
    nixvimFor = pkgs:
      inputs.nixvim.lib.evalNixvim {
        modules = [
          ./config
          {nixpkgs.pkgs = pkgs;}
        ];
      };
  in {
    packages = eachSupportedSystem ({
      pkgs,
      system,
    }: let
      nixvim = nixvimFor pkgs;
    in
      {default = nixvim.config.build.package;}
      # The nightly overlay publishes no cached builds, so this compiles Neovim
      # locally and is deliberately left out of `checks`.
      // nixpkgs.lib.optionalAttrs (inputs.neovim-nightly.packages ? ${system}) {
        nightly =
          (nixvim.extendModules {
            modules = [{package = inputs.neovim-nightly.packages.${system}.default;}];
          }).config.build.package;
      });
    checks = eachSupportedSystem ({pkgs, ...}: {
      default = (nixvimFor pkgs).config.build.test;
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
