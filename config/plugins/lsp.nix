{
  plugins.lspconfig.enable = true;
  lsp.servers = {
    nixd.enable = true;
    jsonls.enable = true;
    yamlls.enable = true;
    dockerls.enable = true;
    tofu_ls.enable = true;
    rust_analyzer.enable = true;
    tsgo.enable = true;
    # vtsls = {
    #   enable = true;
    #   config.settings = {
    #     typescript.tsserver.maxTsServerMemory = 12288;
    #     vtsls.autoUseWorkspaceTsdk = true;
    #   };
    # };
  };
}
