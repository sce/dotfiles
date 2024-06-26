"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup:

" behave like vim, not like vi
" (has side effect for other options, so must be first)
set nocompatible

set fileencoding=utf-8
set encoding=utf-8

" where to create backups, if turned on:
" 2023-04-11: Let's just create backups in the same directory for now.
" set backupdir=~/.cache/vim/backup
set backupdir=./

" where to store swap files:
" 2023-04-11: Let's just store swap files in the same directory for now.
" set directory=~/.cache/vim/
set directory=./

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
" relevant from vim, not neovim: https://github.com/neovim/neovim/issues/7661
" set noesckeys

" completion from list on command line.
set wildmenu

" recursive search when using :find
set path+=**

" Remove trailing whitespaces automaticaly on save
" 2022-08-09: this messes up editing git patches...
" autocmd BufWritePre * :%s/\s\+$//e

set textwidth=80

" wrap at different width for javascript:
" autocmd BufRead,BufNewFile *.js,*.jsx,*.ts,*.tsx,*.txt,*.md setlocal textwidth=100

" use folding by default
" set foldmethod=indent
set foldmethod=syntax

" set mouse=a " enable mouse (gah, this prevents copy/paste with mouse)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime vim.d/cursor.vim
runtime vim.d/indent-4.vim
runtime vim.d/search.vim

runtime vim.d/vanilla-behaviour.vim
runtime vim.d/vanilla-commands.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance:

set showcmd " show (long) commands being typed

syntax on

" try to fix slow syntax highlighting:
" set synmaxcol=90

set background=dark
" colorscheme torte

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen Plugins:

" activate pathogen to enable ~/.vim/bundle plugins:
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

runtime vim.d/move.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-plug plugins https://github.com/junegunn/vim-plug
runtime vim.d/plug.vim

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

  Plug 'mhinz/vim-startify'

  Plug 'dylanaraps/root.vim'

  Plug 'SirVer/ultisnips'
  " Plug 'honza/vim-snippets'

  Plug 'michaeljsmith/vim-indent-object'

  " Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  " Plug 'fatih/vim-go'

  " Plug 'preservim/nerdcommenter'

  " Plug 'dhruvasagar/vim-table-mode'

  Plug 'liuchengxu/vista.vim'

call plug#end()

runtime config/gruvbox.vim

" let runtimepath = '~/.vim'

" runtime config/nerdtree.vim
runtime config/ale.vim
runtime config/coc-explorer.vim
runtime config/coc.vim
runtime config/fzf.vim
runtime config/gitgutter.vim
runtime config/nerdcommenter.vim
runtime config/startify.vim
runtime config/statusline.vim
runtime config/ultisnips.vim
" runtime config/vim-go.vim
