"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Strip whitespaces and tabs on buffer write
autocmd BufWritePre <buffer> :call StripWsTabs()

" Colorize ANSI escape codes by default with AnsiEsc plugin for txt and log extension
autocmd BufRead,BufNewFile *.{log,txt} AnsiEsc

" Specify JSON syntax checking for Javascript
autocmd BufRead,BufNewFile *.json set filetype=javascript

" C linker
autocmd BufRead,BufNewFile *.ld set filetype=ld

" RISCV ASM
autocmd BufRead,BufNewFile *.{S,s} set filetype=riscv

" Cmake
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.ctest set filetype=cmake

" Specify Markdown syntax checking for these extensions
autocmd BufRead,BufNewFile *.mkd, *.md, *.txt set filetype=markdown.pandoc

" Insert tabs, not spaces for Makefile
autocmd FileType make setlocal noexpandtab
