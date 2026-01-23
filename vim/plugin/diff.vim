augroup diffcolors
    autocmd!
    autocmd Colorscheme * call s:SetDiffHighlights()
augroup END

function! s:SetDiffHighlights()
    if &background == "dark"
        highlight DiffAdd gui=bold guifg=NONE guibg=#2e4b2e
        highlight DiffDelete gui=bold guifg=NONE guibg=#4c1e15
        highlight DiffChange gui=bold guifg=NONE guibg=#45565c
        highlight DiffText gui=bold guifg=NONE guibg=#996d74
    else
        highlight DiffAdd gui=bold guifg=NONE guibg=palegreen
        highlight DiffDelete gui=bold guifg=NONE guibg=tomato
        highlight DiffChange gui=bold guifg=NONE guibg=lightblue
        highlight DiffText gui=bold guifg=NONE guibg=lightpink
    endif
endfunction
