" vim: set sw=2 ts=2 sts=2 et tw=78:
command! -nargs=0 Q          :qa!
command! -nargs=0 V          :call s:OpenTerminal()
command! -nargs=0 C          :call s:Gcd()
command! -nargs=0 Mouse      :call s:ToggleMouse()
command! -nargs=0 Pretty     :call s:PrettyFile()
command! -nargs=0 Jsongen    :call s:Jsongen()
command! -nargs=0 Cp         :call s:CopyJson()
command! -nargs=0 Reset      :call s:StatusReset()
" vim color highlight for current buffer
command! -nargs=0 Color      :call s:HighlightColor()
command! -nargs=0 Standard   execute '!standard --format %:p'
command! -nargs=0 SourceTest execute 'source ~/.vim/test.vim'
command! -nargs=* Update     execute "Nrun ~/.vim/vimrc/publish '<args>'"
command! -nargs=0 Post       execute "Nrun cd ".expand('~')."/lib/blog;and make remote"
command! -nargs=? Gitlog     :call s:ShowGitlog('<args>')
command! -nargs=0 AutoExe    :call s:ToggleExecute()
command! -nargs=0 -range=%   Prefixer call s:Prefixer(<line1>, <line2>)
" search with ag and open quickfix window
command! -nargs=+ -complete=file Ag call g:Quickfix('ag', <f-args>)
command! -nargs=? -complete=custom,s:ListVimrc   EditVimrc  :call s:EditVimrc(<f-args>)
command! -nargs=? -complete=custom,s:ListDict    Dict       :call s:ToggleDictionary(<f-args>)

" lcd to current git root
function! s:Gcd()
  let dir = easygit#gitdir(expand('%'))
  if empty(dir)
    let dir = expand('%:p:h')
  else
    let dir = fnamemodify(dir, ':h')
  endif
  if !empty(dir)
    execute 'lcd ' . dir
  endif
endfunction

" toggle auto execute current file
function! s:ToggleExecute()
  if get(b:, 'auto_execute', 0) == 1
    let b:auto_execute = 0
  else
    let b:auto_execute = 1
  endif
endfunction

" Copy pretty json to system clipboard
function! s:CopyJson()
  setf json
  execute 'Pretty'
  execute 'Copy'
endfunction

" Open vertical spit terminal with current parent directory
function! s:OpenTerminal()
  let bn = bufnr('%')
  let dir = expand('%:p:h')
  if exists('b:terminal') && !buflisted(get(b:, 'terminal'))
    unlet b:terminal
  endif
  if !exists('b:terminal')
    belowright vs +enew
    exe 'lcd '.dir
    execute 'terminal'
    call setbufvar(bn, 'terminal', bufnr('%'))
  else
    execute 'belowright vertical sb '.get(b:, 'terminal', '')
    call feedkeys("\<C-l>", 'n')
  endif
endfunction

function! s:ListDict(A, L, P)
  let output = system('ls ~/.vim/dict/')
  return join(map(split(output, "\n"), 'substitute(v:val, ".dict", "", "")'), "\n")
endfunction

" Toggle dictionary list
function! s:ToggleDictionary(...)
  for name in a:000
    if stridx(&dictionary, name) != -1
      execute 'setl dictionary-=~/.vim/dict/'.name.'.dict'
    else
      execute 'setl dictionary+=~/.vim/dict/'.name.'.dict'
    endif
  endfor
endfunction

" Prefix css code with postcss and cssnext
function! s:Prefixer(line1, line2)
  let input = join(getline(a:line1, a:line2), "\n")
  let g:input = input
  let output = system('postcss --use postcss-cssnext', input)
  if v:shell_error && output !=# ""
    echohl Error | echon output | echohl None
    return
  endif
  let win_view = winsaveview()
  execute a:line1.','.a:line2.'d'
  call append(a:line1 - 1, split(output, "\n"))
  call winrestview(win_view)
endfunction

function! g:Quickfix(type, ...)
  " clear existing list
  cexpr []
  let pattern = s:FindPattern(a:000)
  let list = deepcopy(a:000)
  let g:grep_word = pattern[0]
  let g:grep_command = 'grep '. join(list, ' ')
  let list[pattern[1]] = shellescape(g:grep_word, 1)
  execute "silent grep! " . join(list, ' ')
  execute "Unite -buffer-name=quickfix quickfix"
endfunction

function! s:FindPattern(list)
  let l = len(a:list)
  for i in range(l)
    let word = a:list[i]
    if word !~# '\v^\s*-'
      return [word, i]
    endif
  endfor
endfunction

function! s:ListVimrc(...)
  return join(map(split(globpath('~/.vim/vimrc/', '*.vim'),'\n'),
    \ "substitute(v:val, '" . expand('~'). "/.vim/vimrc/', '', '')")
    \ , "\n")
endfunction

function! s:EditVimrc(...)
  if a:0 == 0
    execute 'edit ~/.vimrc'
  else
    execute 'edit ~/.vim/vimrc/' . a:1
  endif
endfunction

" L input:[all:day]
function! s:ShowGitlog(arg)
  let args = split(a:arg, ':', 1)
  let input = get(args, 0, '')
  let arg = get(args, 1, '') . ':' . get(args, 2, '')
  execute 'Unite gitlog:' . arg . ' -input=' . input . ' -buffer-name=gitlog'
endfunction

" Remove hidden buffers and cd to current dir
function! s:StatusReset()
  let gitdir = easygit#gitdir(expand('%'), 1)
  if empty(gitdir)
    let dir = fnameescape(expand('%:p:h'))
  else
    let dir = fnamemodify(gitdir, ':h')
  endif
  execute 'cd '.dir
  " delete hidden buffers
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout! '. buf
  endfor
endf

function! s:HighlightColor()
  redraw
  if &ft ==# 'vim'
    call css_color#init('hex', 'none', 'vimHiGuiRgb,vimComment,vimLineComment')
  elseif &ft =~# '\v(css|html)'
    call css_color#init('css', 'extended', 'cssMediaBlock,cssFunction,cssDefinition,cssAttrRegion,cssComment')
  endif
endfunction

" Generate json from handlebars template
function! s:Jsongen()
  let file = expand('%:p')
  if &filetype !~ 'handlebars$'
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
    \ "json": "json",
    \ "css": "cssfmt",
    \ "html": "tidy -i -q -w 160",
    \ "xml": " xmllint --format -encode utf8 -",
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

function! s:ToggleMouse()
  if empty(&mouse)
    set mouse=a
  else
    set mouse=
  endif
endfunction
