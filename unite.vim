" Config ag for file_rec source
if executable('ag')
  let g:unite_source_rec_async_command =
    \ ['ag', '--nocolor', '--nogroup',
    \  '--depth', '10', '-g', '']
  " ag is quite fast, so we increase this number
  let g:unite_source_rec_min_cache_files = 1200
endif
let g:neomru#do_validate = 1
let g:neomru#follow_links = 1
" Project folders for Unite project
let g:project_folders = ['~/component-dev', '~/nodejs-dev', '~/vim-dev', '~/.vim/bundle']
" Use regexp match as default matcher
call unite#filters#matcher_default#use(['matcher_regexp'])
" Ignore files by wildignore option
call unite#custom#source(
  \  'file_rec,file_rec/async,file_mru,file,buffer',
  \  'ignore_globs',
  \  split(&wildignore, ',') + ['todo://']
  \ )
" Some source use fuzzy match would be better
call unite#custom#source(
  \  'file_mru,buffer,outline,func,command,project', 'matchers', ['matcher_fuzzy']
  \ )
" Converter the path of files, not be too long!
call unite#custom#source(
  \  'file_rec,file_rec/async', 'matchers', ['converter_relative_word', 'matcher_fuzzy']
  \ )
" Sometimes selecta sorter would help to find the target quicker
call unite#custom#source(
  \  'buffer,file_rec,project,command,func', 'sorters', 'sorter_selecta'
  \)
call unite#custom#source(
  \  'note', 'sorters', ['sorter_ftime', 'sorter_reverse']
  \)
" Limit max candidates
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
call unite#custom#profile('project', 'context', {
  \  'start_insert': 1,
  \ })
call unite#custom#profile('todo', 'context', {
  \  'winheight': 10,
  \ })
call unite#custom#profile('buffer', 'context', {
  \  'auto_resize': 1,
  \ })

nnoremap [unite] <Nop>
nmap <space>  [unite]
nnoremap <silent> [unite]t  :<C-u>Unite -buffer-name=project   project<cr>
nnoremap <silent> [unite]f  :<C-u>Unite -buffer-name=files     file_rec/async:.<cr>
nnoremap <silent> [unite]e  :<C-u>Unite -buffer-name=buffer    buffer<cr>
nnoremap <silent> [unite]r  :<C-u>Unite -buffer-name=file_mru  file_mru<cr>
nnoremap <silent> [unite]o  :<C-u>Unite -buffer-name=outline   outline<cr>
nnoremap <silent> [unite]n  :<C-u>Unite -buffer-name=note      note<cr>
nnoremap <silent> [unite]g  :<C-u>Unite -buffer-name=gist      gist<cr>
nnoremap <silent> [unite]p  :<C-u>Unite -buffer-name=process   process<cr>
nnoremap <silent> [unite]q  :<C-u>Unite -buffer-name=quickfix  quickfix<cr>
nnoremap <silent> [unite]l  :<C-u>Unite -buffer-name=location  location_list<cr>
nnoremap <silent> [unite]u  :<C-u>Unite -buffer-name=ultisnips ultisnips:all<cr>
nnoremap <silent> [unite]m  :<C-u>Unite -buffer-name=emoji     emoji<cr>
nnoremap <silent> [unite]a  :<C-u>Unite -buffer-name=node      node<cr>
nnoremap <silent> [unite]c  :<C-u>Unite -buffer-name=command   command<cr>
nnoremap <silent> [unite]s  :<C-u>Unite -buffer-name=session   session<cr>
nnoremap <silent> [unite]d  :<C-u>Unite -buffer-name=todo      todo<cr>
nnoremap <silent> [unite]w  :<C-u>exec 'Unite -input=\<'. expand('<cword>') .'\> -no-start-insert line:buffers'<cr>

nmap <leader>u :call <SID>ToggleUnite()<cr>
" Quickly navigate through candidates
nmap [unite]j :<C-u>call <SID>Jump(v:count1, 'Next')<cr>
nmap [unite]k :<C-u>call <SID>Jump(v:count1, 'Previous')<cr>
" Custom mappings for the unite buffer
augroup unite
  autocmd FileType unite call s:unite_my_settings()
augroup end

function! s:unite_my_settings()
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <C-r>   <Plug>(unite_restart)
  nmap <buffer> <Esc>   :UniteClose<cr>
  nmap <buffer> q       <Plug>(unite_exit)
  nmap <buffer> i       <plug>(unite_append_end)
  let unite = unite#get_current_unite()
  nnoremap <silent><buffer><expr> e     unite#do_action('edit')
  if unite.profile_name ==# 'todo'
    nnoremap <silent><buffer><expr> n     unite#do_action('new')
  elseif unite.profile_name ==# 'gitlog'
    nnoremap <silent><buffer><expr> r     unite#do_action('reset')
  elseif unite.profile_name ==# 'node'
    nnoremap <silent><buffer><expr> m     unite#do_action('main')
    nnoremap <silent><buffer><expr> h     unite#do_action('help')
    nnoremap <silent><buffer><expr> b     unite#do_action('browser')
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
