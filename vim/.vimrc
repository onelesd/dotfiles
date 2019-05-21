set nocompatible              " be iMproved, required

filetype plugin indent on

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'raimondi/delimitmate'
Plug 'felixhummel/setcolors.vim'
Plug 'flazz/vim-colorschemes'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'ntpeters/vim-better-whitespace'
Plug 'elixir-lang/vim-elixir'
Plug 'vim-scripts/L9'
Plug 'tmhedberg/matchit'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'gkz/vim-ls'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'slashmili/alchemist.vim'
Plug 'hashivim/vim-terraform'
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neomake/neomake'
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'severin-lemaignan/vim-minimap'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

call plug#end()

" let g:neomake_elixir_enabled_makers = ['credo']
" makers break the live code reloader in elixir 1.4.0
let g:neomake_elixir_enabled_makers = []
let g:neomake_elixir_mix_maker = {
      \ 'exe': 'mix',
      \ 'args': ['compile', '%:p', '--warnings-as-errors'],
      \ 'errorformat':
      \ '** %s %f:%l: %m,' .
      \ '%f:%l: warning: %m'
      \ }
let g:neomake_elixir_credo_maker = {
      \ 'exe': 'mix',
      \ 'args': ['credo', 'list', '%:p', '--format=oneline', '-a', '--strict', '-i', 'readability'],
      \ 'errorformat': '[%t] %. %f:%l:%c %m'
      \ }
let g:neomake_open_list = 2
let g:neomake_list_height = 4
let g:neomake_serialize = 1
"let g:neomake_serialize_abort_on_error = 1
let g:neomake_verbose = 2
autocmd! BufWritePost *.ex Neomake
autocmd! BufWritePost *.exs Neomake
" autocmd! BufReadPost *.ex Neomake
" autocmd! BufReadPost *.exs Neomake

let g:alchemist_tag_disable = 1

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:gutentags_cache_dir = '~/.tags_cache'

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.fzf-history'

let g:session_autosave = 'no'
let g:session_autoload = 'no'

" tab = this many spaces
set tabstop=2

" use modelines: #vim ft=elixir
set modeline

" read up to this many modelines
set modelines=4

" how many spaces to change indentation with << and >>
set shiftwidth=2

" copy indent from previous line when moving to new line
set autoindent

" Delete comment character when joining commented lines
set formatoptions+=j

" try to intelligently make extra indents (when in function bodies for
" example)
set smartindent

" always have a status line
set laststatus=2

" use spaces instead when pressing tab in insert mode
set expandtab

" ignore case for searches
"set ignorecase

" ignore ignorecase when the search pattern has uppercase letters
"set smartcase

" when file changes outside of vim, and vim buffer is unchanged, reread file
" automatically
set autoread

" convert all tabs to spaces when file is loaded
retab

" useful cursor highlighting for indent-style languages like livescript
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" make folds based on indentation
set foldmethod=indent

" highlight all matches for searches
set hlsearch

" don't create backup files automatically
set nobackup

" use \ as <Leader>
let mapleader="\\"

" set number of colors available
set t_Co=256

" use solarzied colorscheme
syntax enable
set background=dark
" colorscheme PaperColor
" colorscheme solarized
colorscheme dracula
" help Terminal.app use the right colors for our theme
if !has('gui_running')
    " Compatibility for Terminal
    let g:solarized_termtrans=1

    " Make Solarized use 16 colors for Terminal support
    let g:solarized_termcolors=256
endif

" silence bell and use visual flash instead
set visualbell

" try to match as search terms are typed
set incsearch

" make %s/search/replace/ search & replace global by default (negate with %s/search/replace/g)
set gdefault

" set cwd to directory file is in
nnoremap <Leader>h :cd %:p:h<CR>:pwd<CR>

" make a xml structure pretty
noremap <Leader>x <Esc>:%!xmllint --format -<CR>

" make a json structure pretty
noremap <Leader>j <Esc>:%!json_xs -f json -t json-pretty<CR>

" syntax highlighting can break, re-init with this
noremap <Leader>s <Esc>:syntax sync fromstart<CR>

" make pasting simpler
noremap <Leader>p <Esc>:set nopaste<CR>mzo<Esc>:set paste<CR>a

" disable paste mode
noremap <Leader>P <Esc>:set nopaste<CR>

"=====[ Miscellaneous features (mainly options) ]=====================

set title "Show filename in titlebar of window
set titleold=

"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 50 files
"           | |   +--Remember up to 10000 lines in each register
"           | |   |      +--Remember up to 1MB in each register
"           | |   |      |     +--Remember last 1000 search patterns
"           | |   |      |     |     +---Remember last 1000 commands
"           | |   |      |     |     |
"           v v   v      v     v     v
set viminfo=h,'50,<10000,s1000,/1000,:1000

set backspace=indent,eol,start "BS past autoindents, line boundaries,
                               " and even the start of insertion
                               "
set fileformats=unix,mac,dos "Handle Mac and DOS line-endings
                             "but prefer Unix endings

set scrolloff=2 "Scroll when 2 lines from top/bottom

set ruler "Show cursor location info on status line

"====[ Use persistent undo ]=================
if has('persistent_undo')
    set undodir=$HOME/tmp/.VIM_UNDO_FILES
    set undolevels=5000
    set undofile
endif

" let vim know we have a mouse
if has("mouse")
  set mouse=a
endif

" remap ; to :
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" \e opens dir list in current files parent dir
nnoremap <Leader>e <C-w>v:e <C-R>=expand('%:p:h') . '/'<CR><CR>

" nerdtree hotkey
nnoremap <Leader>n :NERDTreeToggle<CR>

function! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" FZF hotkey
nnoremap <Leader>f :FZF<CR>

" FZF using grep hotkey
nnoremap <leader>F :Ag<CR>
"vnoremap <script> <leader>f "+ygv<Esc>:Ag <C-R><C-R>=<SID>get_visual_selection()<CR>
"vnoremap <script> <leader>F "+ygv<Esc>:Ag<CR>

" copy (in visual mode) with ctrl-c & ctrl-v
vnoremap <C-c> "+y
" messes with visual block mode
"noremap <C-v> "+p

set termguicolors

let $PATH='$HOME/.cargo/bin:/usr/bin:/usr/local/bin:/bin:/usr/sbin:/sbin'
