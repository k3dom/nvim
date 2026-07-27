# ❄️ `nvim` ❄️

Personal neovim configuration made with Nix and [nixvim](https://github.com/nix-community/nixvim).

[![Check](https://github.com/k3dom/nvim/actions/workflows/check.yml/badge.svg)](https://github.com/k3dom/nvim/actions/workflows/check.yml)

## Usage

### 1. Running the Configuration

To quickly run your Neovim configuration with nix, simply execute:

```bash
nix run .
```

This command builds and launches your configuration based on the default package setup.

### 2. Installing It on NixOS

#### Step 1: Add as a Flake Input

In your `flake.nix`, add this repository as an input and pass the inputs down to your
system configuration:

```nix
{
  inputs = {
    # ... other inputs ...
    neovim-config.url = "github:k3dom/nvim";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [./configuration.nix];
    };
  };
}
```

#### Step 2: Add the Package

The flake exposes a single package, so add it to your system (or Home Manager) packages:

```nix
{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.neovim-config.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
```

The package provides `nvim` along with the `vi` and `vim` aliases.
