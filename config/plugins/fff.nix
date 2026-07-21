{
  lib,
  pkgs,
  ...
}: let
  fff = pkgs.vimPlugins.fff-nvim;

  # zlob otherwise uses Zig's native CPU target. Cached builds can then contain
  # instructions (such as AVX-512) that are unsupported by the local CPU.
  fffLib = fff.fff-nvim-lib.overrideAttrs (oldAttrs: {
    env = (oldAttrs.env or {}) // {CI = true;};
  });

  fffPackage = fff.overrideAttrs (oldAttrs: {
    postPatch =
      (oldAttrs.postPatch or "")
      + ''
        substituteInPlace lua/fff/download.lua \
          --replace-fail \
            '${fff.fff-nvim-lib}' \
            '${fffLib}'
      '';
    passthru = (oldAttrs.passthru or {}) // {fff-nvim-lib = fffLib;};
  });
in {
  keymaps = [
    {
      mode = "n";
      key = "<leader>f";
      action = lib.nixvim.mkRaw ''
        function() require("fff").find_files() end
      '';
      options.desc = "fff: Find files";
    }
    {
      mode = "n";
      key = "<leader>g";
      action = lib.nixvim.mkRaw ''
        function() require("fff").live_grep() end
      '';
      options.desc = "fff: Live grep";
    }
  ];

  plugins.fff = {
    enable = true;
    package = fffPackage;
    settings = {
      layout.prompt_position = "top";
    };
  };
}
