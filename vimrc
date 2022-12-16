" Map jj to quit insert mode
:inoremap jj <Esc> 				            

" Enable plugins and indentation for specific file types
filetype plugin indent on

" Persistent undo
set undodir=/Users/kaufmannm/.vimundo 		" Where undo files are saved	
set undofile					            " Use undo files
set undolevels=10000				        " Max number of undos per file
set undoreload=100000				        " Set the whole buffer for undo when reloading it

" Searching
set hlsearch					            " Highlight search term 
set incsearch					            " Search incrementally
set ignorecase					            " Ignore case when search

" Tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

" UI
syntax on					                " Enable syntax highlighting
set wrap

" Miscellaneous
set formatprg=par                           " Use par to format documents with gq
set linebreak                               " Wrap at spaces
" set nowrap                                  " Turn wrapping off
set autochdir                               " Change dir to current file automatically
set tags+=./.tags;/
set shell=/bin/bash
