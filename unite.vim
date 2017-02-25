" Project folders for Unite project
let g:project_folders = ['~/wechat-dev', '~/component-dev', '~/vim-dev']
" Use regexp match as default matcher
call unite#filters#matcher_default#use(['matcher_regexp'])
" Some source use fuzzy match would be better
call unite#custom#source(
  \  'redismru,buffer,func,command,project', 'matchers', ['matcher_fuzzy']
  \ )
" Sometimes selecta sorter would help to find the target quicker
call unite#custom#source(
  \  'project,command,func', 'sorters', 'sorter_selecta'
  \)
call unite#custom#source(
  \  'note', 'sorters', ['sorter_ftime', 'sorter_reverse']
  \)
call unite#custom#profile('default', 'context', {
  \  'winheight': 10,
  \  'no_empty': 1,
  \ })
call unite#custom#profile('ultisnips', 'context', {
  \  'winheight': 10,
  \ })
call unite#custom#profile('project', 'context', {
  \  'start_insert': 1,
  \ })
call unite#custom#profile('todo', 'context', {
  \  'winheight': 10,
  \ })

nnoremap [unite] <Nop>
nmap <space>  [unite]
nnoremap <silent> [unite]m  :<C-u>Unite -buffer-name=emoji     emoji<cr>

nnoremap <silent> [unite]n  :<C-u>Unite -buffer-name=note      note<cr>
nnoremap <silent> [unite]d  :<C-u>Unite -buffer-name=todo      todo<cr>
nnoremap <silent> [unite]s  :<C-u>Unite -buffer-name=session   session<cr>
nnoremap <silent> [unite]t  :<C-u>Unite -buffer-name=project   project<cr>
nnoremap <silent> [unite]a  :<C-u>Unite -buffer-name=node      node<cr>
nnoremap <silent> [unite]c  :<C-u>Unite -buffer-name=command   command<cr>
nnoremap <silent> [unite]u  :<C-u>Unite -buffer-name=ultisnips ultisnips:all<cr>

" Quickly navigate through candidates
nmap <leader>j :<C-u>call <SID>Jump(v:count1, 'Next')<cr>
nmap <leader>k :<C-u>call <SID>Jump(v:count1, 'Previous')<cr>
" Custom mappings for the unite buffer
augroup unite
  autocmd!
  autocmd FileType unite call s:unite_my_settings()
augroup end

function! s:unite_my_settings()
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <C-r>   <Plug>(unite_restart)
  nmap <buffer> <C-k>   <C-w>k
  nmap <buffer> <Esc>   :UniteClose<cr>
  nmap <buffer> q       <Plug>(unite_exit)
  nmap <buffer> i       <plug>(unite_append_end)
  nmap <buffer> <C-h>   <C-w>h
  let unite = unite#get_current_unite()
  nnoremap <silent><buffer><expr> s     unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> e     unite#do_action('edit')
  if unite.profile_name ==# 'todo'
    nnoremap <silent><buffer><expr> n     unite#do_action('new')
  elseif unite.profile_name ==# 'gitstatus'
    nnoremap <silent><buffer><expr> r     unite#do_action('reset')
    nnoremap <silent><buffer><expr> a     unite#do_action('add')
    nnoremap <silent><buffer><expr> c     unite#do_action('commit')
  elseif unite.profile_name ==# 'gitlog'
    nnoremap <silent><buffer><expr> r     unite#do_action('reset')
  elseif unite.profile_name ==# 'node'
    nnoremap <silent><buffer><expr> u     unite#do_action('update')
    nnoremap <silent><buffer><expr> o     unite#do_action('open')
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
