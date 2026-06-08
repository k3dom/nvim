{
  imports = [
    ./blink.nix
    ./lsp.nix
    ./mini.nix
    ./treesitter.nix
    ./copilot.nix
    ./snacks.nix
    ./conform.nix
  ];

  plugins = {
    ts-autotag.enable = true;
    fidget.enable = true;
    web-devicons.enable = true;
    schemastore.enable = true;
  };
}
