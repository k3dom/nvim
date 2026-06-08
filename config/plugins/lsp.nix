{lib, ...}: {
  keymaps = [
    {
      mode = "n";
      key = "<leader>i";
      action = lib.nixvim.mkRaw ''
        vim.diagnostic.open_float
      '';
      options.desc = "Show diagnostics under cursor";
    }
    {
      mode = "n";
      key = "<leader>rl";
      action = lib.nixvim.mkRaw ''
        function()
          vim.cmd("lsp restart")
          vim.cmd("bufdo e")
        end
      '';
      options.desc = "Restart LSP and reload all buffers";
    }
  ];

  plugins.lspconfig.enable = true;
  lsp.servers = {
    nixd.enable = true;
    jsonls.enable = true;
    yamlls.enable = true;
    tailwindcss.enable = true;
    dockerls.enable = true;
    helm_ls.enable = true;
    tofu_ls.enable = true;
    rust_analyzer.enable = true;
    astro.enable = true;
    tsgo.enable = true;
  };
}
