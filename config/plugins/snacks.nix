{lib, ...}: {
  keymaps = [
    {
      mode = [
        "n"
        "t"
      ];
      key = "<a-i>";
      action = lib.nixvim.mkRaw ''
        function() Snacks.lazygit() end
      '';
      options.desc = "snacks: Toggle lazy git";
    }
    {
      mode = "n";
      key = "<leader>z";
      action = lib.nixvim.mkRaw ''
        function() Snacks.zen.zen() end
      '';
      options.desc = "snacks: Toggle zen mode";
    }
  ];

  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enabled = true;
      input.enabled = true;
      lazygit.enabled = true;
      zen = {
        toggles.dim = false;
        win.backdrop = false;
      };
    };
  };
}
