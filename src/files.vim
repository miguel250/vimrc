" ----------------------------------------- "
" File Type settings                        "
" ----------------------------------------- "
" spell check for all files
augroup TermDetect
    au!
    au TermOpen term://*  set filetype=term
augroup END

autocmd! BufWinEnter,InsertLeave * if index(['term'], &ft) < 0 |  call spelunker#words#check_display_area()

" fix issue with vinegar and not being able to close netrw
autocmd FileType netrw setl bufhidden=wipe

" close netrw buffer
autocmd FileType netrw nmap <silent> <buffer> - :call  ToggleVExplorer() <cr>

" close fzf if open
autocmd FileType fzf tnoremap <C-a> <Esc>

" scss-syntax
au BufRead,BufNewFile *.scss set filetype=scss.css

" coc
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

autocmd TermOpen * setlocal nonumber norelativenumber

