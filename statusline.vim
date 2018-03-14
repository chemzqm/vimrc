let s:job_status = {}

function! MyStatusSyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! MyStatusLine()
  let errorMsg = has('nvim') ? "%= %3*%{MyStatusLocError()}%* %=" : ""
  return s:GetPaste()
        \. "%4*%{MyStatusGit()}%*"
        \. "%5*%{MyStatusGitChanges()}%*"
        \. " %f %{MyStatusModifySymbol()}"
        \. " %{MyStatusReadonly()}"
        \. errorMsg
        \. "%=%-{&ft} %l, %c "
"%{&fenc}
endfunction

function! s:IsTempFile()
  if !empty(&buftype) | return 1 | endif
  if &filetype ==# 'gitcommit' | return 1 | endif
  if expand('%:p') =~# '^/tmp' | return 1 | endif
endfunction

function! s:GetPaste()
  if !&paste | return '' |endif
  return "%#MyStatusPaste# paste %*"
endfunction

function! MyStatusReadonly()
  if !&readonly | return '' |endif
  return "  "
endfunction

function! MyStatusModifySymbol()
  return &modified ? '⚡' : ''
endfunction

function! MyStatusGitChanges() abort
  if s:IsTempFile() | return '' | endif
  let gutter = get(b:, 'gitgutter', {})
  if empty(gutter) | return '' | endif
  let summary = get(gutter, 'summary', [])
  if empty(summary) | return '' | endif
  if summary[0] == 0 && summary[1] == 0 && summary[2] == 0
    return ''
  endif
  return '  +'.summary[0].' ~'.summary[1].' -'.summary[2].' '
endfunction

function! MyStatusGit(...) abort
  if exists('b:git_branch') | return b:git_branch | endif
  if !exists('*easygit#smartRoot') | return '' | endif
  if s:IsTempFile() | return '' | endif
  " only support neovim
  if !exists('*jobstart') | return '' | endif
  let roots = values(s:job_status)
  let root = easygit#smartRoot(1)
  " it's running
  if empty(root) | return '' | endif
  if index(roots, root) >= 0 | return '' | endif
  let nr = bufnr('%')
  let job_id = jobstart(['git-status'], {
    \ 'cwd': root,
    \ 'on_stdout': function('s:JobHandler', [root]),
    \ 'on_stderr': function('s:JobHandler', [root]),
    \ 'on_exit': function('s:JobHandler', [root])
    \})
  if job_id == 0 || job_id == -1 | return '' | endif
  let s:job_status[job_id] = root
  return ''
endfunction

function! s:JobHandler(root, job_id, data, event)
  if !has_key(s:job_status, a:job_id) | return | endif
  if a:event ==# 'stdout'
    let output = join(a:data)
    call s:SetGitStatus(a:root, ' '.output.' ')
  elseif a:event ==# 'stderr'
    echohl Error | echon join(a:data) | echohl None
  else
    call remove(s:job_status, a:job_id)
  endif
endfunction

function! s:SetGitStatus(root, str)
  let buf_list = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  for nr in buf_list
    let path = fnamemodify(bufname(nr), ':p')
    if match(path, a:root) >= 0
      call setbufvar(nr, 'git_branch', a:str)
    endif
  endfor
  redraws!
endfunction

function! SetStatusLine()
  if &previewwindow | return | endif
  if s:IsTempFile() | return | endif
  if exists('b:git_branch') | unlet b:git_branch | endif
  setl statusline=%!MyStatusLine()
  call s:highlight()
endfunction

function! s:PrintError(msg)
  echohl Error | echon a:msg | echohl None
endfunction

function! s:highlight()
  hi User3         guifg=#e03131 guibg=#111111    gui=none
  hi MyStatusPaste guifg=#F8F8F0 guibg=#FF5F00 gui=none
  hi MyStatusPaste ctermfg=202   ctermbg=16    cterm=none
  hi user4 guifg=#f8f8ff guibg=#000000
  hi user5 guifg=#f8f9fa guibg=#343a40
endfunction

function! MyStatusLocError()
  let list = filter(getloclist('%'), 'v:val["type"] ==# "E"')
  if len(list)
    return ' ' . string(list[0].lnum) . ' ' . list[0].text
  else
    return ''
  endif
endfunction

augroup statusline
  autocmd!
  autocmd User GitGutter call SetStatusLine()
  autocmd BufWinEnter,ShellCmdPost,BufWritePost * call SetStatusLine()
  autocmd FileChangedShellPost,ColorScheme * call SetStatusLine()
  autocmd FileReadPre,ShellCmdPost,FileWritePost * unlet! b:git_branch
augroup end
