{
  plugins.lspconfig.enable = true;
  lsp.servers = {
    nixd.enable = true;
    jsonls.enable = true;
    dockerls.enable = true;
    tofu_ls.enable = true;
    rust_analyzer.enable = true;
    vtsls = {
      enable = true;
      config.settings = {
        typescript.tsserver.maxTsServerMemory = 12288;
        vtsls.autoUseWorkspaceTsdk = true;
      };
    };
  };
}
