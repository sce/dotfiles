"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" behaviour:

" behave like vim, not like vi
set nocompatible

set fileencoding=utf-8
set encoding=utf-8

" only a single space after ./?/! etc after using 'j' or 'gq'
set nojoinspaces

set shiftwidth=2
set tabstop=2
set softtabstop=2

" tabs becomes spaces
set expandtab

" when formatting a paragraph of text, keep the indent of the first line
set autoindent

" ask what to do when quitting in a limbo state instead of just complaining
set confirm

" Remove trailing whitespaces automaticaly on save
autocmd BufWritePre * :%s/\s\+$//e

" no delay when hitting escape
set noesckeys

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" appearance:

" keep some lines of text at the bottom/top when scrolling.
set scrolloff=2

" always show cursor position
set ruler

" always show status line
set laststatus=2

" completion from list on command line.
set wildmenu

" add line numbers
set number

" make line numbers relative to current line
" set relativenumber

" gnome-terminal doesn't advertise its support for 256 colors, fix:
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

syntax on
set background=dark
colorscheme torte

highlight StatusLine ctermfg=233 ctermbg=white

set cursorline
highlight CursorLine cterm=none ctermbg=233
"highlight CursorLineNr cterm=bold ctermbg=233
highlight CursorLineNr cterm=NONE ctermbg=233 ctermfg=blue
highlight LineNr ctermbg=232
highlight Visual ctermbg=235 cterm=bold

" in order to let the terminal handle the background:
highlight Normal ctermbg=none

" change syntax/indent depending on file extension:
filetype plugin indent on

" use folding by default
" set foldmethod=indent " or maybe not ...

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" searching:

" search while you're typing the search string
set incsearch

" highlight search results
set hlsearch

" ignore case when searching
set ignorecase

" but if we search for big letters, make search case sensitive again
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keybindings:

" turn off highlighted results (set nohlsearch) when pressing enter.
" just pressing n or N will turn the highlight back again
nnoremap <cr> :noh <cr>

" CTRL+N twice to toggle line numbers
:nmap <C-N><C-N> :set invnumber <CR>

" CTRL+J changes to upper window, CTRL+K changes to lower.
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0

" (mostly ruby specific):
" \%V means restrict to visual selection (if any)

" map \= to fix space around equal signs
map <Leader>= :s/\%V\(\w\)\s*=\s*\(\w\)/\1 = \2/g<CR>

" map \s to squeeze whitespace (while preserving indentation)
map <Leader>s :s/\%V\(\S\)\s\+/\1 /g<CR>

" map \n to squeeze newlines
map <Leader>n :s/\n\n\+/\r\r/g<CR>

" map \h to split hash arguments into separate lines
map <Leader>h :s/\s*,\s\+/,\r/g<CR>

" map \, to split statements into separate lines
map <Leader>, :s/\s*;\s*/\r/g<CR>

" nnoremap <C-N> :next<Enter>
" nnoremap <C-P> :prev<Enter>

" tabs:
" map ,e :tabedit <C-R>=expand("%:h")<CR>
" map <C-n> :tabnext<CR>
" map <C-e> :tabedit <C-R>=expand("%:h")<CR>

" max number of initial tabs when using -p
set tabpagemax=20

" CTRL+e to tab edit a file
map <C-e> :tabedit
" CTRL+l for next tab
map <C-l> :tabnext<CR>
" CTRL+h for previous tab
map <C-h> :tabprevious<CR>

" Map tab to autocomplete current word from words in current file:
imap <Tab> <C-X><C-N>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype specifics:

" .md == markdown
au BufNewFile,BufRead *.md set filetype=markdown

" .thor == ruby
au BufNewFile,BufRead *.thor set filetype=ruby

" remove annoying underlines when editing HTML code.
hi Underlined gui=NONE

" add extra syntax to ruby files
let ruby_operators=1
let ruby_space_errors=1

" enable foldmethod=syntax for ruby files
" let ruby_fold=1
" let ruby_no_comment_fold = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
