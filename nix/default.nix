{
  callPackage,
  lib,
  neovim-unwrapped,
  pkgs,
  vimPlugins,
  vimUtils,
  wrapNeovimUnstable,

  base16-palette ? null,
  buildAppImage ? false,
  viAlias ? false,
  vimAlias ? false,
}:

let
  plugins = with vimPlugins; [
    (callPackage ./base16-nvim { })
    baleia-nvim
    battery-nvim
    cmp-async-path
    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-nvim-lsp-document-symbol
    cmp-nvim-lsp-signature-help
    colorful-winsep-nvim
    comment-nvim
    compile-mode-nvim
    conform-nvim
    crates-nvim
    diffview-nvim
    gitsigns-nvim
    indent-blankline-nvim
    isabelle-lsp-nvim
    isabelle-syn-nvim
    lualine-nvim
    nvim-autopairs
    nvim-cmp
    nvim-cursorline
    nvim-lspconfig
    nvim-navic
    nvim-treesitter-context
    nvim-treesitter-textobjects
    nvim-treesitter.withAllGrammars
    nvim-web-devicons
    oil-nvim
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
    go
    gopls
    lua-language-server
    neocmakelsp
    nixd
    ocamlPackages.ocaml-lsp
    rust-analyzer
    texlab
    typescript-language-server
    vscode-langservers-extracted

    # Formatters
    jq
    nixfmt
    prettierd
    ruff
    shfmt
    stylua

    # Misc
    curlMinimal
    diffutils
    fd
    findutils
    git
    gnutar
    mercurial
    python3Packages.pylatexenc
    ripgrep
    tree-sitter
  ];

  usrCfg = vimUtils.buildVimPlugin {
    name = "user-config";
    src = lib.cleanSource ../nvim;
    doCheck = false;
  };

  luaRcContent = /* lua */ ''
    ${lib.optionalString buildAppImage ''
      vim.o.shell = '${lib.getExe pkgs.bashInteractive}'
    ''}
    ${lib.optionalString (base16-palette != null) ''
      vim.g.base16_palette = { ${
        lib.foldl (acc: { name, value }: acc + "${name} = '#${value}',") "" (lib.attrsToList base16-palette)
      } }
    ''}

    ${lib.readFile ../nvim/init.lua}
  '';

  wrapperArgs = lib.optionals (extraPackages != [ ]) [
    "--prefix"
    "PATH"
    ":"
    (lib.makeBinPath extraPackages)
  ];

  wrapperOverrides = lib.optionalAttrs buildAppImage {
    wl-clipboard = null;
  };
in
(wrapNeovimUnstable.override wrapperOverrides) neovim-unwrapped {
  wrapRc = true;
  plugins = plugins ++ [ usrCfg ];
  inherit
    luaRcContent
    viAlias
    vimAlias
    wrapperArgs
    ;
}
