{
  keymaps = [
    {
      mode = "x";
      key = "<";
      action = "<gv";
      options.desc = "Dedent and keep selection";
    }
    {
      mode = "x";
      key = ">";
      action = ">gv";
      options.desc = "Indent and keep selection";
    }
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>w!<cr>";
      options.desc = "Write buffer";
    }
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>q<cr>";
      options.desc = "Quit buffer";
    }
    {
      mode = "n";
      key = "<leader>tw";
      action = "<cmd>setlocal wrap!<cr>";
      options.desc = "Toggle line wrapping";
    }
    {
      mode = "n";
      key = "<c-h>";
      action = "<c-w>h";
      options.desc = "Go to Left Window";
    }
    {
      mode = "n";
      key = "<c-j>";
      action = "<c-w>j";
      options.desc = "Go to Lower Window";
    }
    {
      mode = "n";
      key = "<c-k>";
      action = "<c-w>k";
      options.desc = "Go to Upper Window";
    }
    {
      mode = "n";
      key = "<c-l>";
      action = "<c-w>l";
      options.desc = "Go to Right Window";
    }
    {
      mode = [
        "i"
        "n"
      ];
      key = "<esc>";
      action = "<cmd>noh<cr><esc>";
      options.desc = "Clear search highlight";
    }
  ];
}
