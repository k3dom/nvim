{lib, ...}: {
  keymaps = [
    {
      mode = "n";
      key = "<leader>l";
      action = lib.nixvim.mkRaw ''
        function()
          require("conform").format({ async = true })
        end
      '';
      options.desc = "conform: Format current buffer";
    }
  ];

  plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;
    settings = {
      default_format_opts.stop_after_first = true;
      formatters_by_ft = {
        "_" =
          lib.nixvim.listToUnkeyedAttrs [
            "trim_whitespace"
            "trim_newlines"
            "squeeze_blanks"
          ]
          // {stop_after_first = false;};
        python = ["ruff_format"];
        rust = ["rustfmt"];
        javascript = ["oxfmt" "prettier"];
        typescript = ["oxfmt" "prettier"];
        typescriptreact = ["oxfmt" "prettier"];
        astro = ["oxfmt" "prettier"];
        json = ["oxfmt" "prettier"];
        json5 = ["oxfmt" "prettier"];
        yaml = ["oxfmt" "prettier"];
        nix = ["alejandra"];
        ocaml = ["ocamlformat"];
      };
    };
  };
}
