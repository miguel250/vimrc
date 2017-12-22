" VIM directory
let $VIMHOME = fnamemodify(resolve(expand('<sfile>:p')), ':h')

:source $VIMHOME/plugins.vim
:source $VIMHOME/settings.vim
:source $VIMHOME/keymap.vim
:source $VIMHOME/files.vim

if stridx(&rtp,  g:plugs['deoplete.nvim'].dir) >= 1
    call deoplete#enable()
endif

if executable('ag')
  let g:ackprg = '--nogroup --nocolor'
endif

let g:airline_theme='dark_minimal'

