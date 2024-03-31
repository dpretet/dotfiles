vim9script

# BufClose.vim  -  Close a buffer without closing the window it's in.
#
# Copyright 2003 - 2022 by Christian J. Robinson <heptite@gmail.com>
#
# Distributed under the terms of the Vim license.  See ":help license".

# Usage:
#
# :BufClose[!] [buffer]
#
# Without any arguments the current buffer in the current window is closed.
# With an argument that buffer is closed if it exists and is currently being
# displayed in a window.
#
# The buffer argument can be a buffer name or number.
#
# In both cases if the buffer is modified you have to use ! or an error will
# be issued and the buffer will be left loaded.
#
# Configuration:
#
# g:BufClose_AltBuffer
#
# Set this variable if you don't want a blank buffer to be loaded in place of
# the buffer being closed.  Examples:
#
#   :let g:BufClose_AltBuffer = '#'
#
# This will cause :BufClose to load the alternate buffer.  See ":help :_#".
#
#   :let g:BufClose_AltBuffer = '.'
#
# This will cause :BufClose to load the current directory in the file
# explorer.

command! -nargs=? -complete=buffer -bang BufClose {
        BufClose('<args>', '<bang>')
    }

def g:BufClose(b: string, bang: string)
    var buffer: number

    if b == ''
        # No buffer provided, use current buffer in the current window.
        buffer = bufnr('%')
    elseif str2nr(b) > 0
        # A buffer number was provided.
        buffer = bufnr(str2nr(b))
    else
        # A buffer name was provided.
        buffer = bufnr(b)
    endif

    if buffer < 0
        echohl ErrorMsg
        echomsg 'No matching buffer: ' .. b
        echohl None
        return
    endif

    var current_window = winnr()
    var buffer_window = bufwinnr(buffer)

    if buffer_window < 0
        echohl ErrorMsg
        echomsg "Buffer " .. buffer .. " isn't open in any windows"
        echohl None
        return
    endif

    if bang == '' && getbufvar(buffer, '&modified')
        echohl ErrorMsg
        echomsg 'No write since last change for buffer ' ..
            buffer .. ' (add ! to override)'
        echohl None
        return
    endif

    # Move to the proper window if necessary, open a blank buffer,
    # then move back to the original window...
    if buffer_window >= 0
        if current_window == buffer_window
            if exists('g:BufClose_AltBuffer')
                exe 'e' .. bang .. ' ' .. g:BufClose_AltBuffer
            else
                exe 'enew' .. bang
            endif
        else
            exe 'norm ' .. buffer_window .. "\<C-w>w"
            if exists('g:BufClose_AltBuffer')
                exe 'e' .. bang .. ' ' .. g:BufClose_AltBuffer
            else
                exe 'enew' .. bang
            endif
            exe 'norm ' .. current_window .. "\<C-w>w"
        endif
    endif

    # ...and delete the specified buffer.
    silent exe 'bdel' .. bang .. ' ' .. buffer
enddef

# vim:et:ts=4:sw=4:
