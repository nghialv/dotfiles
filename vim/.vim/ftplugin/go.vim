colo molokai

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

" :GoBuild and :GoTestCompile
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" :GoTest
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" :GoRun
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" :GoDoc
autocmd FileType go nmap <Leader>d <Plug>(go-doc)

" :GoCoverageToggle
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" :GoDef but opens in a vertical split
autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)

" :GoDef but opens in a horizontal split
autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
