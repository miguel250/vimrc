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

function! LC_maps()
  if !exists("g:vimrc_lang_auto_format")
    let g:vimrc_lang_auto_format = 1
  endif
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nmap   <silent> <Leader>d :call LanguageClient#textDocument_hover()<cr>
    nmap   <silent> <Leader>v :call LanguageClient#textDocument_definition({'gotoCmd':'vsplit'})<cr>

    autocmd VimEnter * inoremap <expr> <cr> ((pumvisible()) ? (deoplete#close_popup()) : ("\<cr>"))

    if g:vimrc_lang_auto_format
      autocmd BufWritePre * :call LanguageClient#textDocument_formatting_sync()
    endif
  endif
endfunction

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted setlocal signcolumn=yes
    autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END
