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
  nnoremap <leader>/ :Ag<SPACE>
  " generate doc
  nnoremap <silent> <leader>d :<C-u>call <SID>GenDoc()<cr>
  " clean some dirty charactors
  nnoremap <silent> <leader>cl :<C-u>call <SID>Clean()<cr>
  " show vim highlight group under cursor
  nnoremap <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
  nnoremap <leader>p "+]p`]
" }}

" setting switch {{
  nnoremap <leader>sc :setl spell!<cr>
  nnoremap <leader>hc :let @/ = ""<cr>
  nnoremap <leader>pt :set paste!<cr>
  nnoremap <leader>nu :call <SID>NumberToggle()<cr>
  nnoremap <leader>ag :call <SID>SwitchGrepCmd()<cr>
  nnoremap <leader>bg :call <SID>ToggleBackground()<cr>
" }}

" plugin {{
  " Relaod wechatapp dev tooles
  nmap <leader>ar <Plug>WxappReload
  " vim-sneak
  nmap s <Plug>Sneak_s
  nmap S <Plug>Sneak_S
  " bbye
  nnoremap <leader>q :Bdelete!<cr>
  " unite-session
  nmap <leader>ss :call <SID>SessionSave()<cr>
  nmap <leader>sl :<C-u>SessionLoad 
  nmap <leader>sr :call <SID>Restart()<cr>
  " ultisnips
  noremap <leader>snip :UltiSnipsEdit<cr>
  " Gundo
  "nnoremap <D-u> :GundoToggle<CR>
  " tern
  nnoremap <leader>tb :TernDocBrowse<cr>
  nnoremap <leader>tt :TernType<cr>
  nnoremap <leader>tf :TernDef<cr>
  nnoremap <leader>tp :TernDefPreview<cr>
  nnoremap <leader>td :TernDoc<cr>
  nnoremap <leader>tr :TernRefs<cr>
  nnoremap <leader>tR :TernRename<cr>

  nmap <leader>se <Plug>SvgEdit
  nmap <leader>sp <Plug>SvgPreview
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
  let word = escape(word, '|')
  if g:grep_using_git
    call g:Quickfix('ag ', word)
  else
    call g:Quickfix('ag', "-Q -s", word)
  endif
  let @@ = saved_unnamed_register
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
  if ft ==# 'javascript'
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

" Switch between `ag` and `git grep`, `grepprg` is a wrapper command
" See https://gist.github.com/55a5246a5b218b9848dc
function! s:SwitchGrepCmd()
  if g:grep_using_git
    set grepprg=ag\ --vimgrep\ $*
    let g:grep_using_git = 0
    echohl Identifier | echon 'grep by ag' | echohl None
  else
    set grepprg=grepprg\ $*
    let g:grep_using_git = 1
    echohl Identifier | echon 'grep by git' | echohl None
  endif
endfunction

function! s:GenDoc()
  if &ft ==# 'javascript'
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
" }}
