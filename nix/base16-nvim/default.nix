{
  vimPlugins,
}:

vimPlugins.base16-nvim.overrideAttrs (p: {
  patches = p.patches or [ ] ++ [ ./color-changes.patch ];
})
