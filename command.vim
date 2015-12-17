" vim: foldmethod=syntax foldlevel=0:

" Git commandline alias
command! -nargs=0 -bar C   :Glcd .
command! -nargs=0 -bar Gp  :call s:Push()
command! -nargs=* -bar Gc  execute 'Gcommit '. expand('%') . " -m '<args>'"
command! -nargs=0 -bar Gca execute 'Gcommit -a -v'

" add dictionary
command! -nargs=0 -bar Canvas  execute 'setl dictionary+=~/.vim/dict/canvas.dict'
command! -nargs=0 -bar Dom     execute 'setl dictionary+=~/.vim/dict/dom.dict'
command! -nargs=0 -bar Express execute 'setl dictionary+=~/.vim/dict/express.dict'
command! -nargs=0 -bar Koa     execute 'setl dictionary+=~/.vim/dict/koa.dict'

" remove file from filesystem
command! -nargs=0 -bar Copy     execute 'silent w !tee % | pbcopy > /dev/null'
command! -nargs=0 -bar Rm       execute 'call Remove()'
command! -nargs=0 -bar Reset    execute 'call StatusReset()'
command! -nargs=0 -bar Standard execute '!standard --format %:p'
command! -nargs=0 -bar Emoji    execute 'set completefunc=emoji#complete'
command! -nargs=0 -bar Date     execute 'r !date "+\%Y-\%m-\%d \%H:\%M:\%S"'
command! -nargs=0 -bar Qargs    execute 'args' s:QuickfixFilenames()

" preview module files main/package.json/Readme.md
command! -nargs=1 -complete=custom,s:ListModules G     :call s:PreviewModule('<args>')
command! -nargs=1 -complete=custom,s:ListModules J     :call s:PreviewModule('<args>', 'json')
command! -nargs=1 -complete=custom,s:ListModules H     :call s:PreviewModule('<args>', 'doc')
command! -nargs=? -complete=custom,s:ListVimrc   E     :call s:EditVimrc(<f-args>)
command! -nargs=* -bar                         Update  execute "Start ~/.vim/vimrc/publish '<args>'"
command! -nargs=0 -bar                         Publish :call s:Publish()
command! -nargs=? -bar                         L       :call s:ShowGitlog('<args>')

function! s:ListVimrc(...)
  return join(map(split(globpath('~/.vim/vimrc/', '*.vim'),'\n'),
    \ "substitute(v:val, '/Users/chemzqm/.vim/vimrc/', '', '')")
    \ , "\n")
endfunction

function! s:EditVimrc(...)
  if !a:0
    execute "e ~/.vimrc"
  else
    execute "e ~/.vim/vimrc/" . a:1
  endif
endfunction

function! s:ShowGitlog(arg)
  let args = split(a:arg, ':', 1)
  let input = get(args, 0, '')
  let arg = get(args, 1, '') . ':' . get(args, 2, '')
  execute 'Unite gitlog:' . arg . ' -input=' . input . ' -buffer-name=gitlog'
endfunction

function! s:ListModules(A, L, p)
  let res = s:Dependencies()
  return join(res, "\n")
endfunction

function! s:Push()
  execute 'Start -dir='. expand('%:p:h') . ' git push'
endfunction

function! s:Remove()
  let file = expand('%:p')
  let buf = bufnr('%')
  execute "bwipeout " . buf
  if filereadable(file)
    call system("rm ".file)
  endif
endfunction

function! s:QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Remove hidden buffers and cd to current dir
function! s:StatusReset()
  let dir = fnameescape(expand('%:p:h'))
  execute "cd ".dir
  " delete hidden buffers
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
      silent execute 'bwipeout' buf
  endfor
endf

function! s:PreviewModule(name, ...)
  if empty(a:name) | echo "need module name" | return | endif
  let dir = s:GetPackageDir()
  let content = webapi#json#decode(join(readfile(dir . '/package.json')))
  if exists('content.browser')
    let name = get(content.browser, a:name, a:name)
  else
    let name = a:name
  endif
  let dir = dir . '/node_modules/' . name
  if !isdirectory(dir) | echo 'module not found' | return | endif
  let content = webapi#json#decode(join(readfile(dir . '/package.json')))
  if empty(a:000)
    let main = exists('content.main') ? content.main : 'index.js'
    let main = main =~# '\v\.js$' ? main : main . '.js'
    let file = dir . '/' . substitute(main, '\v^(./)?', '', '')
  else
    let type = a:000[0]
    if type ==? 'doc'
      for name in ['readme', 'Readme', 'README']
        if filereadable(dir . '/' . name . '.md')
          let file = dir . '/' . name . '.md'
          break
        endif
      endfor
    elseif type ==? 'json'
      let file = dir . "/package.json"
    endif
  endif
  if !exists('file') | echohl WarningMsg | echon 'not found' | return | endif
  let h = &previewheight
  let &previewheight = 40
  execute "pedit " . file
  let &previewheight = h
  execute "normal! \<c-w>k"
endfunction

" module publish
function! s:Publish()
  " file at ~/bin/publish
  let dir = s:GetPackageDir()
  execute "Start -dir=" . dir . " -title=publish publish"
endfunction

" package directory of current file
function! s:GetPackageDir()
  let dir = expand('%:p:h')
  while 1
    if filereadable(dir . '/package.json')
      return dir
    endif
    let dir = fnamemodify(dir, ':h')
    if dir ==# '/Users/chemzqm'
      echohl WarningMsg | echon 'package.json not found'
      return
    endif
  endwhile
endfunction

function! s:Dependencies()
  let dir = s:GetPackageDir()
  let obj = webapi#json#decode(join(readfile(dir . '/package.json'), ''))
  let browser = exists('obj.browser')
  let deps = browser ? keys(obj.browser) : []
  let vals = browser ? values(obj.browser) : []
  for key in keys(obj.dependencies)
    if index(vals, key) == -1
      call add(deps, key)
    endif
  endfor
  return deps
endfunction
