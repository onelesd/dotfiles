local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

require('packer').startup(function(use)
  -- packer packer
  use 'wbthomason/packer.nvim'

  -- git blame in virtual text
  use 'f-person/git-blame.nvim'

  -- nice colors
  use 'tjdevries/colorbuddy.nvim'
  use 'rafamadriz/neon'
  use 'shaunsingh/nord.nvim'
  use 'rmehri01/onenord.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'folke/tokyonight.nvim'
  use 'rebelot/kanagawa.nvim'
  use {'catppuccin/nvim', as = 'catppuccin'}

  -- fancy highlighting and other cool code parsing stuff
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag'
  use 'RRethy/nvim-treesitter-textsubjects'
  -- use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- use 'nvim-treesitter/nvim-treesitter-refactor'

  -- make netrw more awesome
  -- there is an unfortunate bug whereby these buffers are not deletable
  -- use 'tpope/vim-vinegar'

  use 'jeetsukumaran/vim-filebeagle'

  -- open and work with repl's in various languages
  use {
    'jpalardy/vim-slime',
    config = function()
      vim.g.slime_target = 'neovim'
    end
  }

  -- go to the last place you were in a file when re-opening it
  use {
    'ethanholz/nvim-lastplace',
    config = function()
      require'nvim-lastplace'.setup {}
    end
  }

  -- comment(ary)
  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup {}
    end
  }

  -- auto brackets
  use 'windwp/nvim-autopairs'

  -- web devicons
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        -- your personnal icons can go here (to override)
        -- DevIcon will be appended to `name`
        override = {
        },
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true
      }
    end
  }

  -- status line
  use 'nvim-lualine/lualine.nvim'

  -- git signs in the gutter
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
    end
  }

  -- floating terminal
  use 'voldikss/vim-floaterm'

  -- session manager
  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'info',
        auto_session_suppress_dirs = {'~/'}
      }
    end
  }

  -- better matchit
  -- use 'andymass/vim-matchup'

  -- delete buffers without messing up layout
  use 'famiu/bufdelete.nvim'

  -- helpers for working with lsp
  -- use 'neovim/nvim-lspconfig'

  -- automatic installation & configuration of lsp servers
  -- use 'williamboman/nvim-lsp-installer'
  -- use {
  --   'kosayoda/nvim-lightbulb',
  --   config = function()
  --     vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  --   end
  -- }

  -- use 'evanleck/vim-svelte'
  -- use 'elixir-editors/vim-elixir'

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/nvim-lsp-installer'},
      {'jose-elias-alvarez/nvim-lsp-ts-utils'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  use 'jose-elias-alvarez/null-ls.nvim'

  -- telescope is for finding and searching files
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-project.nvim'},
      {'natecraddock/telescope-zf-native.nvim'},
      {'nvim-telescope/telescope-frecency.nvim'},
      {'kkharji/sqlite.lua'},
      {
        'benfowler/telescope-luasnip.nvim',
        module = 'telescope._extensions.luasnip'
      }
    }
  }

  -- ui sugar for lsp
  use 'tami5/lspsaga.nvim'

  -- autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-buffer'},
      {'saadparwaiz1/cmp_luasnip'}
    }
  }

  use {
    'L3MON4D3/LuaSnip', -- powerful snippets
    requires = {
      'rafamadriz/friendly-snippets' -- common snippets for various languages
    },
    config = function()
      require'luasnip.loaders.from_vscode'.load()
    end
  }

  -- show nice icons in completion popups and other places
  use 'onsails/lspkind-nvim'

  -- lookup docs in Dash
  -- use {'mrjones2014/dash.nvim', run = 'make install'}

  -- zoom/unzoom a window
  -- use 'nyngwang/NeoZoom.lua'

  use 'folke/trouble.nvim'

  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require"gitlinker".setup({
        mappings = nil,
      })
    end
  }

  -- adds indentation guides using virtual text
  use 'lukas-reineke/indent-blankline.nvim'

  -- highlight trailing whitespace
  -- :StripWhitespace removes all extra whitespace
  use 'ntpeters/vim-better-whitespace'

  -- provides various commands
  -- :Delete, :Move, :Rename, others...
  use 'tpope/vim-eunuch'

  -- this has nice folding but only works well with hjkl
  -- use {
  --   'anuvyklack/pretty-fold.nvim',
  --   config = function()
  --     require('pretty-fold').setup {}
  --     require('pretty-fold.preview').setup({key = 'h'})
  --   end
  -- }

  -- make mapping keys easier
  -- use 'svermeulen/vimpeccable'

  -- supercharge <C-x> & <C-a> to increment words, like true/false, enabled/disabled
  use 'Konfekt/vim-CtrlXA'

  -- for working with csv files. wee: https://github.com/chrisbra/csv.vim
  use {
    'chrisbra/csv.vim',
    config = function()
      vim.cmd [[
        augroup filetypedetect
          au! BufRead,BufNewFile *.csv.gz	setfiletype csv
        augroup END
      ]]
    end
  }

  if packer_bootstrap then require('packer').sync() end
end)

-- leave at bottom so packages can be installed before we try working with them
require('plugins/nord')
-- require('plugins/catppuccin')
-- require('plugins/lsp-installer')
require('plugins/null-ls')
require('plugins/lsp-zero')
require('plugins/lspsaga')
require('plugins/treesitter')
require('plugins/telescope')
require('plugins/lualine')
require('plugins/autopairs')
require('plugins/indent-blankline')
require('plugins/trouble')
require('plugins/snippets')
-- require('plugins/tree')
