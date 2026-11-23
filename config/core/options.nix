{
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
  # Neovim reloads the colorscheme whenever 'background' changes, which the
  # terminal_background autocmd keeps in line with the terminal.
  colorscheme = "fox";
  extraFiles."colors/fox.lua".text = ''
    require("nightfox.config").set_fox(vim.o.background == "light" and "dayfox" or "carbonfox")
    require("nightfox").load()
    vim.g.colors_name = "fox"
  '';

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
