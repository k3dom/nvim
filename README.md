# ❄️ `nvim` ❄️

Personal neovim configuration made with Nix and [nixvim](https://github.com/nix-community/nixvim).

[![Build status](https://github.com/k3dom/nvim/workflows/ci/badge.svg)](https://github.com/k3dom/nvim/actions)

## Usage

### 1. Running the Configuration

To quickly run your Neovim configuration with nix, simply execute:

```bash
nix run .
```

This command builds and launches your configuration based on the default package setup.

### 2. Adding as a NixOS Module

If you want to integrate the configuration into your NixOS system, you can add it as a flake input and then include it as a module.

#### Step 1: Add as a Flake Input

In your `flake.nix`, add your Neovim configuration repository as an input:

```nix
{
  inputs = {
    # ... other inputs ...
    neovim-config = {
      url = "github:k3dom/nvim";
      # Optionally, specify a ref or branch if needed.
    };
  };

  outputs = { self, nixpkgs, neovim-config, ... }:
    {
      # your outputs configuration
    };
}
```

#### Step 2: Include the NixOS Module and Package

In your NixOS configuration (e.g., `configuration.nix`), import the module and add the package. Replace `${system}` with your system identifier (e.g., `x86_64-linux`):

```nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim-config.nvim.packages.${system}.default
  ];

  # Additional configuration if required
}
```

With these steps, your system will use the Neovim configuration provided by your flake, and you can manage it directly through your NixOS configuration.
