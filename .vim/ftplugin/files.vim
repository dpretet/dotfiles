"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Strip whitespaces and tabs on buffer write
autocmd BufWritePre <buffer> :call StripWsTabs()

" Open templates when editing a new file.
au bufNewFile *.c 0r        ~/.vim/templates/template.c
au bufNewFile *.cpp 0r      ~/.vim/templates/template.cpp
au bufNewFile *.h 0r        ~/.vim/templates/template.h
au bufNewFile *.v 0r        ~/.vim/templates/template.v
au bufNewFile *.sv 0r       ~/.vim/templates/template.sv
au bufNewFile *.html 0r     ~/.vim/templates/template.html
au bufNewFile *.py 0r       ~/.vim/templates/template.py
au bufNewFile *.sh 0r       ~/.vim/templates/template.sh

" Colorize ANSI escape codes by default with AnsiEsc plugin for txt and log extension
autocmd BufRead *.{log,txt} AnsiEsc

" Specify JSON syntax checking for Javascript
au BufRead,BufNewFile *.json set filetype=javascript

" Specify Markdown syntax checking for these extensions
au BufRead,BufNewFile *.mkd, *.md, *.txt set filetype=markdown.pandoc

" Insert tabs, not spaces for Makefile
autocmd FileType make setlocal noexpandtab
