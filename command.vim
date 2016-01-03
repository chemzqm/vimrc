" vim: set sw=2 ts=2 sts=2 et tw=78:

" Git commandline alias
command! -nargs=0 -bar C   Glcd
command! -nargs=0 -bar Gp  execute 'ItermStartTab! -dir='. expand('%:p:h') . ' git push'
command! -nargs=* -bar Gd  Gdiff <args>
command! -nargs=* -bar Gt  GdiffThis <args>
command! -nargs=* -bar Gc  Gci <args>

" add dictionary
command! -nargs=0 -bar Node    execute 'setl dictionary+=~/.vim/dict/node.dict'
command! -nargs=0 -bar Dom     execute 'setl dictionary+=~/.vim/dict/dom.dict'
command! -nargs=0 -bar Koa     execute 'setl dictionary+=~/.vim/dict/koa.dict'
command! -nargs=0 -bar Canvas  execute 'setl dictionary+=~/.vim/dict/canvas.dict'
command! -nargs=0 -bar Express execute 'setl dictionary+=~/.vim/dict/express.dict'

command! -nargs=0 -bar           Pretty   :call s:PrettyFile()
command! -nargs=0 -bar           Jsongen  :call s:Jsongen()
command! -nargs=0 -bar           Reset    :call s:StatusReset()
command! -nargs=0 -bar           Date     execute 'r !date "+\%Y-\%m-\%d \%H:\%M:\%S"'
command! -nargs=0 -bar           Standard execute '!standard --format %:p'
" search with ag and open quickfix window
command! -nargs=+ -complete=file Ag call g:Quickfix('ag', <f-args>)
command! -nargs=+                Ns call g:Quickfix('note', <f-args>)

" preview module files main/package.json/Readme.md
command! -nargs=1 -complete=custom,ListModules Me :call s:PreviewModule('<args>')
command! -nargs=1 -complete=custom,ListModules Mj :call s:PreviewModule('<args>', 'json')
command! -nargs=1 -complete=custom,ListModules Mh :call s:PreviewModule('<args>', 'doc')
command! -nargs=? -bang -complete=custom,s:ListVimrc  E  :call s:EditVimrc(<q-bang>, <f-args>)

command! -nargs=* -bar Update  execute "ItermStartTab! ~/.vim/vimrc/publish '<args>'"
command! -nargs=0 -bar Publish :call s:Publish()
command! -nargs=? -bar L       :call s:ShowGitlog('<args>')

function! g:Quickfix(type, ...)
  if a:type ==# 'ag'
    let pattern = s:FindPattern(a:000)
    let list = deepcopy(a:000)
    let g:grep_word = pattern[0]
    let list[pattern[1]] = shellescape(g:grep_word, 1)
    execute "silent grep! " . join(list, ' ')
  elseif a:type ==# 'note'
    let g:grep_word = a:1
    execute "silent SearchNote! " . join(a:000, ' ')
  endif
  execute "silent Unite -buffer-name=quickfix quickfix"
endfunction

function! s:FindPattern(list)
  let l = len(a:list)
  for i in range(l)
    let word = a:list[i]
    if word !~# '^-'
      return [word, i]
    endif
  endfor
endfunction

" module publish
function! s:Publish()
  " file at ~/bin/publish
  let dir = s:GetPackageDir()
  execute 'ItermStartTab! -dir=' . dir . ' -title=publish publish'
endfunction

function! s:ListVimrc(...)
  return join(map(split(globpath('~/.vim/vimrc/', '*.vim'),'\n'),
    \ "substitute(v:val, '" . expand('~'). "/.vim/vimrc/', '', '')")
    \ , "\n")
endfunction

function! s:EditVimrc(...)
  let edit = empty(a:1) ? 'edit' : 'tabedit'
  if a:0 < 2
    execute edit . ' ~/.vimrc'
  else
    execute 'lcd ~/.vim/vimrc'
    execute edit . ' ' . a:2
  endif
endfunction

" L input:[all:day]
function! s:ShowGitlog(arg)
  let args = split(a:arg, ':', 1)
  let input = get(args, 0, '')
  let arg = get(args, 1, '') . ':' . get(args, 2, '')
  execute 'Unite gitlog:' . arg . ' -input=' . input . ' -buffer-name=gitlog'
endfunction

function! ListModules(A, L, p)
  let res = s:Dependencies()
  return join(res, "\n")
endfunction
" Remove hidden buffers and cd to current dir
function! s:StatusReset()
  let dir = fnameescape(expand('%:p:h'))
  execute 'cd '.dir
  " delete hidden buffers
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
      silent execute 'bwipeout' buf
  endfor
endf

function! s:PreviewModule(name, ...)
  let dir = s:GetPackageDir()
  let content = webapi#json#decode(join(readfile(dir . '/package.json')))
  if !exists('content.browser') | let content.browser = [] | endif
  let name = get(content.browser, a:name, a:name)
  let dir = dir . '/node_modules/' . name
  if !isdirectory(dir) | echo 'module not found' | return | endif
  let content = webapi#json#decode(join(readfile(dir . '/package.json')))
  if empty(a:000)
    " fix main field
    let main = exists('content.main') ? content.main : 'index.js'
    let main = main =~# '\v\.js$' ? main : main . '.js'
    let file = dir . '/' . substitute(main, '\v^(./)?', '', '')
  else
    let type = a:000[0]
    if type ==? 'doc'
      let list = filter(split(glob(dir . '/*.md'), '\n'), 'v:val =~? "readme\.md"')
      if len(list) |let file = list[0] |endif
    elseif type ==? 'json'
      let file = dir . '/package.json'
    endif
  endif
  if !exists('file') | echon 'not found' | return | endif
  execute 'silent keepalt split ' . file
endfunction

function! s:GetPackageDir()
  let file = findfile('package.json', '.;')
  if empty(file)
    echohl Error | echon 'project root not found' | echohl None
    return
  endif
  return fnamemodify(file, ':h')
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

function! s:Jsongen()
  let file = expand('%:p')
  if !&filetype =~? 'handlebars$'
    echoerr 'file type should be handlebars'
    return
  endif
  let out = substitute(file, '\v\.hbs$', '.json', '')
  let output = system('Jsongen ' . file . ' > ' . out)
  if v:shell_error && output !=# ""
    echohl WarningMsg | echon output | echohl None
    return
  endif
  let exist = 0
  for i in range(winnr('$'))
    let nr = i + 1
    let fname = fnamemodify(bufname(winbufnr(nr)), ':p')
    if fname ==# out
      let exist = 1
      exe nr . 'wincmd w'
      exec 'e ' . out
      break
    endif
  endfor
  if !exist | execute 'keepalt belowright vs ' . out | endif
  exe 'wincmd p'
endfunction


" npm update -g js-beautify
" npm update -g cssfmt
" brew update tidy-html5
let g:Pretty_commmand_map = {
    \ "css": "cssfmt",
    \ "html": "tidy -i -q -w 160",
    \ "javascript": "js-beautify -s 2 -p -f -",
    \}
function! s:PrettyFile()
  let cmd = get(g:Pretty_commmand_map, &filetype, '')
  if !len(cmd)
    echohl Error | echon 'Filetype not supported' | echohl None
    return
  endif
  let win_view = winsaveview()
  let old_cwd = getcwd()
  " some tool may use project specified config
  silent exe ':lcd ' . expand('%:p:h')
  let output = system(cmd, join(getline(1,'$'), "\n"))
  if v:shell_error
    echohl Error | echon 'Got error during processing' | echohl None
    echo output
  else
    silent exe 'normal! ggdG'
    let list = split(output, "\n")
    if len(list)
      call setline(1, list[0])
      call append(1, list[1:])
    endif
  endif
  exe 'silent lcd ' . old_cwd
  call winrestview(win_view)
endfunction
