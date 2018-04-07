" Increase revision after adding a new plugin. This will deleted
" the plugged folder and redownload all plugs.
let $plugin_revision = 5

" Load plugins
call plug#begin($VIMHOME.'/plugged/')
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/Shougo/neco-vim', {'for': 'vim'}
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/rust-lang/rust.vim', {'for': 'rst'}
Plug 'https://github.com/racer-rust/vim-racer', {'for': 'rst', 'do': 'cargo install --bin racer racer \| true'}
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/ntpeters/vim-better-whitespace'
Plug 'https://github.com/ap/vim-buftabline'
Plug 'https://github.com/fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'https://github.com/zchee/deoplete-go', {'for': 'go', 'do': 'make'}
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/morhetz/gruvbox'
call plug#end()

if !filereadable($VIMHOME.'/plugged/'.$plugin_revision.'.txt')
  for f in split(globpath($VIMHOME.'/plugged', '*.txt'), '\n')
    :call delete(f)
  endfor
endif

if !filereadable($VIMHOME.'/plugged/'.$plugin_revision.'.txt')
  :call system('echo "installing plugins"')
  :call system('touch ' . $VIMHOME.'/plugged/'.$plugin_revision.'.txt')
  :source $VIMHOME/snapshot.vim
  :source $MYVIMRC
endif


"" Rust
let g:racer_experimental_completer = 1

"" Gruvbox
set termguicolors     " enable true colors support
set background=dark   " setting dark mode
colorscheme gruvbox

"" Buftabline
highlight BufTabLineFill ctermbg=black

"" Airline
let g:airline_theme='gruvbox'

"" Enable deoplete
if stridx(&rtp,  g:plugs['deoplete.nvim'].dir) >= 1
  let g:deoplete#enable_at_startup = 1
endif

"" ack.vim configuration
if executable('ag')
  let g:ackprg = '--nogroup --nocolor'
endif

"" vim-go
let g:go_fmt_command = "goimports"

"" fzf
let g:fzf_action = {
  \ 'enter': 'vsplit'
  \ }

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
