" VIM directory
let $VIMHOME = fnamemodify(resolve(expand('<sfile>:p')), ':h')

:source $VIMHOME/settings.vim
:source $VIMHOME/functions.vim
:source $VIMHOME/plugins.vim
:source $VIMHOME/keymap.vim
:source $VIMHOME/files.vim

