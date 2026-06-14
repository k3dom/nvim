{lib, ...}: {
  keymaps = [
    {
      mode = "n";
      key = "<leader>f";
      action = lib.nixvim.mkRaw ''
        function() require("fff").find_files() end
      '';
      options.desc = "fff: Find files";
    }
    {
      mode = "n";
      key = "<leader>g";
      action = lib.nixvim.mkRaw ''
        function() require("fff").live_grep() end
      '';
      options.desc = "fff: Live grep";
    }
  ];

  plugins.fff = {
    enable = true;
    settings = {
      layout.prompt_position = "top";
    };
  };
}
