{
  lib,
  pkgs,
  ...
}: let
  # Pinned config for the project-independent formatter below, so the keymap
  # behaves the same in every buffer regardless of the enclosing project.
  oxfmtConfig = (pkgs.formats.json {}).generate "oxfmt-global.json" {
    printWidth = 80;
    proseWrap = "always";
  };
in {
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
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>L";
      action = lib.nixvim.mkRaw ''
        function()
          require("conform").format({ formatters = { "oxfmt_global" }, async = true })
        end
      '';
      options.desc = "conform: Format current buffer with global oxfmt";
    }
  ];

  plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;
    settings = {
      default_format_opts.stop_after_first = true;
      formatters = {
        # Deliberately not in formatters_by_ft: only reachable via <leader>L.
        # Absolute paths keep it working in projects that don't depend on oxfmt.
        oxfmt_global = {
          command = lib.getExe pkgs.oxfmt;
          args = [
            "--config"
            "${oxfmtConfig}"
            "--stdin-filepath"
            "$FILENAME"
          ];
          stdin = true;
        };
      };
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
        markdown = ["oxfmt" "prettier"];
        yaml = ["oxfmt" "prettier"];
        nix = ["alejandra"];
        ocaml = ["ocamlformat"];
      };
    };
  };
}
