call denite#custom#option('default', 'prompt', '> ')
"call denite#custom#option('default', 'direction', 'bottom')
call denite#custom#option('default', 'empty', 0)
call denite#custom#option('default', 'auto_resize', 1)

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
  \ [ '.git/', '.ropeproject/', '__pycache__/',
  \   'images/', '*.min.*', 'bundle.js', 'img/', 'fonts/'])

" Change file_rec command.
call denite#custom#var('file_rec', 'command',
  \ ['ag', '--depth', '10', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Change grep options.
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
    \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Change file_rec matcher
call denite#custom#source(
  \ 'file_rec', 'matchers', ['matcher_cpsm'])
call denite#custom#source(
  \ 'redis_mru', 'matchers', ['matcher_fuzzy'])
call denite#custom#source(
  \ 'line', 'matchers', ['matcher_regexp'])

" Sorter of file_rec
call denite#custom#source(
  \ 'file_rec', 'sorters', ['sorter_sublime'])

" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-a>',
      \ '<denite:move_caret_to_head>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-s>',
      \ '<denite:do_action:vsplit>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-t>',
      \ '<denite:do_action:tabopen>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-d>',
      \ '<denite:do_action:delete>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ '<esc>',
      \ '<denite:quit>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'd',
      \ '<denite:do_action:delete>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-b>',
      \ '<denite:scroll_page_backwards>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-f>',
      \ '<denite:scroll_page_forwards>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-p>',
      \ '<denite:print_messages>',
      \ 'noremap'
      \)

nnoremap <silent> <space>q  :<C-u>Denite -resume<CR>
nnoremap <silent> <space>j  :call execute('Denite -resume -select=+'.v:count1.' -immediately')<CR>
nnoremap <silent> <space>k  :call execute('Denite -resume -select=-'.v:count1.' -immediately')<CR>

nnoremap <silent> <space>w  :<C-u>DeniteCursorWord  -auto-resize line<CR>
nnoremap <silent> <space>l  :<C-u>Denite -mode=normal location_list<CR>
nnoremap <silent> <space>e  :<C-u>Denite buffer<cr>
nnoremap <silent> <space>f  :<C-u>Denite file_rec<cr>
nnoremap <silent> <space>o  :<C-u>Denite outline<cr>
nnoremap <silent> <space>r  :<C-u>Denite redis_mru<cr>
nnoremap <silent> \r        :<C-u>Denite redis_mru:.<cr>
