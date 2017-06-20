" Don't try to be vi compatible
" Avoid possible side effects if `nocompatible` is already set
if &compatible | set nocompatible | endif

" Display line numbers
set number

" Tab general settings
set tabstop=4

" Listchars settings
set list
set listchars=tab:▸\ ,eol:¬
