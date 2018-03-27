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
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories = ['~/.vim/Ultisnips', 'UltiSnips']

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

" Quick pdf creation
nnoremap <Leader>p :Pandoc --template=/home/marc/Git/grand-schemer/latex/latex.template pdf<cr>
nnoremap <Leader>r :Pandoc --template=/home/marc/Git/grand-schemer/latex/marc.beamer beamer<cr>

" Toggle visibility of hidden symbols
nmap <leader>l :set list!<CR>

" Change tab to show as triangle, eol as logical not.
set listchars=tab:▸\ ,eol:¬

" Map jj to quit insert mode
:inoremap jj <ESC>

" Bubble single lines up and down.
nmap <C-k> ddkP
nmap <C-j> ddP

" Bubble multiple lines visually selected.
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" Turn on spellchek
:setlocal spell spelllang=en_us

" Integrate Zeal with Vim
:nnoremap gz :!zeal --query "<cword>"&<CR><CR>

" Enter a Hungarian sentence I want to learn
nnoremap <leader>h i<hungarian><cr></hungarian><esc>O

" Email abbreviation
iabbrev @@ marc.kaufmannmk@gmail.com

" Edit and source vimrc
:nnoremap <leader>ev :vs $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Commend out the visual selection, assuming it's visual line mode
" TODO: I should fix this so that it actually ensures it's visual line mode
" Somehow this does not work...
" :vnoremap <leader>cc <esc>'<O<!---<esc>'>o--><esc>

" Shortcuts 
:nnoremap <leader>hh oHungarian: <=> <esc>Bi

" Enter Hungarian o ő, and Ő
inoremap "o" ő
inoremap "O" Ő

" My leader
let mapleader = "\\"

