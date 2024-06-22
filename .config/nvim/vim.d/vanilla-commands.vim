"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc universially useful commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command -range=% Whitespace <line1>,<line2>s/\s\s\+/ /g
command -range=% EOLWhitespace <line1>,<line2>s/\s\+$//g

nnoremap <leader>w <cmd>Whitespace<cr>
xnoremap <leader>w <cmd>'<,'>Whitespace<cr>

nnoremap <leader>W <cmd>EOLWhitespace<cr>
xnoremap <leader>W <cmd>'<,'>EOLWhitespace<cr>

command! -range Table <line1>,<line2>!tr -s ' '|column -t -s '|' -o '|'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git things
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>a <cmd>term git add --patch %<cr>i
nnoremap <leader>A <cmd>term git add %<cr>

nnoremap <leader>d <cmd>term git diff --ignore-space-change %<cr>i
nnoremap <leader>D <cmd>term git diff --ignore-space-change --cached %<cr>i
