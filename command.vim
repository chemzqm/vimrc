" vim: set sw=2 ts=2 sts=2 et tw=78:
command! -nargs=0 Q                                    :qa!
command! -nargs=0 V                                    :call     s:OpenTerminal()
command! -nargs=0 C                                    :call     s:Gcd()
command! -nargs=0 Todo                                 :Denite   todo
command! -nargs=0 Mouse                                :call     s:ToggleMouse()
command! -nargs=0 Pretty                               :call     s:PrettyFile()
command! -nargs=0 Jsongen                              :call     s:Jsongen()
command! -nargs=0 Reset                                :call     s:StatusReset()
command! -nargs=* Exe                                  :call     s:Execute(<q-args>)
command! -nargs=0 MakeTags                             :execute  'Nrun ctags -R .'
command! -nargs=? Gitlog                               :call     s:ShowGitlog('<args>')
command! -nargs=0 -range=%                             Prefixer  call  s:Prefixer(<line1>, <line2>)
command! -nargs=+ -complete=dir                        Rg        call  s:Grep(<f-args>)
command! -nargs=? -complete=custom,s:ListVimrc         EditVimrc :call s:EditVimrc(<f-args>)
command! -nargs=? -complete=custom,s:ListDict          Dict      :call s:ToggleDictionary(<f-args>)
command! -nargs=* -complete=custom,easygit#completeAdd Gadd      :call easygit#add(<f-args>)

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

function! s:Grep(...)
  let arguments = deepcopy(a:000)
  let opts = []
  let strs = []
  for str in arguments
    if str =~ '\v^-'
      call add(opts, str)
    else
      call add(strs, str)
    endif
  endfor
  if index(opts, '-e') < 0
    call add(opts, '-F')
  endif
  if empty(strs)
    echoerr 'No pattern found'
  endif
  let path = get(strs, 1, '')
  execute 'Denite grep:'.path.':'.join(opts, '\ ').':'.strs[0]
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

function! s:EditVimrc(...)
  if a:0 == 0
    execute 'edit ~/.vim/vimrc/.vimrc'
  else
    execute 'edit ~/.vim/vimrc/' . a:1
  endif
endfunction

" L input:[all]
function! s:ShowGitlog(arg)
  let args = split(a:arg, ':', 1)
  let input = get(args, 0, '')
  execute 'Denite -no-quit -no-empty gitlog:' . get(args, 1, '') . ' -input=' . input . ' -mode=normal'
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
    silent execute 'bdelete '. buf
  endfor
endf

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

" npm install -g prettier prettier-eslint
" npm install -g stylefmt
let g:Pretty_commmand_map = {
    \ "json": "prettier --stdin --stdin-filepath=\"t.json\"",
    \ "css": "prettier --stdin --stdin-filepath=\"t.css\"",
    \ "scss": "prettier --stdin --stdin-filepath=\"t.scss\"",
    \ "html": "prettier --stdin --stdin-filepath=\"t.html\"",
    \ "wxss": "stylefmt",
    \ "wxml": "tidy -i -q -w 160 -xml",
    \ "xml": " xmllint --format -encode utf8 -",
    \ "javascript": "prettier-eslint\ --stdin\ --no-semi\ --single-quote",
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
