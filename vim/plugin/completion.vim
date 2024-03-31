"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" completion & auto-popmenu plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sources :
"   - . : current buffer
"   - t : tags
"   - k : dictionary
"   - w : buffers from other windows
"   - b : other loaded buffers in buffer list
" see ':help cpt'
set cpt=.,t,k,w,b

" set completeopt+=menuone
" set completeopt+=noinsert
" set shortmess+=c

" Don't select the first item.
set completeopt=menu,menuone,noselect

" Suppress annoying messages
set shortmess+=c

" Search down into subfolders with find command
" Provides tab completion for all file-related tasks
set path=**;,.,./rtl,./include,../stimuli/include,./sw/include,*,**

" Tag file defaut paths
set tags=tags,./tags,./../tags,./*/tags
