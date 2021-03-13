" VIM directory
let $VIMHOME = fnamemodify(resolve(expand('<sfile>:p')), ':h')

:source $VIMHOME/src/settings.vim
:source $VIMHOME/src/keymap.vim
:source $VIMHOME/src/functions.vim
:source $VIMHOME/src/plugins.vim
:source $VIMHOME/src/files.vim

let g:python3_host_prog = $VIMHOME.'/env/bin/python'

if filereadable($VIMHOME.'/local.vim')
  :source $VIMHOME/local.vim
endif
