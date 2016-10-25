let s:file_node_extensions = {
  \  'styl'     : '',
  \  'scss'     : '',
  \  'htm'      : '',
  \  'html'     : '',
  \  'erb'      : '',
  \  'slim'     : '',
  \  'ejs'      : '',
  \  'css'      : '',
  \  'less'     : '',
  \  'md'       : '',
  \  'markdown' : '',
  \  'json'     : '',
  \  'js'       : '',
  \  'jsx'      : '',
  \  'rb'       : '',
  \  'php'      : '',
  \  'py'       : '',
  \  'pyc'      : '',
  \  'pyo'      : '',
  \  'pyd'      : '',
  \  'coffee'   : '',
  \  'mustache' : '',
  \  'hbs'      : '',
  \  'conf'     : '',
  \  'ini'      : '',
  \  'yml'      : '',
  \  'bat'      : '',
  \  'jpg'      : '',
  \  'jpeg'     : '',
  \  'bmp'      : '',
  \  'png'      : '',
  \  'gif'      : '',
  \  'ico'      : '',
  \  'twig'     : '',
  \  'cpp'      : '',
  \  'c++'      : '',
  \  'cxx'      : '',
  \  'cc'       : '',
  \  'cp'       : '',
  \  'c'        : '',
  \  'hs'       : '',
  \  'lhs'      : '',
  \  'lua'      : '',
  \  'java'     : '',
  \  'sh'       : '',
  \  'fish'     : '',
  \  'ml'       : 'λ',
  \  'mli'      : 'λ',
  \  'diff'     : '',
  \  'db'       : '',
  \  'sql'      : '',
  \  'dump'     : '',
  \  'clj'      : '',
  \  'cljc'     : '',
  \  'cljs'     : '',
  \  'edn'      : '',
  \  'scala'    : '',
  \  'go'       : '',
  \  'dart'     : '',
  \  'xul'      : '',
  \  'sln'      : '',
  \  'suo'      : '',
  \  'pl'       : '',
  \  'pm'       : '',
  \  't'        : '',
  \  'rss'      : '',
  \  'f#'       : '',
  \  'fsscript' : '',
  \  'fsx'      : '',
  \  'fs'       : '',
  \  'fsi'      : '',
  \  'rs'       : '',
  \  'rlib'     : '',
  \  'd'        : '',
  \  'erl'      : '',
  \  'hrl'      : '',
  \  'vim'      : '',
  \  'ai'       : '',
  \  'psd'      : '',
  \  'psb'      : '',
  \  'ts'       : '',
  \  'jl'       : ''
\}

let s:file_node_exact_matches = {
  \  'exact-match-case-sensitive-1.txt' : 'X1',
  \  'exact-match-case-sensitive-2'     : 'X2',
  \  'gruntfile.coffee'                 : '',
  \  'gruntfile.js'                     : '',
  \  'gruntfile.ls'                     : '',
  \  'gulpfile.coffee'                  : '',
  \  'gulpfile.js'                      : '',
  \  'gulpfile.ls'                      : '',
  \  'dropbox'                          : '',
  \  '.ds_store'                        : '',
  \  '.gitconfig'                       : '',
  \  '.gitignore'                       : '',
  \  '.bashrc'                          : '',
  \  '.bashprofile'                     : '',
  \  'favicon.ico'                      : '',
  \  'license'                          : '',
  \  'node_modules'                     : '',
  \  'react.jsx'                        : '',
  \  'Procfile'                         : '',
  \  '.vimrc'                           : '',
\}

let s:file_node_pattern_matches = {
  \ '.*jquery.*\.js$'       : '',
  \ '.*angular.*\.js$'      : '',
  \ '.*backbone.*\.js$'     : '',
  \ '.*require.*\.js$'      : '',
  \ '.*materialize.*\.js$'  : '',
  \ '.*materialize.*\.css$' : '',
  \ '.*mootools.*\.js$'     : ''
\}

set tabline=%!MyTabLine()

function! GetFileIcon(path)
  let g:path = a:path
  let file = fnamemodify(a:path, ':t')
  if has_key(s:file_node_exact_matches, file)
    return s:file_node_exact_matches[file]
  endif
  for [k, v]  in items(s:file_node_pattern_matches)
    if match(file, k) != -1
      return v
    endif
  endfor
  let ext = fnamemodify(file, ':e')
  if has_key(s:file_node_extensions, ext)
    return s:file_node_extensions[ext]
  endif
  return ''
endfunction

function! MyTabLine()
  "if &buftype =~# '\v(help|nofile|terminal)' | return '' | endif
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let name = bufname(buflist[winnr - 1])
  let full_path = fnamemodify(name, ':p')
  let base = fnamemodify(full_path, ':h:h:h')
  let icon = GetFileIcon(full_path)
  if empty(name)
    return '[No Name]'
  else
    return icon.' '.fnamemodify(name, ':t')
  endif
endfunction
