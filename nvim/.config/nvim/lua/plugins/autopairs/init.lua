require'nvim-autopairs'.setup {
  disable_filetype = { "TelescopePrompt" },

  -- fast wrap
  -- Before        Input                    After
  -- --------------------------------------------------
  -- (|foobar      <M-e> then press $        (|foobar)
  -- (|)(foobar)   <M-e> then press q       (|(foobar))
  fast_wrap = {}
}
