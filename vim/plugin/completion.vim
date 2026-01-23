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

" Path completion once '.' or './' is typed
function! s:CompletePath() abort
  " Check if the current character is '.' or './'
  let l:line = getline('.')
  let l:col = col('.')
  let l:char = l:line[l:col - 2]

  if l:char == '.' || l:char == '/'
    " Trigger path completion
    call feedkeys("\<C-x>\<C-f>", 'n')
  endif
endfunction

augroup PathCompletion
  autocmd!
  " Trigger the completion function when typing '.' or './'
  autocmd TextChangedI * call s:CompletePath()
augroup END
