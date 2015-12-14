" Git commandline alias
command! -nargs=0 -bar C :Glcd .
command! -nargs=* -bar Gc execute 'Gcommit '. expand('%').' '."<args>"
command! -nargs=* -bar Gca execute 'Gcommit -a '."<args>"
" add dictionary
command! -nargs=0 -bar Canvas execute 'setl dictionary+=~/.vim/dict/canvas.dict'
command! -nargs=0 -bar Date execute 'r !date "+\%Y-\%m-\%d \%H:\%M:\%S"'
command! -nargs=0 -bar Dom execute 'setl dictionary+=~/.vim/dict/dom.dict'
command! -nargs=0 -bar Express execute 'setl dictionary+=~/.vim/dict/express.dict'
command! -nargs=0 -bar Koa execute 'setl dictionary+=~/.vim/dict/koa.dict'
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
" remove file from filesystem
command! -nargs=0 -bar Rm execute 'call Remove()'
command! -nargs=0 -bar Reset execute 'call StatusReset()'
command! -nargs=0 -bar Standard execute '!standard --format %:p'
command! -nargs=0 -bar Emoji execute 'set completefunc=emoji#complete'
command! -bang -nargs=0 -bar Copy execute 'silent w !tee % | pbcopy > /dev/null'<bang>
" preview module files main/package.json/Readme.md
command! -nargs=1 -complete=custom,ListModules P :call PreviewModule('<args>')
command! -nargs=1 -complete=custom,ListModules J :call PreviewModule('<args>', 'json')
command! -nargs=1 -complete=custom,ListModules H :call PreviewModule('<args>', 'doc')
" L all:5 search
command! -nargs=* L :call ShowGitlog(<f-args>)
" edit vimrc files
command! -nargs=1 -complete=custom,ListVimrc E :call EditVimrc(<f-args>)
command! -nargs=* Update :call Update('<args>')

function! ListVimrc(...)
  return join(map(split(globpath('~/.vim/vimrc/', '*.vim'),'\n'),
    \ "substitute(v:val, '/Users/chemzqm/.vim/vimrc/', '', '')")
    \ , "\n")
endfunction

function! EditVimrc(file)
  execute "e ~/.vim/vimrc/" . a:file
endfunction

function! ShowGitlog(...)
  let arg = get(a:000, 0, '')
  let input = get(a:000, 1, '')
  if a:0 == 1
    let input = arg
    let arg = ''
  endif
  if arg !~# ':' | let arg = ':' . arg | endif
  execute 'Unite gitlog:' . arg . ' -input=' . input . ' -buffer-name=gitlog'
endfunction

function! ListModules(A, L, p)
  let res = system("dependencies")
  if v:shell_error | echo res | return | endif
  return res
endfunction

function! Remove()
  let file = expand('%:p')
  let buf = bufnr('%')
  execute "bwipeout " . buf
  if filereadable(file)
    call system("rm ".file)
  endif
endfunction

function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

function! StatusReset()
  let dir = fnameescape(expand('%:p:h'))
  execute "cd ".dir
  " delete hidden buffers
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
      silent execute 'bwipeout' buf
  endfor
endf

function! PreviewModule(name, ...)
  if empty(a:name) | echo "need module name" | return | endif
  if empty(a:000)
    let res = system("findmodule ".a:name)
    let file = res
  else
    let type = a:000[0]
    let res = system("moduledir ".a:name)
    if type ==? 'doc'
      let file = res . "/readme.md"
      if !filereadable(file)
        let file = res . "/Readme.md"
        if !filereadable(file)
          let file = res . "/README.md"
          if !filereadable(file)
            echo 'readme file not found'
          endif
        endif
      endif
    elseif type ==? 'json'
      let file = res . "/package.json"
    endif
  endif
  if v:shell_error | echo res | return | endif
  let h = &previewheight
  let &previewheight = 40
  execute "pedit " . file
  let &previewheight = h
  execute "normal! \<c-w>k"
endfunction

function! Update(msg)
  execute "Start " . "~/.vim/vimrc/publish '" . a:msg . "'"
endfunction
