" behave like vim, not like vi
set nocompatible

" only a single space after ./?/! etc after using 'j' or 'gq'
set nojoinspaces

syntax on
set background=dark

set shiftwidth=2
set tabstop=2
set softtabstop=2

" tabs becomes spaces
set expandtab

" when formatting a paragraph of text, keep the indent of the first line
set autoindent

" keep some lines of text at the bottom when scrolling.
set scrolloff=3

" show a small ruler
set ruler

" ask what to do when quitting in a limbo state instead of just complaining
set confirm

" remove annoying underlines when editing HTML code.
hi Underlined gui=NONE

" add extra syntax to ruby files
let ruby_operators=1
let ruby_space_errors=1

" enable foldmethod=syntax for ruby files
" let ruby_fold=1
" let ruby_no_comment_fold = 1

" search while you're typing the search string
set incsearch

" highlight search results
set hlsearch

" ignore case when searching
set ignorecase

" but if we search for big letters, make search case sensitive again
set smartcase

" add line numbers
set number

" turn off highlighted results (set nohlsearch) when pressing enter.
" just pressing n or N will turn the highlight back again
nnoremap <cr> :noh <cr>

" CTRL+N twice to toggle line numbers
:nmap <C-N><C-N> :set invnumber <CR>

" change behaviour depending on file extension:
filetype on
filetype plugin on
filetype indent on

" use folding by default
" set foldmethod=indent " or maybe not ...

" CTRL+J changes to upper window, CTRL+K changes to lower.
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0

" Remove trailing whitespaces automaticaly on save
"autocmd BufWritePre * :%s/\s\+$//e

" nnoremap <C-N> :next<Enter>
" nnoremap <C-P> :prev<Enter>

" map ,e :tabedit <C-R>=expand("%:h")<CR>
" map <C-n> :tabnext<CR>
" map <C-e> :tabedit <C-R>=expand("%:h")<CR>

" CTRL+e to tab edit a file
map <C-e> :tabedit
" CTRL+l for next tab
map <C-l> :tabnext<CR>
" CTRL+h for previous tab
map <C-h> :tabprevious<CR>

" " autocomplete with tab/shift+tab
" function! SuperCleverTab(direction)
"     if strpart(getline('.'), 0, col('.') - 1) =~ '\w$'
"         if pumvisible()
"             return a:direction == 1 ? "\<C-N>" : "\<C-P>"
"         elseif &omnifunc != ''
"             return "\<C-X>\<C-O>"
"         elseif &dictionary != ''
"             return "\<C-K>"
"         else
"             return a:direction == 1 ? "\<C-N>" : "\<C-P>"
"         endif
"     else
"         return a:direction == 1 ? "\<Tab>" : "\<S-Tab>"
"     endif
" endfunction
"
" inoremap <Tab> <C-R>=SuperCleverTab(1)<CR>
" inoremap <S-Tab> <C-R>=SuperCleverTab(-1)<CR>

" " Enable omnifunc. Available through tab because of SuperCleverTab.
" filetype plugin on " autoload plugins from $VIM/ftplugin/[filetype]/*

" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
