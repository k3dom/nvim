{lib, ...}: {
  viAlias = true;
  vimAlias = true;

  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      luaLib = true;
      nvimRuntime = true;
      plugins = true;
    };

    combinePlugins = {
      enable = true;
      standalonePlugins = [
        # `doc/recipes.md` collides with blink.cmp.
        "conform.nvim"
        # `queries/lua/injections.scm` collides with the treesitter queries.
        "snacks.nvim"
      ];
    };
  };

  withPython3 = false;
  withRuby = false;

  colorschemes.nightfox.enable = true;
  colorscheme = "fox";
  extraFiles."colors/fox.lua".text = ''
    require("nightfox.config").set_fox(vim.o.background == "light" and "dayfox" or "carbonfox")
    require("nightfox").load()
    vim.g.colors_name = "fox"
  '';

  # Neovim reloads the colorscheme whenever 'background' changes. Its own
  # handler that follows the terminal is gone by VimEnter once a colorscheme
  # has set 'background', which nightfox's always do.
  autoGroups.terminal_background = {};
  autoCmd = [
    {
      group = "terminal_background";
      event = ["TermResponse"];
      nested = true;
      desc = "Follow the terminal's background when it switches between light and dark";
      callback = lib.nixvim.mkRaw ''
        function(event)
          local r, g, b = event.data.sequence:match("^\027%]11;rgba?:(%x+)/(%x+)/(%x+)")
          if not r then
            return
          end
          local function intensity(hex)
            return tonumber(hex, 16) / (16 ^ #hex - 1)
          end
          local luminance = 0.299 * intensity(r) + 0.587 * intensity(g) + 0.114 * intensity(b)
          local background = luminance < 0.5 and "dark" or "light"
          if vim.o.background ~= background then
            vim.o.background = background
          end
        end
      '';
    }
  ];

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  diagnostic.settings = {
    severity_sort = true;
    virtual_text = true;
  };

  opts = {
    number = true;
    relativenumber = true;
    numberwidth = 2;

    cursorline = true;
    colorcolumn = "85,120";
    signcolumn = "yes";

    laststatus = 3;
    showmode = false;
    winborder = "rounded";

    wrap = false;
    scrolloff = 10;
    pumheight = 10;

    list = true;
    listchars = {
      tab = "» ";
      trail = "·";
      nbsp = "␣";
    };

    mouse = "a";
    clipboard = "unnamedplus";

    splitkeep = "screen";
    inccommand = "split";
    splitbelow = true;
    splitright = true;

    smartindent = true;
    expandtab = true;
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;

    ignorecase = true;
    smartcase = true;
    infercase = true;

    spelllang = "en,de";
    confirm = true;
    swapfile = false;
  };
}
