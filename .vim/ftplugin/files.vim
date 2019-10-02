"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open templates when editing a new file.
" Setup here else the template loaded is written twice
" in the new file (previously was in files.vim).
au bufNewFile *.cpp 0r      ~/.vim/templates/template.cpp
au bufNewFile *.h 0r        ~/.vim/templates/template.h
au bufNewFile *.v 0r        ~/.vim/templates/template.v
au bufNewFile *.html 0r     ~/.vim/templates/template.html
au bufNewFile *.py 0r       ~/.vim/templates/template.py
au bufNewFile *.scala 0r    ~/.vim/templates/template.scala

" Colorize ANSI escape codes by default with AnsiEsc plugin
autocmd BufRead *.{log,txt} AnsiEsc

" Run systemVerilog plugin for these file extensions
au BufNewFile,BufRead *.sv, *.svh, *.vh, *.v so ~/.vim/bundle/systemverilog.vim/syntax/systemverilog.vim

" Specify JSON syntax checking for Javascript
au BufRead,BufNewFile *.json set filetype=javascript

" Specify Markdown syntax checking for these extensions
au BufRead,BufNewFile *.mkd, *.markdown, *.mdwn, *.mk, *.md set filetype=markdown

" Insert tabs, not spaces for Makefile
autocmd FileType make setlocal noexpandtab

" Vue.js setup
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
let g:vue_disable_pre_processors=1

" Configuration for Scala SBT build files
au BufRead,BufNewFile *.sbt set filetype=scala

" Use Scala style comments instead of Java style
let g:scala_scaladoc_indent = 1
