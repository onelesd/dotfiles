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

  -- nice colors
  use 'tjdevries/colorbuddy.nvim'
  use 'rafamadriz/neon'
  use 'shaunsingh/nord.nvim'

  -- fancy highlighting
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  -- use 'nvim-treesitter/nvim-treesitter-textobjects'

  use {'ethanholz/nvim-lastplace', config = require'nvim-lastplace'.setup {}}

  -- use {'nvim-treesitter/nvim-treesitter-refactor'}

  -- comment(ary)
  use {
    'terrortylor/nvim-comment',
    config = function()
      require'nvim_comment'.setup {}
    end
  }

  -- auto brackets
  use {
    'windwp/nvim-autopairs',
    config = function()
      require'nvim-autopairs'.setup {}
    end
  }

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

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

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  use 'evanleck/vim-svelte'
  use 'elixir-editors/vim-elixir'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-project.nvim'},
      -- {'nvim-telescope/telescope-ui-select.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
      {
        'benfowler/telescope-luasnip.nvim',
        module = 'telescope._extensions.luasnip'
      }
    }
  }

  use 'tami5/lspsaga.nvim'
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-buffer'},
      {'saadparwaiz1/cmp_luasnip'}
    }
  }
  use 'rafamadriz/friendly-snippets'

  use {'L3MON4D3/LuaSnip'}

  use 'onsails/lspkind-nvim'

  use {'mrjones2014/dash.nvim', run = 'make install'}

  use 'nyngwang/NeoZoom.lua'

  use 'lukas-reineke/indent-blankline.nvim'

  use 'ntpeters/vim-better-whitespace'

  use 'junegunn/limelight.vim'

  -- use 'yamatsum/nvim-cursorline'

  use 'tpope/vim-eunuch'

  if packer_bootstrap then require('packer').sync() end
end)

-- leave at bottom so packages can be installed before we try working with them
require('colorbuddy').colorscheme('nord')
require('plugins/neon')
require('plugins/lsp-installer')
require('plugins/treesitter')
require('plugins/telescope')
require('plugins/lualine')
require('plugins/autopairs')
require('plugins/indent-blankline')
