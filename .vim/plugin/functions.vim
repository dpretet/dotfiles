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

    " Prettify based on extension:
    
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


" Print tips, reminders and useful commands
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


" Run updates every week automatically when launching Vim.
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
            call execute('CocUpdate')
            call writefile([l:this_week], l:filename, 'a')
        endif
    endif
endfunction

autocmd VimEnter * call OnVimEnter()


" Functions to comment/uncomment lines selected in visual mode
function! CommentToggle()
    "does the first line begin with a comment?
    let l:line=getpos("'<")[1]
    "if there's a match
    if match(getline(l:line), '^\s*'.b:commentChar)>-1
        call Uncomment()
    else
        call Docomment()
    endif
endfunction

let b:commentChar='//'
autocmd BufNewFile,BufReadPost *.[ch]  let b:commentChar='//'
autocmd BufNewFile,BufReadPost *.cpp   let b:commentChar='//'
autocmd BufNewFile,BufReadPost *.scala let b:commentChar='//'
autocmd BufNewFile,BufReadPost *.py    let b:commentChar='#'
autocmd BufNewFile,BufReadPost *.sh    let b:commentChar='#'
autocmd BufNewFile,BufReadPost *.vim   let b:commentChar='"'

" Make comments on all the lines we've grabbed
function! Docomment ()
    execute '''<,''>s/^\s*/&'.escape(b:commentChar, '\/').' /e'
endfunction

" Uncomment on all our lines
function! Uncomment ()
    execute '''<,''>s/\v(^\s*)'.escape(b:commentChar, '\/').'\v\s*/\1/e'
endfunction

