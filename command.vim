" vim: set sw=2 ts=2 sts=2 et tw=78:

" add dictionary
command! -nargs=0 Node       execute 'setl dictionary+=~/.vim/dict/node.dict'
command! -nargs=0 Dom        execute 'setl dictionary+=~/.vim/dict/dom.dict'
command! -nargs=0 Koa        execute 'setl dictionary+=~/.vim/dict/koa.dict'
command! -nargs=0 Canvas     execute 'setl dictionary+=~/.vim/dict/canvas.dict'
command! -nargs=0 Express    execute 'setl dictionary+=~/.vim/dict/express.dict'
command! -nargs=0 Pretty     :call s:PrettyFile()
command! -nargs=0 Jsongen    :call s:Jsongen()
command! -nargs=0 Reset      :call s:StatusReset()
command! -nargs=0 Color      :call s:HighlightColor()
command! -nargs=0 Standard   execute '!standard --format %:p'
command! -nargs=0 Prefixer   execute 'silent !autoprefixer %'
command! -nargs=0 Publish    :call s:Publish()
command! -nargs=0 SourceTest execute 'source ~/.vim/test.vim'
command! -nargs=* Update     execute "ItermStartTab! ~/.vim/vimrc/publish '<args>'"
command! -nargs=? Gitlog     :call s:ShowGitlog('<args>')
command! -bar -nargs=? Imd   :set imd | set noimd
" search with ag and open quickfix window
command! -nargs=+ -complete=file Ag call g:Quickfix('ag', <f-args>)
" preview module files main/package.json/Readme.md
command! -nargs=? -complete=custom,s:ListVimrc    EditVimrc  :call s:EditVimrc(<f-args>)

function! g:Quickfix(type, ...)
  " clear existing list
  cex []
  let pattern = s:FindPattern(a:000)
  let list = deepcopy(a:000)
  let g:grep_word = pattern[0]
  let list[pattern[1]] = shellescape(g:grep_word, 1)
  execute "silent grep! " . join(list, ' ')
  execute "silent Unite -buffer-name=quickfix quickfix"
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
    silent execute 'bwipeout' buf
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
