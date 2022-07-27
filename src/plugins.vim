" Increase revision after adding a new plugin. This will deleted
" the plugged folder and redownload all plugs.
let $plugin_revision = 29

" make sure nodejs modules are available for language client
let $PATH .= ':'. $VIMHOME. '/node_modules/.bin/'

" Load plugins
call plug#begin($VIMHOME.'/plugged/')
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/Shougo/neco-vim', {'for': 'vim'}
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/cakebaker/scss-syntax.vim'
Plug 'https://github.com/ntpeters/vim-better-whitespace'
Plug 'https://github.com/ap/vim-buftabline'
Plug 'https://github.com/fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries'}
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/kamykn/spelunker.vim'
Plug 'https://github.com/kamykn/popup-menu.nvim'
Plug 'https://github.com/elzr/vim-json', {'for' : 'json'}
Plug 'https://github.com/HerringtonDarkholme/yats.vim'
Plug 'https://github.com/neoclide/coc.nvim'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/cespare/vim-toml'

if filereadable($VIMHOME.'/local_plugins.vim')
  :source $VIMHOME/local_plugins.vim
endif
call plug#end()


if !filereadable($VIMHOME.'/plugged/'.$plugin_revision.'.txt')
  for f in split(globpath($VIMHOME.'/plugged', '*.txt'), '\n')
    :call delete(f)
  endfor
  :call delete($VIMHOME.'/plugged/coc', 'rf')
endif

if !filereadable($VIMHOME.'/plugged/'.$plugin_revision.'.txt')
  :call system('echo "installing plugins"')
  :call system('touch ' . $VIMHOME.'/plugged/'.$plugin_revision.'.txt')
  :source $VIMHOME/src/snapshot.vim
  :source $MYVIMRC
endif

let g:spelunker_check_type = 2

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
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1


"" ack.vim configuration
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif


"" fzf
let g:fzf_layout = { 'down': '~20%' }
let $FZF_DEFAULT_OPTS = '--bind alt-j:down,alt-k:up'

let g:fzf_action = {
  \ 'enter': 'GotoOrOpen vsplit'
  \ }

" vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_fmt_autosave = 0
let g:go_code_completion_enabled = 0
let g:go_test_show_name = 1
let g:go_def_reuse_buffer = 1
let g:go_auto_type_info = 1
let g:go_echo_command_info = 0
let g:go_highlight_operators = 1
let g:go_gocode_propose_source = 1
let g:go_highlight_function_parameters = 1
let g:go_gocode_unimported_packages = 1
let g:go_metalinter_autosave = 1

" vim json
let g:vim_json_syntax_conceal = 0
let g:neosnippet#enable_complete_done = 1

" Emmet
let g:user_emmet_complete_tag = 1
let g:emmet_install_only_plug = 1

" Coc
let g:airline#extensions#coc#enabled = 1
let g:coc_data_home = $VIMHOME.'/plugged/coc'
let g:coc_global_extensions = [
      \ 'coc-json@1.3.6',
      \ 'coc-tsserver@1.8.6',
      \ 'coc-yaml@1.4.2',
      \ 'coc-emmet@1.1.6',
      \ 'coc-css@1.2.6',
      \ 'coc-html@1.4.1',
      \ 'coc-explorer@0.18.14',
      \ ]

