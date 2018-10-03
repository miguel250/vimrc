" ----------------------------------------- "
" File Type settings                        "
" ----------------------------------------- "

" spell check for git commits
autocmd FileType gitcommit setlocal spell

" fix issue with vinegar and not being able to close netrw
autocmd FileType netrw setl bufhidden=wipe

" close netrw buffer
autocmd FileType netrw nmap <silent> <buffer> - :call  ToggleVExplorer() <cr>

" close fzf if open
autocmd FileType fzf tnoremap <C-a> <Esc>

" vim-go
autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
autocmd FileType go nmap <silent> <Leader>d <Plug>(go-doc-vertical)
