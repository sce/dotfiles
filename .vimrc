"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup:

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

" hot reloading with parceljs inside a docker container needs this to work:
set backupcopy=yes

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behaviour:

" only a single space after ./?/! etc after using 'j' or 'gq'
set nojoinspaces

" no delay when hitting escape
set noesckeys

" completion from list on command line.
set wildmenu

" recursive search when using :find
set path+=**

" Remove trailing whitespaces automaticaly on save
autocmd BufWritePre * :%s/\s\+$//e

" wrap at different width for javascript:
autocmd BufRead,BufNewFile *.js,*.jsx,*.ts,*.tsx,*.txt,*.md setlocal textwidth=100

" use folding by default
" set foldmethod=indent

set confirm " ask what to do when quitting in a limbo state instead of just complaining

" set mouse=a " enable mouse (gah, this prevents copy/paste with mouse)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation:

set tabstop=2 " how many spaces a tab character counts as
set shiftwidth=2 " numer of spaces per autoindent (zero: use ts value)

" numer of spaces per tab in insert mode (zero: off, negative: use ts value)
set softtabstop=2
set autoindent " when formatting a paragraph of text, keep the indent of the first line
set expandtab " tabs becomes spaces

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching:

set incsearch  " search while you're typing the search string
set hlsearch   " highlight search results
set ignorecase " ignore case when searching
set smartcase  " but if we search for big letters, make search case sensitive again

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance:

set scrolloff=3 " keep some lines of text at the bottom/top when scrolling.
set ruler " always show cursor position
set laststatus=2 " always show status line
set number " add line numbers
set showcmd " show (long) commands being typed

" make line numbers relative to current line
" set relativenumber

syntax on

" try to fix slow syntax highlighting:
" set synmaxcol=90

set background=dark
" colorscheme torte

highlight StatusLine ctermfg=233 ctermbg=white

set cursorline
highlight CursorLine cterm=none ctermbg=233
"highlight CursorLineNr cterm=bold ctermbg=233
highlight CursorLineNr cterm=NONE ctermbg=233 ctermfg=blue
highlight LineNr ctermbg=232
highlight Visual ctermbg=235 cterm=bold

" in order to let the terminal handle the background:
highlight Normal ctermbg=none

" hide vertical split line:
highlight VertSplit ctermbg=black ctermfg=black

" remove annoying underlines when editing HTML code.
hi Underlined gui=NONE

" change syntax/indent depending on file extension:
filetype plugin indent on

" custom words:
set spellfile=~/.vim/spell/en.utf-8.add

" https://www.linux.com/learn/using-spell-checking-vim
" turn off with :set nospell
" okay this is too annoying to have on by default...
" set spell spelllang=en_gb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype Specifics:

" .md == markdown
au BufNewFile,BufRead *.md set filetype=markdown

" .thor == ruby
au BufNewFile,BufRead *.thor set filetype=ruby

" add extra syntax to ruby files
let ruby_operators=1
"let ruby_space_errors=1

" the end-keyword is colorized according to the opening statement, but that is
" slow, so we turn it off:
"let ruby_no_expensive = 1

" turns out ruby syntax triggers a performance regression in the regular
" expression engine, force old version (from
" http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting)
" set re=1

" enable foldmethod=syntax for ruby files
" let ruby_fold=1
" let ruby_no_comment_fold = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen Plugins:

" activate pathogen to enable ~/.vim/bundle plugins:
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybindings:

" turn off highlighted results (set nohlsearch) when pressing enter.
" just pressing n or N will turn the highlight back again
nnoremap <cr> :noh <cr>

" CTRL+N twice to toggle line numbers
" (CTRL+M actually looks like "enter" to vim...)
" https://vi.stackexchange.com/questions/8856/mapping-ctrl-with-equal-sign
:nmap <C-N><C-N> :set invnumber <CR>
":nmap <C-M><C-M> :set invnumber <CR>

" CTRL+J changes to upper window, CTRL+K changes to lower.
" change window + minimise/maximise::
"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_

" ALT+jkhl changes window up/down/left/right
" my terminal is giving me escape character instead of "alt", so these
" keybindings are actually <A-l> etc:
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" CTRL+e to edit buffer file in new window
"map <C-e> :vertical sbuf
" just do the split
map <C-e> :vsp

" CTRL+p (almost "=" I guess :-p) to resize windows evenly
" https://vi.stackexchange.com/questions/8856/mapping-ctrl-with-equal-sign
map <C-p> <C-W>=

" Swap current window with the one to the right:
map <C-x> <C-W>x

set wmh=0

" nnoremap <C-N> :next<Enter>
" nnoremap <C-P> :prev<Enter>

" tabs:
" map ,e :tabedit <C-R>=expand("%:h")<CR>
" map <C-n> :tabnext<CR>
" map <C-e> :tabedit <C-R>=expand("%:h")<CR>

" max number of initial tabs when using -p
set tabpagemax=20

" ALT+e to tab edit a file
map <esc>e :tabedit<CR>
" ALT+l for next tab
map <esc>l :tabnext<CR>
" ALT+h for previous tab
map <esc>h :tabprevious<CR>

" (mostly ruby specific):
" \%V means restrict to visual selection (if any)

let mapleader = ","

" map leader instead of [ for convenience
"map <Leader>8' ['<CR>
"map <Leader>9' ]'<CR>
map <Leader>8 ['<CR>
map <Leader>9 ]'<CR>

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

" run current ruby test file
" map <Leader>r :!time bundle exec ruby -Itest -Ilib %

" fzf on open buffers
map <Leader>b :Buffers<CR>

" fzf on all git files
map <Leader>g :GFiles<CR>

" fzf on all files
map <leader>f :FZF<cr>

" map <Leader>c :!git ci
" map <Leader>C :!git dc

" Map tab to autocomplete current word from words in current file:
" imap <tab> <C-X><C-N>
" (hmm, just use <C-N> directly in insert mode instead.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jumps:

map <Leader>j :jumps<CR>

" jump back with g,
nnoremap g, <C-o>
" jump forwards with g.
nnoremap g. <C-i>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-plug plugins https://github.com/junegunn/vim-plug
" call :PlugInstall after adding something here:
call plug#begin('~/.vim/plugged')

  " https://github.com/neoclide/coc.nvim
  " config goes in .config/coc/config
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " vim color scheme gruvbox:
  Plug 'morhetz/gruvbox'

  " Multi-entry selection UI.
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gruvbox options must come after setting the colorscheme
let g:gruvbox_contrast_dark = "hard"

" activate gruvbox after all plugins are loaded, to make sure it works:
autocmd vimenter * colorscheme gruvbox
colorscheme gruvbox

" in order to let the terminal handle the background:
autocmd vimenter * highlight Normal ctermbg=none
highlight Normal ctermbg=none


" let runtimepath = '~/.vim'

runtime config/ale.vim
runtime config/coc.vim
runtime config/gitgutter.vim
" runtime config/nerdtree.vim
runtime config/statusline.vim
