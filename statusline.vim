let s:job_status = {}

function! MyStatusLine()
  return s:GetPaste()
        \. "%4*%{MyStatusGit()}%*"
        \. "%5*%{MyStatusGitChanges()}%* %{MyStatusCoc()}"
        \. " %{MyStatusTsc()} %f %{MyStatusModifySymbol()}"
        \. " %{MyStatusReadonly()}"
        \. "%=%-{&ft} %l,%c %P "
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

function! MyStatusCoc()
  if get(g:, 'did_coc_loaded', 0)
    return coc#status()
  endif
  return ''
endfunction

function! MyStatusTsc()
  if s:IsTempFile() | return '' | endif
  let s = get(g:, 'tsc_status', '')
  if s ==? 'init'
    return ''
  elseif s ==? 'compiling'
    return '🏃'
  elseif s ==? 'running'
    return '🐳'
  elseif s ==? 'stopped'
    return '⚪️'
  elseif s ==? 'error'
    return '🔴'
  endif
  return ''
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
  if s:IsTempFile() | return '' | endif
  let reload = get(a:, 1, 0) == 1
  if exists('b:git_branch') && !reload | return b:git_branch | endif
  if !exists('*FugitiveExtractGitDir') | return '' | endif
  if s:IsTempFile() | return '' | endif
  " only support neovim
  if !exists('*jobstart') | return '' | endif
  let roots = values(s:job_status)
  let dir = get(b:, 'git_dir', FugitiveExtractGitDir(resolve(expand('%:p'))))
  if empty(dir) | return '' | endif
  let b:git_dir = dir
  let root = fnamemodify(dir, ':h')
  if index(roots, root) >= 0 | return '' | endif
  let nr = bufnr('%')
  let job_id = jobstart('git-status', {
    \ 'cwd': root,
    \ 'stdout_buffered': v:true,
    \ 'stderr_buffered': v:true,
    \ 'on_exit': function('s:JobHandler')
    \})
  if job_id == 0 || job_id == -1 | return '' | endif
  let s:job_status[job_id] = root
  return ''
endfunction

function! s:JobHandler(job_id, data, event) dict
  if !has_key(s:job_status, a:job_id) | return | endif
  if v:dying | return | endif
  if !empty(self.stdout)
    let output = join(self.stdout)
    if !empty(output)
      call s:SetGitStatus(self.cwd, ' '.output.' ')
    endif
  else
    let errs = join(self.stderr)
    if !empty(errs) | echoerr errs | endif
  endif
  call remove(s:job_status, a:job_id)
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
  call MyStatusGit(1)
  setl statusline=%!MyStatusLine()
  call s:highlight()
endfunction

function! s:PrintError(msg)
  echohl Error | echon a:msg | echohl None
endfunction

function! s:highlight()
  hi User6         guifg=#fb4934 guibg=#282828 gui=none
  hi User3         guifg=#e03131 guibg=#111111    gui=none
  hi MyStatusPaste guifg=#F8F8F0 guibg=#FF5F00 gui=none
  hi MyStatusPaste ctermfg=202   ctermbg=16    cterm=none
  hi User4 guifg=#f8f8ff guibg=#000000
  hi User5 guifg=#f8f9fa guibg=#343a40
endfunction

augroup statusline
  autocmd!
  autocmd User GitGutter call SetStatusLine()
  autocmd BufWinEnter,ShellCmdPost,BufWritePost * call SetStatusLine()
  autocmd FileChangedShellPost,ColorScheme * call SetStatusLine()
  autocmd FileReadPre,ShellCmdPost,FileWritePost * call SetStatusLine()
augroup end
