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
    " Use XMLLINT to prettify XML
    elseif _ft ==? "xml"
        call PrettyXML()
    " Else use Autoformat plugin
    else
        Autoformat
    endif

    " Clean up spaces/tabs and restore cursor
    call StripWsTabs()
    call cursor(l, c)

endfunction


" Pretiffy XML files with XMLLINT
function! PrettyXML()

    " Save the filetype so we can restore it later
    let l:origft = &ft
    set ft=

    " Delete the xml header if it exists. This will
    " permit us to surround the document with fake tags
    " without creating invalid xml.
    1s/<?xml .*?>//e

    " Insert fake tags around the entire document.
    " This will permit us to pretty-format excerpts of
    " XML that may contain multiple top-level elements.
    0put ='<PrettyXML>'
    $put ='</PrettyXML>'
    silent %!xmllint --format -

    " xmllint will insert an <?xml?> header. it's easy enough to delete
    " if you don't want it.
    " delete the fake tags
    2d
    $d

    " Restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<

    " restore the filetype
    exe "set ft=" . l:origft

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
            call execute('PlugUpdate')
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

    let buf = term_start(['zsh'], #{hidden: 1, term_finish: 'close'})
    let winid = popup_create(buf, #{minwidth: winwidth(0) * 2/3,
                \ minheight: winheight(0) * 2/3,
                \ border: []})
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
