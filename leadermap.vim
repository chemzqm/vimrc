" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
let g:mapleader = ','

" basic {{
  " Edit file in current file folder
  nnoremap <leader>n :Lexplore<CR>
  nnoremap <leader>q :silent! Bdelete!<CR>
  nnoremap <leader>e :e <C-R>=substitute(expand('%:p:h').'/', getcwd().'/', '', '')<CR>
  nnoremap <leader>v :vs <C-R>=substitute(expand('%:p:h').'/', getcwd().'/', '', '')<CR>
  nnoremap <leader>t :tabe <C-R>=substitute(expand('%:p:h').'/', getcwd().'/', '', '')<CR>
  nnoremap <leader>rm :Rm <C-R>=expand('%:p:h').'/'<CR>
  nnoremap <leader>mk :Mkdir <C-R>=expand('%:p:h').'/'<CR>
  " Replace all of current word
  nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<left><left>
  " Reload vimrc file
  nnoremap <leader>rl :source ~/.vimrc<CR>
  " Search with grep
  nnoremap <leader>/ :Rg<space>
  " generate doc
  nnoremap <silent> <leader>d :<C-u>call <SID>GenDoc()<CR>
  " clean some dirty charactors
  nnoremap <silent> <leader>cl :<C-u>call <SID>Clean()<CR>
  " show vim highlight group under cursor
  nnoremap <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
  nnoremap <silent> <leader>pp "0p
  nnoremap <silent> <leader>o :call <SID>Open()<CR>
" }}

" setting switch {{
  nnoremap <leader>sc :setl spell!<CR>
  nnoremap <leader>pt :set paste!<CR>
  nnoremap <leader>nu :call <SID>NumberToggle()<CR>
  nnoremap <leader>bg :call <SID>ToggleBackground()<CR>
" }}

" plugin {{
  "session helper
  nmap <leader>ss :call <SID>SessionSave()<CR>
  nmap <leader>sl :<C-u>SessionLoad
  nmap <leader>sr :call <SID>SessionReload()<CR>
  " svg.vim not used very often
  nmap <leader>se <Plug>SvgEdit

  " coc.nvim
  nmap <leader>x  <Plug>(coc-cursors-operator)
  nmap <leader>rn <Plug>(coc-rename)
  nmap <leader>rf <Plug>(coc-refactor)
  nmap <leader>ca <Plug>(coc-codelens-action)
  xmap <leader>x  <Plug>(coc-convert-snippet)
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>ac <Plug>(coc-codeaction-line)
  nmap <leader>af <Plug>(coc-codeaction)
  nmap <leader>di <Plug>(coc-diagnostic-info)
  nmap <leader>qf <Plug>(coc-fix-current)
  nmap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
  nmap <leader>dr <Plug>(coc-diagnostic-related)
  nmap <leader>ms <Plug>(coc-menu-show)

  nmap <silent> <Leader>tr <Plug>(coc-translator-p)
" }}

" grep by motion {{
vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction
" }}

" functions {{
function! s:SessionSave()
  if !empty(v:this_session)
    execute 'SessionSave'
  else
    call feedkeys(':SessionSave ')
  endif
endfunction

function! s:ToggleBackground()
  if &background ==# 'light'
    set background=dark
  else
    set background=light
  endif
  call SetStatusLine()
endfunction

function! s:NumberToggle()
  if(&number == 1) | set nu! | set rnu! | else | set rnu | set nu | endif
endfunction

function! s:SessionReload()
  execute 'wa'
  execute 'RestartVim'
endfunction

" Simple clean utility
function! s:Clean()
  let view = winsaveview()
  let ft = &filetype
  " replace tab with 2 space
  if index(['javascript', 'html', 'css', 'vim', 'php'], ft) != -1
    silent! execute "%s/\<tab>/  /g"
  endif
  " replace tailing comma
  if ft ==# 'javascript' || ft ==# 'typescript'
    silent! execute '%s/;$//'
  endif
  " remove tailing white space
  silent! execute '%s/\s\+$//'
  " remove windows `\r`
  call winrestview(view)
endfunction

function! s:GenDoc()
  if &ft ==# 'javascript' || &ft ==# 'typescript'
    exe "JsDoc"
  elseif &ft ==# 'css'
    let lines = ['/*', ' * ', ' */']
    exe "normal! j?{$\<CR>:noh\<CR>"
    let lnum = getpos('.')[1]
    call append(lnum - 1, lines)
    exe "normal! kk$"
    startinsert!
  elseif &ft ==# 'html'
    let lnum = getpos('.')[1]
    let ind = matchstr(getline('.'), '\v\s*')
    call append(lnum - 1, ind . '<!--  -->')
    exe "normal! k^Ell"
    startinsert
  elseif &filetype ==# 'vim'
    let lnum = getpos('.')[1]
    let ind = matchstr(getline('.'), '\v\s*')
    call append(lnum - 1, ind . '" ')
    exe "normal! k$"
    startinsert!
  else
    let lnum = getpos('.')[1]
    let ind = matchstr(getline('.'), '\v\s*')
    call append(lnum - 1, ind. '# ')
    exe "normal! k$"
    startinsert!
  endif
endfunction

function! s:Open()
  let res = CocAction('openLink')
  if res | return | endif
  let line = getline('.')
  " match url
  let url = matchstr(line, '\vhttps?:\/\/[^)\]''" ]+')
  if !empty(url)
    let output = system('open '. url)
  else
    let mail = matchstr(line, '\v([A-Za-z0-9_\.-]+)\@([A-Za-z0-9_\.-]+)\.([a-z\.]+)')
    if !empty(mail)
      let output = system('open mailto:' . mail)
    else
      let output = system('open ' . expand('%:p:h'))
    endif
  endif
  if v:shell_error && output !=# ""
    echoerr output
  endif
endfunction
" }}
