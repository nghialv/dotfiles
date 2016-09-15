let g:mirodark_disable_color_approximation=1
colo mirodark_haskell

" Syntastic
"let g:hdevtools_options = '-g -isrc -g -Wall -g -hide-package -g transformers'
let g:syntastic_haskell_checkers = ['hlint'] "'hdevtools'

" GhcMod
"let &l:statusline = '%{empty(getqflist()) ? "[No Errors]" : "[Errors Found]"}' . (empty(&l:statusline) ? &statusline : &l:statusline)

" Tabular
let g:haskell_tabular = 1
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

" Neoghc
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>

" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle

" Check syntax
map <silent> gc :GhcModCheck<CR>

" Show type of expression under cursor
map <silent> gt :GhcModType<CR>

" Insert type of expression under cursor
map <silent> gti :GhcModTypeInsert<CR>

" GhcMod
map <silent> gs :GhcModSplitFunCase<CR>
map <silent> gcl :GhcModTypeClear<CR>
