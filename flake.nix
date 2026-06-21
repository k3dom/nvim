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
    devShells = eachSupportedSystem ({pkgs, ...}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          statix
        ];
      };
    });
    formatter = eachSupportedSystem ({pkgs, ...}: pkgs.alejandra);
  };
}
