" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
let g:mapleader = ','

" basic {{
  " Edit file in current file folder
  nnoremap <leader>e :e <C-R>=substitute(expand('%:p:h').'/', getcwd().'/', '', '')<cr>
  nnoremap <leader>v :vs <C-R>=substitute(expand('%:p:h').'/', getcwd().'/', '', '')<cr>
  nnoremap <leader>t :tabe <C-R>=substitute(expand('%:p:h').'/', getcwd().'/', '', '')<cr>
  nnoremap <leader>rm :Rm <C-R>=expand('%:p:h').'/'<cr>
  nnoremap <leader>mk :Mkdir <C-R>=expand('%:p:h').'/'<cr>
  " Replace all of current word
  nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<left><left>
  " Reload vimrc file
  nnoremap <leader>rl :source ~/.vimrc<cr>
  " Search with grep
  nnoremap <leader>/ :Rg<space>
  " generate doc
  nnoremap <silent> <leader>d :<C-u>call <SID>GenDoc()<cr>
  " clean some dirty charactors
  nnoremap <silent> <leader>cl :<C-u>call <SID>Clean()<cr>
  " show vim highlight group under cursor
  nnoremap <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
  nnoremap <silent> <leader>pp "0p
  nnoremap <silent> <leader>o :call <SID>Open()<cr>
" }}

" setting switch {{
  nnoremap <leader>sc :setl spell!<cr>
  nnoremap <leader>pt :set paste!<cr>
  nnoremap <leader>nu :call <SID>NumberToggle()<cr>
  nnoremap <leader>bg :call <SID>ToggleBackground()<cr>
  nnoremap <leader>qf :call asyncrun#quickfix_toggle(8)<cr>
" }}

" plugin {{
  " vim-sneak
  nmap s <Plug>Sneak_s
  nmap S <Plug>Sneak_S
  " ctrlsf.vim
  nnoremap <leader>sf :CtrlSF 
  " bbye
  nnoremap <leader>q :Bdelete!<cr>
  " denite-extra session helper
  nmap <leader>ss :call <SID>SessionSave()<cr>
  nmap <leader>sl :<C-u>SessionLoad 
  nmap <leader>sr :call <SID>Restart()<cr>
  " ultisnips
  noremap <leader>snip :UltiSnipsEdit<cr>
  " Gundo
  nnoremap <leader>Gt :GundoToggle<CR>
  " svg.vim not used very often
  nmap <leader>se <Plug>SvgEdit
" }}

" grep by motion {{
vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<cr>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<cr>g@

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
  execute 'Denite grep:::'.word
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

function! s:Restart()
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
    " line should not starts with [ or (
    silent! execute '%s/^\s*\zs\([\[(]\)/;\1/'
  endif
  " remove tailing white space
  silent! execute '%s/\s\+$//'
  " remove windows 
  silent! execute '%s/$//'
  call winrestview(view)
endfunction

function! s:GenDoc()
  if &ft ==# 'javascript' || &ft ==# 'typescript'
    exe "JsDoc"
  elseif &ft ==# 'css'
    let lines = ['/*', ' * ', ' */']
    exe "normal! j?{$\<cr>:noh\<cr>"
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
  elseif &ft ==# 'vim'
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
