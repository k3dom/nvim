{lib, ...}: {
  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = lib.nixvim.mkRaw ''
        function()
          MiniFiles.open(vim.api.nvim_buf_get_name(0))
        end
      '';
      options.desc = "mini: Open file explorer";
    }
    {
      mode = "n";
      key = "<leader>re";
      action = lib.nixvim.mkRaw ''
        function()
          MiniFiles.open()
        end
      '';
      options.desc = "mini: Open file explorer at root";
    }
  ];

  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      icons = {};
      surround = {};
      pairs = {};
      splitjoin = {};
      move = {};
      statusline = {};
      diff = {
        view.style = "sign";
      };
      files = {
        windows.preview = true;
        options.use_as_default_explorer = false;
      };
      jump2d = {
        silent = true;
        allowed_lines.cursor_at = false;
        view.n_steps_ahead = 2;
        spotter = lib.nixvim.mkRaw ''
          require('mini.jump2d').builtin_opts.word_start.spotter
        '';
      };
    };
  };
}
