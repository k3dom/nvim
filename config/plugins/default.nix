{
  imports = [
    ./blink.nix
    ./lsp.nix
    ./mini.nix
    ./treesitter.nix
    ./fff.nix
    ./snacks.nix
    ./conform.nix
  ];

  plugins = {
    ts-autotag.enable = true;
    fidget.enable = true;
    schemastore.enable = true;
  };
}
