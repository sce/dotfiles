"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" setup:

" behave like vim, not like vi
" (has side effect for other options, so must be first)
set nocompatible

set fileencoding=utf-8
set encoding=utf-8

" where to create backups, if turned on:
set backupdir=~/.cache/vim/backup

" where to store swap files:
set directory=~/.cache/vim/

" gnome-terminal doesn't advertise its support for 256 colors, fix:
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" yes our tty is fast.
set ttyfast

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" behaviour:

" only a single space after ./?/! etc after using 'j' or 'gq'
set nojoinspaces

" no delay when hitting escape
set noesckeys

" completion from list on command line.
set wildmenu

" Remove trailing whitespaces automaticaly on save
autocmd BufWritePre * :%s/\s\+$//e

" use folding by default
" set foldmethod=indent

set confirm " ask what to do when quitting in a limbo state instead of just complaining

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentation:

set tabstop=2 " how many spaces a tab character counts as
set shiftwidth=0 " numer of spaces per autoindent (zero: use ts value)

" numer of spaces per tab in insert mode (zero: off, negative: use ts value)
set softtabstop=-1
set expandtab " tabs becomes spaces
set autoindent " when formatting a paragraph of text, keep the indent of the first line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" appearance:

" keep some lines of text at the bottom/top when scrolling.
set scrolloff=3

" always show cursor position
set ruler

" always show status line
set laststatus=2

set number " add line numbers

set showcmd " show (long) commands being typed

" make line numbers relative to current line
" set relativenumber

syntax on

" try to fix slow syntax highlighting:
" set synmaxcol=90

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
":nmap <C-N><C-N> :set invnumber <CR>
:nmap <C-M><C-M> :set invnumber <CR>

" CTRL+J changes to upper window, CTRL+K changes to lower.
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0

" (mostly ruby specific):
" \%V means restrict to visual selection (if any)

let mapleader = ","

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

" map \- to split words into separate lines
map <Leader>- :s/\s\+/\r/g<CR>

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

" run current ruby test file
map <Leader>r :!time bundle exec ruby -Itest -Ilib %

map <Leader>d :!git df %<CR>
map <Leader>w :!git df -w %<CR>
map <Leader>a :!git add -p %<CR>
map <Leader>N :!git add -N %<CR>
map <Leader>c :!git ci
map <Leader>C :!git dc

" Map tab to autocomplete current word from words in current file:
" imap <tab> <C-X><C-N>
" (hmm, just use <C-N> directly in insert mode instead.

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
"let ruby_space_errors=1

" the end-keyword is colorized according to the opening statement, but that is
" slow, so we turn it off:
"let ruby_no_expensive = 1

" turns out ruby syntax triggers a performance regression in the regular
" expression engine, force old version (from
" http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting)
set re=1

" enable foldmethod=syntax for ruby files
" let ruby_fold=1
" let ruby_no_comment_fold = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins:

" activate pathogen to enable ~/.vim/bundle plugins:
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

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
