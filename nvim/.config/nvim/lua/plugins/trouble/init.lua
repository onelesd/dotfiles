require('trouble').setup {
  auto_open = false, -- automatically open the list when you have diagnostics
  auto_close = false, -- automatically close the list when you have no diagnostics
  icons = false, -- this should be true, but it complains that nvim-web-devicons isn't installed even though it is. it works even when set to false, so <shrug>
}
