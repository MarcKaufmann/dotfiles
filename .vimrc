" Pathogen load
filetype off
set nocp

" For some reason vim doesn't load pathogen without this line.
set rtp+=~/.vim/autoload/pathogen.vim

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

" OPTIONAL: This enables automatic indentation as you type.
filetype plugin indent on

" Recognise *.md files as markdown
au BufNewFile,BufRead *.md set filetype=markdown

" Set spacing 
set ts=4 sts=4 sw=4 noexpandtab
