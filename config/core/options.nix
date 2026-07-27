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
        # Looks up `copilot/js/language-server.js` via `nvim_get_runtime_file`,
        # and `/copilot` is not among the linked runtime paths.
        "copilot.lua"
        # `queries/lua/injections.scm` collides with the treesitter queries.
        "snacks.nvim"
      ];
    };
  };

  withPython3 = false;
  withRuby = false;

  colorschemes.nightfox = {
    enable = true;
    flavor = "carbonfox";
  };

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
