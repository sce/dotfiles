"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby specifics
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" run current ruby test file
" map <Leader>r :!time bundle exec ruby -Itest -Ilib %
