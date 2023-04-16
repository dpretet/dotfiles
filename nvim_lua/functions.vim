"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remove useless white spaces and convert tabs
function! StripWsTabs()

    " Save cursor place
    let l = line(".")
    let c = col(".")

    " Clean up spaces/tabs
    retab
    %s/\s\+$//e

    " Restore cursor
    call cursor(l, c)

endfunction


" Prettify a buffer
function! Prettify()

    " Save cursor place
    let l = line(".")
    let c = col(".")

    " Get filetype
    let _ft = &filetype

    " Use python to prettify JSON
    if _ft ==? "json"
        silent %!python -m json.tool
    " Else use Autoformat plugin
    else
        Autoformat
    endif

    " Clean up spaces/tabs and restore cursor
    call StripWsTabs()
    call cursor(l, c)

endfunction


" Run updates every week automatically when launching Vim.
autocmd VimEnter * call OnVimEnter()

function! OnVimEnter() abort
    if exists('g:plug_home')
        let l:filename = printf('%s/.vim_plug_update', g:plug_home)
        if filereadable(l:filename) == 0
            call writefile([], l:filename)
        endif

        let l:this_week = strftime('%Y_%V')
        let l:contents = readfile(l:filename)
        if index(l:contents, l:this_week) < 0
            call execute('PackUpdate')
            call writefile([l:this_week], l:filename, 'a')
        endif
    endif
endfunction


" Build Ctags using Universal Ctags
function! BuildCtags()

    silent ! touch tags
    AsyncRun! find . -name "*.sh"
                \ -o -name "*.c*"
                \ -o -name "*.h"
                \ -o -name "*.py"
                \ -o -name "*.*v"
                \ -o -name "*.vim"
                \ -exec ctags -a {} \;
endfunction


" Launch Terminal into a floating window
function! FloatTerm()

  " Configuration
  let height = float2nr((&lines - 2) * 0.8)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.8)
  let col = float2nr((&columns - width) / 2)

  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }

  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  " Decorate the buffer by adding the border
  let top = "╭" . repeat("─", width + 2) . "╮"
  let mid = "│" . repeat(" ", width + 2) . "│"
  let bot = "╰" . repeat("─", width + 2) . "╯"
  let lines = [top] + repeat([mid], height) + [bot]

  " Create the buffer
  let borderbuf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(borderbuf, 0, -1, v:true, lines)
  " Create the main floating window and fill it with the border buffer
  let s:float_term_border_win = nvim_open_win(borderbuf, v:true, border_opts)

  " Create a new buffer and new window and insert it into the previous one
  " This window will run the terminal
  let termbuf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(termbuf, v:true, opts)

  " Styling
  hi FloatWinBorder guifg=#87bb7c
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:FloatWinBorder')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:Normal')

  " Launch terminal into the new floating window
  terminal
  startinsert

  " Close border window when terminal window close
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:float_term_border_win, v:true)

endfunction



" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).

let bclose_multiple = 1

function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction

command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)


" Enhanced version of f/F function to search for a 2 char pattern
" If an argument is passed, search backward
function! MoveToPattern(...)

    let l:max_char = 2
    let l:i = 0
    let l:chars = ""

    while (i<l:max_char)
        let l:chars = l:chars . getcharstr()
        let i += 1
    endwhile

    " 'b'   search backward instead of forward
    " 'z'   start searching at the cursor column instead of Zero
    if (a:0)
        call search(l:chars, "bz")
    else
        call search(l:chars, "z")
    endif

endfunction

" Remap this feature on s/S
map s <Nop>
map S <Nop>

nnoremap <silent> s :call MoveToPattern() <CR>
nnoremap <silent> S :call MoveToPattern("b") <CR>

