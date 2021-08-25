"
" VIM functions
"

" fzf
" Jump to file if file is already opened
function! GotoOrOpen(command, ...)
  for file in a:000
    let result = win_findbuf(bufnr(file))
    if len(result) == 0
      exec a:command . ' ' . file
    else
      call win_gotoid(result[0])
    endif
  endfor
endfunction

command! -nargs=+ GotoOrOpen call GotoOrOpen(<f-args>)

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
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

function! Small_terminal() abort
  new
  wincmd J
  call nvim_win_set_height(0, 10)
  set winfixheight
  term
endfunction


function! WinBufSwap()
  let thiswin = winnr()
  let thisbuf = bufnr("%")
  let lastwin = winnr("#")
  let lastbuf = winbufnr(lastwin)

  exec  lastwin . " wincmd w" ."|".
      \ "buffer ". thisbuf ."|".
      \ thiswin ." wincmd w" ."|".
      \ "buffer ". lastbuf
endfunction

function! MoveSeparator(PlusMinus, Vertical)
    let num=tabpagewinnr(tabpagenr())
    let pm=a:PlusMinus
    let vertical=a:Vertical
    if  num == "2"
        let pm = pm == '+' ? '-' : '+'
    end
    if vertical == 1
      exec "vertical resize " . pm . (winheight(0) * 2/3)
      return
    end
    exec "resize " . pm . "1"
endfunction


function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
