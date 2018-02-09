" Load plugins
call plug#begin($VIMHOME.'/plugged/')
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/Shougo/neco-vim', {'for': 'vim'}
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/rust-lang/rust.vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/ntpeters/vim-better-whitespace'
Plug 'https://github.com/ap/vim-buftabline'
Plug 'https://github.com/fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'https://github.com/racer-rust/vim-racer'
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/ayu-theme/ayu-vim'
call plug#end()

if !isdirectory($VIMHOME.'/plugged/')
    :source $VIMHOME/snapshot.vim
    :source $MYVIMRC
endif

"" Rust
let g:racer_experimental_completer = 1

"" ayu
set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

"" Buftabline
highlight BufTabLineFill ctermbg=black
