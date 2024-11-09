let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +466 ~/dotfiles/nvim/.config/nvim/lua/plugins/init.lua
badd +1 ~/dotfiles/nvim/.config/nvim/lua/keymaps.lua
badd +4 ~/dotfiles/nvim/.config/nvim/init.lua
badd +1 ~/dotfiles/nvim/.config/nvim/lua/plugins/trouble/init.lua
badd +26 ~/dotfiles/nvim/.config/nvim/lua/plugins/telescope/init.lua
argglobal
%argdel
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
argglobal
enew
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
tabnext
edit ~/dotfiles/nvim/.config/nvim/init.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
balt ~/dotfiles/nvim/.config/nvim/lua/keymaps.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 4 - ((3 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 4
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/dotfiles/nvim/.config/nvim/lua/keymaps.lua", ":p")) | buffer ~/dotfiles/nvim/.config/nvim/lua/keymaps.lua | else | edit ~/dotfiles/nvim/.config/nvim/lua/keymaps.lua | endif
if &buftype ==# 'terminal'
  silent file ~/dotfiles/nvim/.config/nvim/lua/keymaps.lua
endif
balt ~/dotfiles/nvim/.config/nvim/init.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 239 - ((0 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 239
normal! 08|
wincmd w
argglobal
if bufexists(fnamemodify("~/dotfiles/nvim/.config/nvim/lua/plugins/telescope/init.lua", ":p")) | buffer ~/dotfiles/nvim/.config/nvim/lua/plugins/telescope/init.lua | else | edit ~/dotfiles/nvim/.config/nvim/lua/plugins/telescope/init.lua | endif
if &buftype ==# 'terminal'
  silent file ~/dotfiles/nvim/.config/nvim/lua/plugins/telescope/init.lua
endif
balt ~/dotfiles/nvim/.config/nvim/lua/plugins/trouble/init.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 26 - ((7 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 26
normal! 032|
wincmd w
argglobal
if bufexists(fnamemodify("~/dotfiles/nvim/.config/nvim/lua/plugins/init.lua", ":p")) | buffer ~/dotfiles/nvim/.config/nvim/lua/plugins/init.lua | else | edit ~/dotfiles/nvim/.config/nvim/lua/plugins/init.lua | endif
if &buftype ==# 'terminal'
  silent file ~/dotfiles/nvim/.config/nvim/lua/plugins/init.lua
endif
balt ~/dotfiles/nvim/.config/nvim/lua/keymaps.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 475 - ((0 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 475
normal! 010|
wincmd w
wincmd =
tabnext 2
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
