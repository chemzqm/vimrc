if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts='--line-numbers --nocolor --nogroup'
  let g:unite_source_rec_async_command =
    \ ['ag', '--nocolor', '--nogroup',
    \  '--depth', '10', '-g', '']
  let g:unite_source_rec_min_cache_files = 1200
endif

let g:project_folders = ['~/component-dev', '~/nodejs-dev', '~/vim-dev', '~/.vim/bundle']
let g:neomru#follow_links = 1
call unite#filters#matcher_default#use(['matcher_regexp'])
call unite#custom#source(
  \  'file_rec,file_rec/async,file_mru,file,buffer',
  \  'ignore_globs',
  \  split(&wildignore, ',')
  \ )
call unite#custom#source(
  \  'file_mru,buffer,outline,func,command,project', 'matchers', ['matcher_fuzzy']
  \ )
call unite#custom#source(
  \  'file_rec,file_rec/async', 'matchers', ['converter_relative_word', 'matcher_fuzzy']
  \ )
call unite#custom#source(
  \  'buffer,file_rec', 'sorters', 'sorter_selecta'
  \)
call unite#custom#source(
  \  'file_mru,file_rec,file_rec/async,quickfix', 'max_candidates', 500
  \ )
call unite#custom#profile('default', 'context', {
  \  'winheight': 10,
  \  'no_empty': 1,
  \ })
call unite#custom#profile('file_mru', 'context', {
  \  'winheight': 20,
  \  'start_insert': 1,
  \ })
call unite#custom#profile('ultisnips', 'context', {
  \  'winheight': 10,
  \ })
call unite#custom#profile('files', 'context', {
  \ })
call unite#custom#profile('quickfix', 'context', {
  \  'no_quit': 1,
  \ })
call unite#custom#profile('location', 'context', {
  \  'no_quit': 1,
  \  'winheight': 5,
  \ })
call unite#custom#profile('gitlog', 'context', {
  \  'no_quit': 1,
  \  'vertical_preview': 1,
  \ })
call unite#custom#profile('outline', 'context', {
  \  'winheight': 15,
  \ })
call unite#custom#profile('buffer', 'context', {
  \ })
call unite#custom#profile('yank', 'context', {
  \  'no_split': 1,
  \  'start_insert': 1,
  \ })
call unite#custom#profile('project', 'context', {
  \  'start_insert': 1,
  \ })

nnoremap [unite] <Nop>
nmap <space>  [unite]
nnoremap <silent> [unite]t  :<C-u>Unite -buffer-name=project   project<cr>
nnoremap <silent> [unite]f  :<C-u>Unite -buffer-name=files     file_rec/async:.<cr>
nnoremap <silent> [unite]e  :<C-u>Unite -buffer-name=buffer    buffer<cr>
nnoremap <silent> [unite]r  :<C-u>Unite -buffer-name=file_mru  file_mru<cr>
nnoremap <silent> [unite]y  :<C-u>Unite -buffer-name=yank      history/yank<cr>
nnoremap <silent> [unite]o  :<C-u>Unite -buffer-name=outline   outline<cr>
nnoremap <silent> [unite]n  :<C-u>Unite -buffer-name=note      note<cr>
nnoremap <silent> [unite]g  :<C-u>Unite -buffer-name=gist      gist<cr>
nnoremap <silent> [unite]p  :<C-u>Unite -buffer-name=process   process<cr>
nnoremap <silent> [unite]q  :<C-u>Unite -buffer-name=quickfix  quickfix<cr>
nnoremap <silent> [unite]l  :<C-u>Unite -buffer-name=location  location_list<cr>
nnoremap <silent> [unite]u  :<C-u>Unite -buffer-name=ultisnips ultisnips:all<cr>
nnoremap <silent> [unite]m  :<C-u>Unite -buffer-name=emoji     emoji<cr>
nnoremap <silent> [unite]c  :<C-u>Unite -buffer-name=command   command<cr>

nmap <leader>u :call <SID>ToggleUnite()<cr>
nmap [unite]j :<C-u>call <SID>Jump(v:count1, 'Next')<cr>
nmap [unite]k :<C-u>call <SID>Jump(v:count1, 'Previous')<cr>
" Custom mappings for the unite buffer
augroup unite
  autocmd FileType unite call s:unite_my_settings()
augroup end

function! s:unite_my_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <C-r>   <Plug>(unite_restart)
  nmap <buffer> <Esc>   :UniteClose<cr>
  nmap <buffer> q       <Plug>(unite_exit)
  nmap <buffer> H       <Plug>(unite_quick_help)
  nmap <buffer> i       <plug>(unite_append_end)
  let unite = unite#get_current_unite()
  nnoremap <silent><buffer><expr> e     unite#do_action('edit')
  if unite.profile_name ==# 'gitlog'
    nnoremap <silent><buffer><expr> r     unite#do_action('reset')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif
endfunction

function! s:Jump(count, dir)
  if a:count == 1
    execute 'Unite' . a:dir
  else
    execute a:count . 'Unite' . a:dir
  endif
endfunction

function! s:ToggleUnite()
  for i in range(1, winnr('$'))
    let name = bufname(winbufnr(i))
    if match(name, '^\[unite\]') == 0
      UniteClose
      return
    endif
  endfor
  UniteResume
endfunction

function! GetUniteWinnr()
  for i in range(1, winnr('$'))
    let name = bufname(winbufnr(i))
    if match(name, '^\[unite\]') == 0
      return i
    endif
  endfor
endfunction
