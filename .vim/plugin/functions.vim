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
