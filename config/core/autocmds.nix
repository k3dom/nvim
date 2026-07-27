{lib, ...}: {
  autoGroups = {
    highlight_yank = {};
    resize_splits = {};
    format_options = {};
    check_time = {};
    man_unlisted = {};
    mini_split = {};
  };

  autoCmd = [
    {
      group = "highlight_yank";
      event = ["TextYankPost"];
      desc = "Briefly highlight yanked text";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.hl.on_yank()
        end
      '';
    }
    {
      group = "resize_splits";
      event = ["VimResized"];
      desc = "Equalize split sizes when the terminal is resized";
      callback = lib.nixvim.mkRaw ''
        function()
          local current_tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. current_tab)
        end
      '';
    }
    {
      group = "check_time";
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      desc = "Reload buffers changed outside of neovim";
      callback = lib.nixvim.mkRaw ''
        function()
          if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
          end
        end
      '';
    }
    {
      group = "format_options";
      event = ["FileType"];
      desc = "Never auto-insert comment leaders on newlines";
      callback = lib.nixvim.mkRaw ''
        function()
          vim.bo.formatoptions = vim.bo.formatoptions:gsub("[co]", "")
        end
      '';
    }
    {
      group = "man_unlisted";
      event = ["FileType"];
      pattern = ["man"];
      desc = "Keep man pages out of the buffer list";
      callback = lib.nixvim.mkRaw ''
        function(event)
          vim.bo[event.buf].buflisted = false
        end
      '';
    }
    {
      group = "mini_split";
      event = ["User"];
      pattern = ["MiniFilesBufferCreate"];
      desc = "Open files from mini.files in a split";
      callback = lib.nixvim.mkRaw ''
        function(args)
          local map_split = function(buf_id, lhs, direction)
            local rhs = function()
              local cur_target = MiniFiles.get_explorer_state().target_window
              local new_target = vim.api.nvim_win_call(cur_target, function()
                vim.cmd(direction .. " split")
                return vim.api.nvim_get_current_win()
              end)

              MiniFiles.set_target_window(new_target)
              MiniFiles.go_in()
              MiniFiles.close()
            end

            local desc = "Split " .. direction
            vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
          end

          local buf_id = args.data.buf_id
          map_split(buf_id, "<C-s>", "belowright horizontal")
          map_split(buf_id, "<C-v>", "belowright vertical")
        end
      '';
    }
  ];
}
