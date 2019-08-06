"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
