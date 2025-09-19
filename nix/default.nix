{ callPackage
, lib
, neovimUtils
, neovim-unwrapped
, pkgs
, stdenv
, sqlite
, vimPlugins
, wrapNeovimUnstable
, writeText

, buildAppImage ? false
, base16-palette ? null
}:

let
  plugins = with vimPlugins; [
    (callPackage ./base16-nvim {})
    battery-nvim
    cmp-async-path
    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-nvim-lsp-document-symbol
    cmp-nvim-lsp-signature-help
    crates-nvim
    diffview-nvim
    gitsigns-nvim
    indent-blankline-nvim-lua
    isabelle-lsp-nvim
    isabelle-syn-nvim
    lazygit-nvim
    lualine-nvim
    mini-ai
    nvim-autopairs
    nvim-cmp
    nvim-lspconfig
    nvim-navic
    nvim-treesitter.withAllGrammars
    nvim-web-devicons
    oil-nvim
    orgmode
    rainbow-delimiters-nvim
    telescope-fzf-native-nvim
    telescope-nvim
    telescope-tabs
    telescope-ui-select-nvim
    undotree
    vimtex
  ];

  extraPackages = with pkgs; [
    # Language Servers
    clang-tools
    lua-language-server
    nixd
    ocamlPackages.ocaml-lsp
    ruff
    rust-analyzer
    texlab
    typescript-language-server
    vscode-langservers-extracted

    # Misc
    curlMinimal
    fd
    findutils
    git
    lazygit
    mercurial
    ripgrep
  ];

  extraLuaPackages = p: [];

  withNodeJs = false;

  withPython3 = false;
  extraPython3Packages = p: [];

  withRuby = false;
  withSqlite = false;

  viAlias = false;
  vimAlias = false;

  neovimConfig = neovimUtils.makeNeovimConfig {
    inherit
      plugins
      extraPython3Packages extraLuaPackages withNodeJs withRuby withPython3
      viAlias vimAlias;
  };

  rtp = stdenv.mkDerivation {
    name = "rtp";
    src = ../nvim;
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out;
      cp -r $src/* $out/
    '';
  };

  initLua = ''
    ${lib.optionalString buildAppImage ''
      vim.o.shell = '/bin/sh'
      vim.g.lazygit_use_custom_config_file_path = 1
      vim.g.lazygit_config_file_path = '${writeText "lazygit-cfg" ''
        git:
          overrideGpg: true
      ''}'
    ''}
    ${lib.optionalString (base16-palette != null) ''
      vim.g.base16_palette = { ${ lib.foldl (acc: {name, value}: acc + "${name} = '#${value}',") "" (lib.attrsToList base16-palette)} }
    ''}

    vim.opt.rtp:prepend('${rtp}')
    vim.opt.rtp:prepend('${rtp}/after')

    ${builtins.readFile ../nvim/init.lua}
  '';

  extraMakeWrapperArgs = let
    sqliteLibExt = stdenv.hostPlatform.extensions.sharedLibrary;
    sqliteLibPath = "${sqlite.out}/lib/libsqlite3${sqliteLibExt}";
    extraPackages' = extraPackages ++ (lib.optionals withSqlite [ sqlite ]);
  in builtins.concatStringsSep " " (
    (lib.optional (extraPackages' != [])
      ''--prefix PATH : "${lib.makeBinPath extraPackages'}"'')
    ++ (lib.optional withSqlite
      ''--set LIBSQLITE_CLIB_PATH "${sqliteLibPath}"'')
    ++ (lib.optional withSqlite
      ''--set LIBSQLITE "${sqliteLibPath}"'')
  );
in wrapNeovimUnstable neovim-unwrapped (neovimConfig // {
  luaRcContent = initLua;
  wrapperArgs =
    lib.escapeShellArgs neovimConfig.wrapperArgs
    + " "
    + extraMakeWrapperArgs;
  wrapRc = true;
})
