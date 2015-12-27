" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
let g:mapleader = ','

" basic {{
  " quite useful
  nnoremap <leader>e :e <C-R>=expand('%:p:h').'/'<cr>
  " vimrc reload edit
  nnoremap <leader>rl :source ~/.vimrc<cr>
  nnoremap <leader>{ F)a<space>{<enter><space><space><esc>o<esc>i}<esc>O<tab>
  " search
  nnoremap <leader>/ :Ag<SPACE>
" }}

" content edit {{
  nnoremap <leader>au :!autoprefixer %<cr>
  " clean some dirty charactors
  nnoremap <silent> <leader>cl :<C-u>call <SID>Clean()<cr>
" }}

" spell checking {{
  nnoremap <leader>sc :setl spell!<cr>
  nnoremap <leader>s? z=
  nnoremap <leader>sn ]s
  nnoremap <leader>sp [s
  nnoremap <leader>sa zg
" }}

" setting switch {{
  " TODO switch foldcolumn
  nnoremap <leader>ic :set ic!<cr>
  nnoremap <leader>hl :set hls!<cr>
  nnoremap <leader>hc :let @/ = ""<cr>
  nnoremap <leader>pt :set paste!<cr>
  nnoremap <leader>nu :call <SID>NumberToggle()<cr>
  nnoremap <leader>ag :call <SID>SwitchGrepCmd()<cr>
" }}

" plugin {{
  " bbye
  nnoremap <leader>q :Bdelete<cr>
  " vim-test
  nmap <silent> <leader>t :TestNearest<CR>
  " vim-session
  nmap <leader>sl :OpenSession
  nmap <leader>ss :SaveSession
  nmap <leader>sr :call <SID>Restart()<cr>
  nmap <leader>sd :CloseSession<cr>
  " ultisnips
  noremap <leader>snip :UltiSnipsEdit<cr>
  noremap <leader>js :UltiSnipsAddFiletypes html.js<cr>
  " ctrlsf
  map <leader>st :CtrlSFToggle<cr>
  map <leader>sf :CtrlSF<space>
  " vim-notes
  map <leader>ne :Note 
  map <leader>ns :Ns 
  map <leader>nd :DeleteNote<cr>
  map <leader>nr :RecentNotes<cr>
  map <leader>nl :RelatedNotes<cr>
  " Gundo
  nnoremap <D-u> :GundoToggle<CR>
  " vim-shell
  nnoremap <Leader>o :Open<CR>
  imap <2-LeftMouse> <C-o>:Open<CR>
  nmap <2-LeftMouse> :Open<CR>
  " tern
  nnoremap <leader>tb :TernDocBrowse<cr>
  nnoremap <leader>tt :TernType<cr>
  nnoremap <leader>tf :TernDef<cr>
  nnoremap <leader>td :TernDoc<cr>
  nnoremap <leader>tp :TernDefPreview<cr>
  nnoremap <leader>tr :TernRename<cr>
  nnoremap <leader>ts :TernRefs<cr>
  " VimCompletesMe
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}

" wrap {{
  vnoremap <leader>' <esc>`<i'<esc>`>la'<esc>
  vnoremap <leader>` <esc>`<i`<esc>`>la`<esc>
  vnoremap <leader>( <esc>`<i(<esc>`>la)<esc>
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
  let word = substitute(escape(@@, '|'), "'","''",'g')
  silent execute "Ag -Q '" . word . "'"
  let @@ = saved_unnamed_register
endfunction
" }}

" functions {{
function! s:NumberToggle()
  if(&number == 1) | set nu! | set rnu! | else | set rnu | set nu | endif
endfunction

function! s:Restart()
  execute 'wa'
  execute 'RestartVim'
endfunction

function! s:Clean()
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
    call JsBeautify()
  endif
  " remove tailing white space
  silent! execute '%s/\s\+$//'
  " remove windows 
  silent! execute '%s/$//'
endfunction

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
" }}
