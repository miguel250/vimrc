" Increase revision after adding a new plugin. This will deleted
" the plugged folder and redownload all plugs.
let $plugin_revision = 11

" make sure nodejs modules are available for language client
let $PATH .= ':'. $VIMHOME. '/node_modules/.bin/'

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
Plug 'https://github.com/racer-rust/vim-racer', {'for': 'rst', 'do': 'cargo install --force --bin racer racer \| true'}
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/ntpeters/vim-better-whitespace'
Plug 'https://github.com/ap/vim-buftabline'
Plug 'https://github.com/fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries'}
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/elzr/vim-json', {'for' : 'json'}
Plug 'https://github.com/HerringtonDarkholme/yats.vim'
Plug 'https://github.com/Shougo/neosnippet.vim'
Plug 'https://github.com/Shougo/neosnippet-snippets'
Plug 'https://github.com/autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
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

"" indentLine
let g:indentLine_enabled = 1

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
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif


"" fzf
let g:fzf_layout = { 'down': '~20%' }

let g:fzf_action = {
  \ 'enter': 'GotoOrOpen vsplit'
  \ }

" deoplete-go settings
let g:deoplete#sources#go#builtin_objects = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" vim-go
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_info_mode = "gocode"
let g:go_def_mode = "guru"
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_test_show_name = 1
let g:go_def_reuse_buffer = 1
let g:go_auto_type_info = 1
let g:go_echo_command_info = 1
let g:go_autodetect_gopath = 1
let g:go_highlight_operators = 1
let g:go_gocode_propose_source = 1
let g:go_highlight_function_parameters = 1


" vim json
let g:vim_json_syntax_conceal = 0
let g:neosnippet#enable_complete_done = 1

"LanguageClient-neovim
let g:LanguageClient_hasSnippetSupport = 1
let g:LanguageClient_serverCommands = {
  \ 'go': ['bingo'],
  \ 'typescript.tsx': ['typescript-language-server', '--stdio'],
  \ 'typescript': ['typescript-language-server', '--stdio'],
  \ 'javascript': ['typescript-language-server', '--stdio'],
  \}
