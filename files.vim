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

" Language Client
autocmd FileType * call LC_maps()
