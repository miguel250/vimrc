"
" VIM functions
"

" fzf
" Jump to file if file is already opened
function! s:GotoOrOpen(command, ...)
  for file in a:000
    let a:bufnr = win_findbuf(bufnr(file))
    if len(a:bufnr) == 0
      exec a:command . ' ' . file
    else
      call win_gotoid(a:bufnr[0])
    endif
  endfor
endfunction

command! -nargs=+ GotoOrOpen call s:GotoOrOpen(<f-args>)

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" coc
function! Show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! Check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Plug
function! AsyncDo(command)
  if has('nvim')
    return printf(':tabnew | call termopen(%s) | tabprev', string(a:command))
  elseif exists('$TMUX_PANE')
    return printf('tmux new-window -d "%s"', escape(a:command, '"'))
  endif
  return a:command
endfunction


" Emmet
function! Is_emmet_expandable()
  return exists('g:loaded_emmet_vim') && &filetype=~? 'html' && emmet#isExpandable()
endfunction
