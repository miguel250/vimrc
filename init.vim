" VIM directory
let $VIMHOME = fnamemodify(resolve(expand('<sfile>:p')), ':h') 

" Load plugins
call plug#begin($VIMHOME.'/plugged/')
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/Shougo/neco-vim', {'for': 'vim'}
Plug 'https://github.com/fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/mileszs/ack.vim'
call plug#end()

if !isdirectory($VIMHOME.'/plugged/')
    :source $VIMHOME/snapshot.vim
    :source $MYVIMRC 
endif

if stridx(&rtp,  g:plugs['deoplete.nvim'].dir) >= 1
    call deoplete#enable()
endif

if executable('ag')
  let g:ackprg = '--nogroup --nocolor'
endif

"
" Settings
" Use :option to see all available options
"
set nocompatible
filetype off                    " Disable file type detection
filetype plugin indent on       " Enable indent detection

syntax enable

set showcmd                     " Display current command
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create backup files
set nowritebackup               " Don't create backup file while editing file
set encoding=utf-8              " Set default encoding
set laststatus=2                " Always show status bar
set hidden                      " Keep change buffer without writing them to disk  
set ruler                       " Show the cursor position all the time
set noerrorbells                " No beeps
set number                      " Show line numbers
set ignorecase                  " Case insensitive search
set smartcase 			        " Don't ignore case if pattern starts with upper case

set lazyredraw                  " Don't redraw while executing macros (good performance config)
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current 
let g:netrw_liststyle=3         " netrw tree view

set tabstop=2                   " Number of spaces to convert a tab
set shiftwidth=2                " Number of spaces to use for auto indenting
set expandtab                   " Convert tabs into spaces

set smarttab                    " Insert tabs on the start of a line according to shiftwidth 
set autoindent
set complete-=i
set showmatch
"
" Keys mapping for Insert mode
" Use :help index to see all keymaps
"
imap jk <ESC>l

" Disable arrow keys
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

imap <Up>    <NOP>
imap <Down>  <NOP>
imap <Left>  <NOP>
imap <Right> <NOP>

map <leader>ss :setlocal spell!<cr> " Toggle spelling check
