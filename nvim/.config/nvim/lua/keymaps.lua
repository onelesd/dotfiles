local opts = {noremap = true, silent = true, expr = false}
-- local expr_opts = {noremap = true, silent = true, expr = true}
local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' ' -- what is this, spacemacs?
map('n', ';', ':', opts) -- less shift pressing please
map('n', '<CR>', ':noh<CR><CR>', opts) -- clear search on enter
map('n', '<UP>', '<NOP>', opts) -- k
map('n', '<DOWN>', '<NOP>', opts) -- j
map('n', '<LEFT>', '<NOP>', opts) -- h
map('n', '<RIGHT>', '<NOP>', opts) -- l

-- <C-p> system clipboard paste because CMD-anything doesn't work in neovide
map('n', '<C-\\>', '<CMD>set paste<CR>a<C-r>+<ESC><CMD>set nopaste<CR>', opts)
map('i', '<C-\\>', '<C-o><CMD>set paste<CR><C-r>+<C-o><CMD>set nopaste<CR>',
    opts)

-- telescope stuff
map('n', '<leader><leader>',
    '<CMD>lua require"telescope.builtin".find_files({debounce = 100, find_command = {"rg","--files","--iglob","!.git","--hidden"}})<CR>',
    opts)
map('n', '<leader>sp', '<CMD>Telescope live_grep debounce=100<CR>', opts)
map('v', '<leader>sp',
    '"zy<CMD>Telescope live_grep debounce=100 default_text=<C-r>z<CR>', opts)
map('n', '<leader>sf',
    '<CMD>Telescope current_buffer_fuzzy_find debounce=100<CR>', opts)
map('v', '<leader>sf',
    '"zy<CMD>Telescope current_buffer_fuzzy_find debounce=100 default_text=\'<C-r>z<CR>',
    opts)
map('n', '<leader>bb', '<CMD>Telescope buffers debounce=100<CR>', opts)
map('n', '<leader>hh', '<CMD>Telescope help_tags debounce=100<CR>', opts)
map('n', '<leader>pp', '<CMD>Telescope project debounce=100<CR>', opts)

map('n', '<leader>ix',
    '<CMD>tabnew ~/tmp/neovim_iex.exs<CR><CMD>vsplit term://iex<CR><C-w>w', opts)
map('n', '<leader>iX',
    '<C-w><RIGHT><CMD>bdelete!<CR>A<C-c><C-c><CMD>sleep 100m<CR><C-c>', opts)

map('n', '<leader>gb', '<CMD>GitBlameToggle<CR>', opts)

map('n', '<leader>pi',
    '<CMD>source ~/.config/nvim/lua/plugins/init.lua<CR><CMD>PackerCompile<CR><CMD>PackerInstall<CR>',
    opts)
map('n', '<leader>pc',
    '<CMD>source ~/.config/nvim/lua/plugins/init.lua<CR><CMD>PackerCompile<CR><CMD>PackerClean<CR>',
    opts)

-- navigate tab-like for buffers
map('n', '<leader>gx', '<CMD>tabclose<CR>', opts)
map('n', '<leader>bx', '<CMD>Bdelete<CR>', opts)
map('n', '<leader>bn', '<CMD>bnext<CR>', opts)
map('n', '<leader>bp', '<CMD>bprev<CR>', opts)
map('n', '<leader>bo', '<CMD>%bd|e#|bd#<CR>', opts) -- kill all other buffers
map('n', '<leader>z', '<CMD>NeoZoomToggle<CR>', opts)

-- pretend we're magit
local term_base = '<CMD>hi FloatermBorder guifg=lightsteelblue1<CR>'
                      .. '<CMD>FloatermNew --width=0.9 --height=0.9 '
                      .. '--borderchars=─│─│╭╮╯╰ '
                      .. '--autoclose='
map('n', '<leader>t', term_base .. '1 /bin/zsh<CR>', opts)
map('n', '<leader>g', term_base .. '1 lazygit<CR>', opts)
map('n', '<leader>gg', term_base .. '1 lazygit<CR>', opts)

-- mix tests
map('n', '<leader>mt', term_base .. '0 mix test<CR>', opts)
map('n', '<leader>mf', term_base .. '0 mix test %<CR>', opts)
map('n', '<leader>mF',
    term_base .. '0 cd apps/arcamax_web && mix assets.fix<CR>', opts)

-- common code-related doings
map('n', 'gd', '<CMD>lua require"telescope.builtin".lsp_definitions()<CR>', opts)
map('n', 'gr', '<CMD>lua require"telescope.builtin".lsp_references()<CR>', opts)
map('n', '<leader>d',
    '<CMD>lua require"telescope.builtin".diagnostics({bufnr = 0})<CR>', opts)
map('n', '<leader>D', '<CMD>lua require"telescope.builtin".diagnostics()<CR>',
    opts)
map('n', '<leader>rn', '<CMD>lua require"lspsaga.rename".rename()<CR>', opts)

-- show doc for symbol
map('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>', opts)
map('v', 'K', '"zy<CMD>Dash <C-r>d<CR>', opts)

-- open/close vim configs
local dotfiles = '~/dotfiles/nvim/.config/nvim'
local config_edit = '<CMD>tabnew ' .. dotfiles .. '/lua/plugins/init.lua<CR>'
                        .. '<CMD>vsplit ' .. dotfiles .. '/lua/keymaps.lua<CR>'
                        .. '<CMD>split ' .. dotfiles .. '/init.lua<CR>'
                        .. '<C-w><RIGHT><CMD>split<CR><CMD>e ' .. dotfiles
                        .. '/lua/plugins<CR>'
map('n', '<leader>v', config_edit, opts)
map('n', '<leader>vo', config_edit .. '<C-w><LEFT><CR>', opts)
map('n', '<leader>vp', config_edit .. '<C-w><DOWN><CR>', opts)
map('n', '<leader>vk', config_edit .. '<C-w><DOWN><CR><C-w><LEFT><CR>', opts)

map('n', '<leader>V',

    '<CMD>bdelete<CR><CMD>bdelete<CR><CMD>bdelete<CR><CMD>bdelete<CR>', opts)
