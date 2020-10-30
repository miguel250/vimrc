"
" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

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

" ========= vim-better-whitespace ==================

" auto strip whitespace except for file with extention blacklisted
let blacklist = ['markdown', 'md']
autocmd BufWritePre * StripWhitespace

map <leader>ss <Plug>(spelunker-correct-from-list)
nmap <leader>sn <Plug>(spelunker-jump-next)
nmap <leader>sp <Plug>(spelunker-jump-prev)

" trim all whitespaces away
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Buffer prev/next
nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>

" Vinege
map <silent> - :call ToggleVExplorer()<CR>

" Yank to system clipboad
vnoremap <silent> y y:call system('yank', @0)<Return>

" fzf
nnoremap <silent> <C-a> :FZF<CR>
imap <C-a> <esc>:<C-u> :FZF<cr>

" search
nmap <C-p> :History<cr>
imap <C-p> <esc>:<C-u>History<cr>

" reload vim configuration
nnoremap <silent> <F1> :source $MYVIMRC<CR>

" vim-go
nmap <C-g> :GoDecls<cr>
nmap <leader>r :call LanguageClient_textDocument_references()<CR>


inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
