" Pathogen load
filetype off
set nocp

" For some reason vim doesn't load pathogen without this line.
set rtp+=~/.vim/autoload/pathogen.vim
set rtp+=~/.vim/bundle

execute pathogen#infect()

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" OPTIONAL: This enables automatic indentation as you type.
filetype plugin indent on

syntax on

" Recognise *.md files as markdown
au BufNewFile,BufRead *.md set filetype=markdown

" Set spacing 
set ts=4 sts=4 sw=4 noexpandtab

" Add keywords to the syntax of racket.
set lispwords+=define-type,type-case,syntax-case,syntax-rules
