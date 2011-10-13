syntax on
set background=dark

set shiftwidth=2
set tabstop=2
set softtabstop=2

set autoindent
set expandtab

set incsearch
set hlsearch

" Only single space when joining lines.
set nojoinspaces

" set nohlsearch when you press enter.
" just pressing n or N will turn the highlight back again
nnoremap <cr> :noh <cr>

set ignorecase
set number
:nmap <C-N><C-N> :set invnumber <CR> 

set nocompatible
filetype on
filetype plugin on
filetype indent on

" .md == markdown
au BufNewFile,BufRead *.md set filetype=markdown

" .thor == ruby
au BufNewFile,BufRead *.thor set filetype=ruby

" set foldmethod=indent

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0

" nnoremap <C-N> :next<Enter>
" nnoremap <C-P> :prev<Enter>

set confirm

" give me tabs!
" map ,e :tabedit <C-R>=expand("%:h")<CR>
" map <C-n> :tabnext<CR>
" map <C-e> :tabedit <C-R>=expand("%:h")<CR>
map <C-e> :tabedit 
map <C-l> :tabnext<CR>
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
filetype plugin on " autoload plugins from $VIM/ftplugin/[filetype]/*

" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
