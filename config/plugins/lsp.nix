{pkgs, ...}: {
  plugins.lspconfig.enable = true;
  lsp.servers = {
    nixd.enable = true;
    jsonls.enable = true;
    yamlls.enable = true;
    dockerls.enable = true;
    tofu_ls.enable = true;
    rust_analyzer.enable = true;
    tsc = {
      enable = true;
      package = pkgs.typescript;
    };
  };
}
