{ callPackage
, lib
, neovimUtils
, neovim-unwrapped
, pkgs
, stdenv
, sqlite
, vimPlugins
, wrapNeovimUnstable

, buildAppImage ? false
, base16-palette ? null
}:

let
  plugins = with vimPlugins; [
    (callPackage ./base16-nvim {})
    baleia-nvim
    battery-nvim
    cmp-async-path
    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-nvim-lsp-document-symbol
    cmp-nvim-lsp-signature-help
    colorful-winsep-nvim
    compile-mode-nvim
    crates-nvim
    diffview-nvim
    gitsigns-nvim
    indent-blankline-nvim-lua
    isabelle-lsp-nvim
    isabelle-syn-nvim
    lualine-nvim
    nvim-autopairs
    nvim-cmp
    nvim-cursorline
    nvim-lspconfig
    nvim-navic
    nvim-treesitter.withAllGrammars
    nvim-treesitter-textobjects
    nvim-web-devicons
    oil-nvim
    orgmode
    rainbow-delimiters-nvim
    render-markdown-nvim
    telescope-fzf-native-nvim
    telescope-nvim
    telescope-tabs
    telescope-ui-select-nvim
    undotree
    vimtex
  ];

  extraPackages = with pkgs; [
    # Language Servers
    basedpyright
    bash-language-server
    clang-tools
    lua-language-server
    nixd
    ocamlPackages.ocaml-lsp
    rust-analyzer
    texlab
    typescript-language-server
    vscode-langservers-extracted

    # Misc
    curlMinimal
    diffutils
    fd
    findutils
    git
    gnutar
    mercurial
    ripgrep
    tree-sitter
  ];

  extraLuaPackages = p: [];

  withNodeJs = false;

  withPython3 = false;
  extraPython3Packages = p: [];

  withRuby = false;
  withSqlite = false;

  viAlias = false;
  vimAlias = false;

  rtp = stdenv.mkDerivation {
    name = "rtp";
    src = ../nvim;
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out;
      cp -r $src/* $out/
    '';
  };

  customLuaRC = ''
    ${lib.optionalString buildAppImage ''
      vim.o.shell = '${lib.getExe pkgs.bashInteractive}'
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
  in (
    (lib.optionals (extraPackages' != []) [
      "--prefix" "PATH" ":" (lib.makeBinPath extraPackages')
    ]) ++ (lib.optionals withSqlite [
      "--set" "LIBSQLITE_CLIB_PATH" sqliteLibPath
      "--set" "LIBSQLITE" sqliteLibPath
    ])
  );

  neovimConfig = let
    cfg = neovimUtils.makeNeovimConfig {
      wrapRc = true;
      inherit
        customLuaRC
        plugins
        extraPython3Packages extraLuaPackages withNodeJs withRuby withPython3
        viAlias vimAlias;
    };
  in cfg // {
    wrapperArgs = cfg.wrapperArgs ++ extraMakeWrapperArgs;
  };

  wrapperOverrides = lib.optionalAttrs buildAppImage {
    wl-clipboard = null;
  };
in (wrapNeovimUnstable.override wrapperOverrides) neovim-unwrapped neovimConfig
