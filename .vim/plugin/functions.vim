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
