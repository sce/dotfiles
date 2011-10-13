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

" map \n to squeese newlines
map <Leader>n :s/\n\n\+/\r\r/g<CR>

" map \h to split hash arguments to seperate lines
map <Leader>h :s/, \+/,\r/g<CR>:=<CR>

" nnoremap <C-N> :next<Enter>
" nnoremap <C-P> :prev<Enter>

set confirm

" tabs:
" map ,e :tabedit <C-R>=expand("%:h")<CR>
" map <C-n> :tabnext<CR>
" map <C-e> :tabedit <C-R>=expand("%:h")<CR>
map <C-e> :tabedit 
map <C-l> :tabnext<CR>
map <C-h> :tabprevious<CR>


" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"

" From http://amix.dk/vim/vimrc.html:

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
