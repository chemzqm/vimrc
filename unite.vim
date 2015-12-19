if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts='--line-numbers --nocolor --nogroup --hidden'
  let g:unite_source_rec_async_command =
    \ ['ag', '--nocolor', '-t', '--nogroup',
    \  '--depth', '15', '--hidden', '-g', '']
endif

let g:neomru#follow_links = 1
let g:unite_source_codesearch_ignore_case = 0
call unite#filters#matcher_default#use(['matcher_regexp'])
call unite#custom#source(
  \  'file_rec,file_rec/async,file_mru,file,buffer,grep',
  \  'ignore_globs',
  \  split(&wildignore, ',')
  \ )
call unite#custom#source(
  \  'file_mru,buffer', 'matchers', ['matcher_fuzzy']
  \ )
call unite#custom#source(
  \  'file_rec,file_rec/async', 'matchers', ['converter_relative_word', 'matcher_fuzzy']
  \ )
call unite#custom#profile('default', 'context', {
  \  'start_insert': 1,
  \  'winheight': 10,
  \ })
call unite#custom#profile('grep', 'context', {
  \  'no_quit': 1
  \ })
call unite#custom#profile('gitlog', 'context', {
  \  'start_insert': 0,
  \  'no_quit': 1,
  \  'vertical_preview': 1,
  \ })
call unite#custom#profile('outline', 'context', {
  \  'winheight': 15,
  \ })
call unite#custom#profile('buffer', 'context', {
  \  'quick_match': 1,
  \ })
call unite#custom#profile('yank', 'context', {
  \  'no_split': 1,
  \  'quick_match': 1,
  \ })
call unite#custom#profile('files', 'grep', 'sorter_ftime')
call unite#custom#profile('files', 'filters', 'sorter_selecta')
call unite#custom#profile('file_mru', 'filters', 'sorter_selecta')

nnoremap [unite] <Nop>
nmap <space>  [unite]
nnoremap <silent> [unite]y  :<C-u>Unite -buffer-name=yank     history/yank<cr>
nnoremap <silent> [unite]l  :<C-u>Unite -buffer-name=gitlog   gitlog<cr>
nnoremap <silent> [unite]t  :<C-u>Unite -buffer-name=files    file_rec/async:.<cr>
nnoremap <silent> [unite]o  :<C-u>Unite -buffer-name=outline  outline<cr>
nnoremap <silent> [unite]n  :<C-u>Unite -buffer-name=note     note<cr>
nnoremap <silent> [unite]g  :<C-u>Unite -buffer-name=gist     gist<cr>
nnoremap <silent> [unite]f  :<C-u>Unite -buffer-name=file     file<cr>
nnoremap <silent> [unite]p  :<C-u>Unite -buffer-name=process  process<cr>
nnoremap <silent> [unite]r  :<C-u>Unite -buffer-name=file_mru file_mru<cr>
nnoremap <silent> [unite]e  :<C-u>Unite -buffer-name=buffer   buffer<cr>
nnoremap <silent> [unite]/  :<C-u>Unite -buffer-name=grep     grep:.<cr>

" Custom mappings for the unite buffer
augroup unite
  autocmd FileType unite call s:unite_my_settings()
augroup end

function! s:unite_my_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <C-h>   <c-w>h
  nmap <buffer> <Esc>   :UniteClose<cr>
  nmap <buffer> q       :UniteClose<cr>
  nmap <buffer> i       ggk<plug>(unite_insert_enter)
endfunction
