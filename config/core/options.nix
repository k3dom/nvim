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
        "conform.nvim"
        "copilot.lua"
        "snacks.nvim"
      ];
    };
  };

  withNodeJs = false;
  withPerl = false;
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
    incsearch = true;
    infercase = true;

    spelllang = "en,de";
    swapfile = false;
  };
}
