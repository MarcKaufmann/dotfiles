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
let g:UltiSnipsJumpForwardTrigger="<tab>"
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
set ts=4 sts=4 sw=4 expandtab

" Add keywords to the syntax of racket.
set lispwords+=define-type,type-case,syntax-case,syntax-rules

" Quick pdf creation
nnoremap <Leader>p :Pandoc --template=/home/marc/Git/grand-schemer/latex/latex.template pdf<cr>
nnoremap <Leader>b :Pandoc --template=/home/marc/Git/grand-schemer/latex/marc.beamer beamer<cr>

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

" Email abbreviation
" iabbrev @@ marc.kaufmannmk@gmail.com

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
inoremap öö ő
inoremap ÖÖ Ő


" My leader
let mapleader = "\\"

" Racket auto commands {{{
augroup racketgroup
	autocmd! 
	autocmd FileType scheme nnoremap <buffer> <localleader>c I;<esc>
	autocmd FileType scheme :iabbrev <buffer> #lr #lang racket
	autocmd FileType scheme nnoremap <buffer> <localleader>t :execute '!raco test %'<cr>
augroup END
" }}}

" Operator-pending mappings from VimScript {{{
" It's a beautiful list, isn't it?
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in) :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap il) :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap in} :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap il} :<c-u>normal! F}vi{<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap in] :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>
onoremap il] :<c-u>normal! F]vi[<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap an) :<c-u>normal! f(va(<cr>
onoremap al( :<c-u>normal! F)va(<cr>
onoremap al) :<c-u>normal! F)va(<cr>
onoremap an{ :<c-u>normal! f{va{<cr>
onoremap an} :<c-u>normal! f{va{<cr>
onoremap al{ :<c-u>normal! F}va{<cr>
onoremap al} :<c-u>normal! F}va{<cr>
onoremap an[ :<c-u>normal! f[va[<cr>
onoremap an] :<c-u>normal! f[va[<cr>
onoremap al[ :<c-u>normal! F]va[<cr>
onoremap al] :<c-u>normal! F]va[<cr>
" }}}

" Markdown mappings for top headings {{{
augroup markdowngroup
	autocmd!
	autocmd FileType pandoc onoremap <buffer> ih :<c-u>execute "normal! ?^#\\+ \\zs\rvg_"<cr>
	autocmd FileType pandoc nnoremap <buffer> <leader>br :execute "normal! mbA\\pause{}\e`b"<cr>
augroup END
" }}}

" Status Line {{{
set laststatus=2
set statusline=File:\ %.30F		" File path, maximum 30 characters
set statusline+=%=				" Switch to the right side 
set statusline+=Current:\ %-4l	" Print current line number, at least 4 spaces
set statusline+=\ Total:\ %-4L	" Print the total line number, at least 4 spaces
" }}}

" Folding for vim files ------- {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Latex shortcuts ----------- {{{
augroup latex_commands
	autocmd!
augroup END

" Allow saving of files as sudo when I forgot to open as sudo
cmap w!! w !sudo tee > /dev/null %

set tags=tags;~

" vim-test config so that test output goes to quickfix window
let test#strategy = "dispatch"

" Slime config for tmux
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
nnoremap <leader>r :SlimeSendAll<cr>

nnoremap <leader>t :execute '!raco test -t .'<cr>
nnoremap <leader>h :execute '!raco test -t %'<cr>

" Navigation shortcuts
nnoremap <leader><leader> <c-^>
