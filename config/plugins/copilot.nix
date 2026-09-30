{
  keymaps = [
    {
      mode = "n";
      key = "<leader>cd";
      action = "<cmd>Copilot disable<cr>";
      options.desc = "Disable GitHub Copilot";
    }
    {
      mode = "n";
      key = "<leader>ce";
      action = "<cmd>Copilot enable<cr>";
      options.desc = "Enable GitHub Copilot";
    }
  ];

  plugins.copilot-lua = {
    enable = true;
    settings = {
      suggestion.auto_trigger = true;
    };
  };
}
