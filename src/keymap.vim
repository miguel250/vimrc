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

"" rotate window
nmap <leader>k <C-W>K
nmap <leader>j <C-W>J
nmap <leader>l <C-W>L
nmap <leader>h <C-W>H

"" swap windows
nnoremap <silent><leader>sw :call WinBufSwap()<CR>

"" focus windows
nnoremap <silent><leader>m :wincmd _<Bar>wincmd <Bar><CR>
nnoremap <silent><leader>r <C-W>=

"" resize windows
nnoremap <silent> <A-UP>   :call MoveSeparator("-", 0)<CR>
nnoremap <silent> <A-DOWN> :call MoveSeparator("+", 0)<CR>
nnoremap <silent><leader>[   :call MoveSeparator("-", 1)<CR>
nnoremap <silent><leader>] :call MoveSeparator("+", 1)<CR>

"" Split all buffers
nnoremap <silent><leader>sb :vertical sball<CR>

" Buffer prev/next
nnoremap <silent><leader>x :bnext<CR>
nnoremap <silent><leader>z :bprev<CR>

" Vinege
map <silent> - :CocCommand explorer<CR>

" Yank to system clipboad
vnoremap <silent> y y:call system('yank', @0)<Return>

" fzf
nnoremap <silent> <C-p> :FZF<CR>
imap <C-p> <esc>:<C-u> :FZF<cr>

" search
nmap <C-p> :History<cr>
imap <C-p> <esc>:<C-u>History<cr>

" reload vim configuration
nnoremap <silent> <F1> :source $MYVIMRC<CR>

" vim-go
nmap <C-g> :GoDecls<cr>

inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

nmap <silent> <Leader>d :call Show_documentation()<CR>
nmap <silent> <Leader>v  <Plug>(coc-definition)

imap <expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ Is_emmet_expandable() ?  emmet#expandAbbrIntelligent("\<tab>") :
      \ Check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <silent><expr> <c-space> coc#refresh
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Term
tnoremap jk <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

nnoremap <silent> <leader>t :call Small_terminal()<CR>

" FZF
nmap <leader><tab> :RG<CR>
