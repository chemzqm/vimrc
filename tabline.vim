let s:time = ''
let s:file_node_extensions = {
  \  'rust'     : '',
  \  'styl'     : '',
  \  'scss'     : '',
  \  'htm'      : '',
  \  'html'     : '',
  \  'erb'      : '',
  \  'slim'     : '',
  \  'ejs'      : '',
  \  'wxml'      : '',
  \  'css'      : '',
  \  'less'     : '',
  \  'wxss'     : '',
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
  \  'tsx'      : '',
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

let s:colors = {
  \ 'null': ['black', '#ffffff', '#000000'],
  \ 'inactive': ['#ebdbb2', 'lightgray', 'black'],
  \ 'active': ['lightgray', 'darkgray', '#000000'],
  \ 'inactive_mod': ['#458588', '#d3869d', '#000000'],
  \ 'active_mod': ['#d3869d', '#458588', '#000000'],
  \ 'inactive_ro': ['darkred', 'lightred', 'black'],
  \ 'active_ro': ['lightred', 'darkred', '#000000'],
\ }

function! s:init_colors()
  for l:a in keys(s:colors)
    for l:b in keys(s:colors)
      if s:colors[l:a][0] == s:colors[l:b][0]
        exec 'hi TabLineSep'.l:a.b.' guibg='.s:colors[l:a][0].' guifg='.s:colors[l:a][2]
      else
        exec 'hi TabLineSep'.l:a.b.' guibg='.s:colors[l:a][0].' guifg='.s:colors[l:b][0]
      endif
    endfor
    exec 'hi TabLine'.l:a.' guibg='.s:colors[l:a][0].' guifg='.s:colors[l:a][1]
  endfor
endfunction

set tabline=%!MyTabLine()

function! GetFileIcon(path)
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

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let name = bufname(buflist[winnr - 1])
  let full_path = fnamemodify(name, ':p')
  let icon = GetFileIcon(full_path)
  if empty(name)
    return '[No Name]'
  else
    return a:n . ' '. icon.' '.fnamemodify(name, ':t')
  endif
endfunction

function! CurrentTime(...)
  call jobstart("date '+%H:%M %m-%d' | tr -d '\n'", {
        \ 'stdout_buffered': 1,
        \ 'on_stdout': function('s:OnStdout')
        \})
endfunction

function! s:OnStdout(id, data, event) dict
  let s:time = get(a:data, 0, '')
endfunction

function! s:start_timer()
  if !has('nvim') | return | endif
  call CurrentTime()
  call timer_start(60000, 'CurrentTime', {'repeat': -1})
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
  let s .= ' %= '
  let s .= '%#TabLineSepnullinactive# '
  let s .= '%#TabLineSepinactiveinactive# '
  let s .= s:time
  let s .= '%#TabLineSepinactiveinactive_mod# '
  let s .= '%#TabLineSepinactive_modinactive_mod# '
  let s .= get(g:, 'coc_weather', '')
  let s .= ' % '
  return s
endfunction

call s:init_colors()
call s:start_timer()
