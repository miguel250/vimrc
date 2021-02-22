"
" VIM functions
"

" Toggle Vexplore
" https://stackoverflow.com/a/5636941
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

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
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! s:check_back_space() abort
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

