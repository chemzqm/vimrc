" vim: set sw=2 ts=2 sts=2 et tw=78:
command! -nargs=0 Save                                 :call     s:Save()
command! -nargs=0 Format                               :call     CocAction('format')
command! -nargs=0 PickColor                            :call     CocAction('pickColor')
command! -nargs=0 CP                                   :call     CocAction('colorPresentation')
command! -nargs=0 Prettier                             :call     CocAction('runCommand', 'prettier.formatFile')
command! -nargs=0 Tslint                               :call     CocAction('runCommand', 'tslint.lintProject')
command! -nargs=0 Tsc                                  :call     CocAction('runCommand', 'tsserver.watchBuild')
command! -nargs=0 OR                                   :call     CocAction('runCommand', 'tsserver.organizeImports')
command! -nargs=0 Q                                    :qa!
command! -nargs=0 V                                    :call     s:OpenTerminal()
command! -nargs=0 Cd                                   :call     s:Gcd()
command! -nargs=0 Commits                              :CocList  commits
command! -nargs=0 Mouse                                :call     s:ToggleMouse()
command! -nargs=0 Jsongen                              :call     s:Jsongen()
command! -nargs=0 Reset                                :call     s:StatusReset()
command! -nargs=? Fold                                 :call     CocAction('fold', <f-args>)
command! -nargs=* Execute                              :call     s:Execute(<q-args>)
command! -nargs=0 Ctags                                :execute  'Nrun ctags -R .'
command! -nargs=0 -range=%                             Prefixer  call  s:Prefixer(<line1>, <line2>)
command! -nargs=+ -complete=custom,s:GrepArgs          Rg        :exe 'CocList grep '.<q-args>
command! -nargs=? -complete=custom,s:ListVimrc         EditVimrc :call s:EditVimrc(<f-args>)
command! -nargs=? -complete=custom,s:ListDict          Dict      :call s:ToggleDictionary(<f-args>)
command! -nargs=* -complete=custom,easygit#completeAdd Gadd      :call easygit#add(<f-args>)
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.fileTest', ['%'])

let s:cmd_map = {
      \'javascript': 'babel-node',
      \'python': 'python',
      \'ruby': 'ruby'
      \}

function! s:ToggleMouse()
  if empty(&mouse)
    set mouse=a
  else
    set mouse=
  endif
endfunction

function! s:Execute(args)
  let dir = expand('%:p:h')
  let file = expand('%:t')
  let command = get(b:, 'command', s:cmd_map[&filetype])
  let cmd = "rewatch ".file." -c '".command." ".shellescape(file)." ".a:args." '"
  execute 'Nrun ' . cmd
endfunction

function! s:FileDir(filename)
  let file = findfile(a:filename, '.;')
  if empty(file)
    echohl Error | echon a:filename . ' not found' | echohl None
    return
  endif
  return fnamemodify(file, ':h')
endfunction

" lcd to current git root
function! s:Gcd()
  if empty(get(b:, 'git_dir', '')) | return | endif
  execute 'cd '.fnamemodify(b:git_dir, ':h')
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
      echo 'remove dict '.name
      execute 'setl dictionary-=~/.vim/dict/'.name.'.dict'
    else
      echo 'add dict '.name
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

function! s:ListVimrc(...)
  return join(map(split(globpath('~/.vim/vimrc/', '*.vim'),'\n'),
    \ "substitute(v:val, '" . expand('~'). "/.vim/vimrc/', '', '')")
    \ , "\n")
endfunction

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

function! s:EditVimrc(...)
  let p = $HOME.'/.vim/vimrc/'.(a:0 == 0 ? '.vimrc' : a:1)
  if getcwd() == $HOME.'/.vim/vimrc'
    let p = p[len(getcwd()) + 1 : ]
  endif
  execute 'edit '.p
endfunction

" Remove hidden buffers and cd to current dir
function! s:StatusReset()
  let gitdir = get(b:, 'git_dir', 0)
  if !empty(gitdir)
    let dir = fnamemodify(gitdir, ':h')
    execute 'cd '.dir
  endif
  " delete hidden buffers
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'buflisted(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&buftype') !=? 'terminal'
      silent execute 'bdelete '. buf
    endif
  endfor
endf

" Generate json from handlebars template
function! s:Jsongen()
  let file = expand('%:p')
  if &filetype !~# 'handlebars$'
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

function! s:Save()
  let file = $HOME.'/tmp.log'
  let content = getline(1, '$')
  call writefile(content, file)
endfunction
