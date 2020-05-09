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

" Toggle with "I" when focused:
let NERDTreeShowHidden=1
" let NERDTreeStatusline=1

" changing tabs: never focus nerdtree:
let g:nerdtree_tabs_focus_on_files=1

" automatically find and select currently opened file in nerdtree.
let g:nerdtree_tabs_autofind=1

" after you stop typing, trigger plugin after how many ms (default 4000):
let g:gitgutter_realtime = 1000

" The bright red background that ale defaults to is too strong:
highlight ALEError ctermbg=DarkMagenta
highlight ALEError ctermbg=Black

highlight ALEWarning ctermbg=DarkGray
highlight ALEWarning ctermbg=None

let g:ale_enabled = 1

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
" map <C-e> :vsp
map <C-e> :vertical sbuf

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
map <esc>e :tabedit
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
map <Leader>r :!time bundle exec ruby -Itest -Ilib %

map <Leader>d :!git df %<CR>
map <Leader>D :!git dc %<CR>
map <Leader>w :!git df -w %<CR>
map <Leader>W :!git dc -w %<CR>

" can't use --patch for merge conflicts for some reason
map <Leader>a :!git add -p %<CR>
map <Leader>A :!git add %<CR>
map <Leader>N :!git add -N %<CR>

map <Leader>r :!git reset %<CR>
map <Leader>R :!git reset<CR>

map <Leader>c :!git ci
map <Leader>C :!git dc

" toggle nerdtree for all tabs
" map <Leader>n <plug>NERDTreeTabsToggle<CR>

" select current file in nerdtree
" map <Leader>f <plug>NERDTreeTabsFind<CR>

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

" from https://github.com/w0rp/ale/blob/726a768464d3e42869088599cf1bd049f7a751df/README.md
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" vim-plug plugins https://github.com/junegunn/vim-plug
" call :PlugInstall after adding something here:
call plug#begin('~/.vim/plugged')

  " https://github.com/neoclide/coc.nvim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " vim color scheme gruvbox:
  Plug 'morhetz/gruvbox'

  " Multi-entry selection UI.
  " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gruvbox options must come setting the colorscheme
let g:gruvbox_contrast_dark = "hard"

" activate gruvbox after all plugins are loaded, to make sure it works:
autocmd vimenter * colorscheme gruvbox
colorscheme gruvbox

" in order to let the terminal handle the background:
autocmd vimenter * highlight Normal ctermbg=none
highlight Normal ctermbg=none

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   COC Plugin Configuration:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

xmap <leader>fa :CocCommand prettier.formatFile<cr>
nmap <leader>fa :CocCommand prettier.formatFile<cr>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
xmap <leader>as  <Plug>(coc-codeaction-selected)
nmap <leader>as  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" when selecting: select code inside function:
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
" when selecting: select all of current function:
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

nmap <silent> <S-TAB> <Plug>(coc-range-select-backward)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backward)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Statusline:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html

"set statusline+=%t       "tail of the filename
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%h      "help file flag
"set statusline+=%m      "modified flag
"set statusline+=%r      "read only flag
"set statusline+=%y      "filetype
"set statusline+=%=      "left/right separator
"set statusline+=%c,     "cursor column
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set statusline+=\ %t       "tail of the filename
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
