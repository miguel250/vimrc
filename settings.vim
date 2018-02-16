"
" Settings
" Use :option to see all available options
"
set nocompatible
filetype off                    " Disable file type detection
filetype plugin indent on       " Enable indent detection

syntax enable

set showcmd                     " Display current command
set showmode                    " Show current mode.
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create backup files
set nowritebackup               " Don't create backup file while editing file
set encoding=utf-8              " Set default encoding
set laststatus=2                " Always show status bar
set hidden                      " Keep change buffer without writing them to disk
set autochdir                   " change to current buffer directory
set ruler                       " Show the cursor position all the time
set noerrorbells                " No beeps
set number                      " Show line numbers
set ignorecase                  " Case insensitive search
set smartcase                   " Don't ignore case if pattern starts with upper case
set confirm                     " Confirm while closing file
set lazyredraw                  " Don't redraw while executing macros (good performance config)
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current

let g:netrw_liststyle=3         " netrw tree view
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 25

set expandtab                   " Convert tabs into spaces
set tabstop=2                   " Number of spaces to convert a tab
set shiftwidth=2                " Number of spaces to use for auto indenting
set softtabstop=2               " Number of spaces that a <Tab> counts for while performing editing operation

set smarttab                    " Insert tabs on the start of a line according to shiftwidth
set autoindent                  " Copy the indentation from the previous line
set complete-=i                 " Don't scan the current and included files
set showmatch                   " When a bracket is inserted, briefly jump to the matching one

" Make Vim to handle long lines nicely.
set wrap
set textwidth=79
set formatoptions=qrn1

" copy to system clickboard
set clipboard=unnamedplus

" Highlight column
set colorcolumn=80
