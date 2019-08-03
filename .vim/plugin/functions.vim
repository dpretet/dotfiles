"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pretiffy XML
function! PrettyXML()

    " save the filetype so we can restore it later
    let l:origft = &ft
    set ft=

    " delete the xml header if it exists. This will
    " permit us to surround the document with fake tags
    " without creating invalid xml.
    1s/<?xml .*?>//e

    " insert fake tags around the entire document.
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

    " restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<

    " restore the filetype
    exe "set ft=" . l:origft

endfunction

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

    " Prettify based on extension
    if _ft ==? "json"
        silent %!python -m json.tool
    elseif _ft == "xml"
        call PrettyXML()
    else
        "normal gg=G
        Autoformat
    endif

    " Clean up spaces/tabs and restore cursor
    call StripWsTabs()
    call cursor(l, c)

endfunction

function! PrintWorkflowInfo()

    let _info = [
      \ ' ',
      \ 'Many shortcuts available in space bar. PRESS IT!',
      \ '',
      \ '  - FZF to search buffer, file, ctags, git, text pattern',
      \ '  - Split vertically/horizontally the panel',
      \ '  - Toggle NERDTree',
      \ '  - Prettify buffer',
      \ '  - Open file under cursor',
      \ '  - Zen mode to write peacefully',
      \ '  - list, write (force), close buffer',
      \ ' ',
      \ 'Other commands among Vim and TMux:',
      \ '',
      \ '  - Vim: w/b: jump forward/backward word, e: word end',
      \ '  - Vim: )/(: jump forward/backward phrase, }/{: jump forward/backward paragraph',
      \ '  - Vim: H/M/L: jump to the high/middle/low of the screen',
      \ '  - Vim: `Ctrl-w =` to resize equally panels',
      \ '  - Vim: `Ctrl-t` on word to parse ctags, Ctrl-o to go back',
      \ '  - TMux: `Ctrl-b z` to zoom/unzoom in panel',
      \ '  - TMux: `Ctrl-b up/down/left/right` to navigate in panels',
      \ ' ',
      \]

    let i = 0
    while (i < len(_info))
        echo _info[i]
        let i += 1
    endwhile

endfunction
