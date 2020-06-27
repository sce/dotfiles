"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   UltiSnips Configuration:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:UltiSnipsExpandTrigger="<tab>"

" https://github.com/ycm-core/YouCompleteMe/issues/420#issuecomment-55940039
" disable tab trigger so to not interfere with coc completion
" let g:UltiSnipsExpandTrigger="<nop>"

" esc + tab becomes alt + tab
"let g:UltiSnipsExpandTrigger="<esc><tab>"
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
" let g:UltiSnipsJumpBackwardTrigger="<c-d>"

" escape + c becomes alt+c
let g:UltiSnipsListSnippets="<esc>c"
"let g:UltiSnipsListSnippets="<c-s>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
