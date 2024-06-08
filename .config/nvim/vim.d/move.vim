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
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" CTRL+e to edit buffer file in new window
"map <C-e> :vertical sbuf
" just do the split
map <C-e> :vsp<cr>

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

" my terminal is giving me escape character instead of "alt", so these
" keybindings are actually <A-l> etc:
" ALT+e to tab edit a file
map <esc>e :tabedit<CR>
" ALT+l for next tab
map <esc>l :tabnext<CR>
" ALT+h for previous tab
map <esc>h :tabprevious<CR>

let mapleader = ","

" map leader instead of [ for convenience
"map <Leader>8' ['<CR>
"map <Leader>9' ]'<CR>
map <Leader>8 ['<CR>
map <Leader>9 ]'<CR>

" \%V means restrict to visual selection (if any)

" map \= to fix space around equal signs
""" map <Leader>= :s/\%V\(\w\)\s*=\s*\(\w\)/\1 = \2/g<CR>
""" 
""" " map \s to squeeze whitespace (while preserving indentation)
""" map <Leader>s :s/\%V\(\S\)\s\+/\1 /g<CR>
""" 
""" " map \n to squeeze newlines
""" map <Leader>n :s/\n\n\+/\r\r/g<CR>
""" 
""" " map \h to split hash arguments into separate lines
""" map <Leader>h :s/\s*,\s\+/,\r/g<CR>
""" 
""" " map \, to split statements into separate lines
""" map <Leader>, :s/\s*;\s*/\r/g<CR>
""" 
""" " map \- to split words into separate lines
""" map <Leader>- :s/\s\+/\r/g<CR>

" map <Leader>c :!git ci
" map <Leader>C :!git dc

" Map tab to autocomplete current word from words in current file:
" imap <tab> <C-X><C-N>
" (hmm, just use <C-N> directly in insert mode instead.

" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" change global directory to that of current file:
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" ... alternative command instead of leader:
command CDC cd %:p:h

command CDRoot cd %:h | cd `git rev-parse --show-toplevel`

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jumps:

map <Leader>j :jumps<CR>

" jump back with g,
nnoremap g, <C-o>
" jump forwards with g.
nnoremap g. <C-i>

" open file/path even if it doesn't exist:
command OpenPath e <cfile>
nnoremap gf <cmd>OpenPath<cr>
