" Install ag with `brew install ag`
" Install ripgrep with `brew install ripgrep`
let g:project_folders = ['~/wechat-dev', '~/component-dev', '~/vim-dev']
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
" buffer
call denite#custom#var('buffer', 'date_format', '')

" Change grep options.
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
    \ ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Change file_rec matcher
call denite#custom#source('file_rec,redis_mru', 'matchers', ['matcher_cpsm'])
call denite#custom#source('line', 'matchers', ['matcher_regexp'])
" Sorter of file_rec
call denite#custom#source('file_rec,outline,redis_mru,note', 'sorters', ['sorter_rank'])

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

call denite#custom#map(
      \ 'normal',
      \ '<C-j>',
      \ '<denite:wincmd:j>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ '<C-k>',
      \ '<denite:wincmd:k>',
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
      \ 'a',
      \ '<denite:do_action:add>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'd',
      \ '<denite:do_action:delete>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'r',
      \ '<denite:do_action:reset>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 's',
      \ '<denite:do_action:vsplit>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'e',
      \ '<denite:do_action:edit>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'h',
      \ '<denite:do_action:help>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'u',
      \ '<denite:do_action:update>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'normal',
      \ 'f',
      \ '<denite:do_action:find>',
      \ 'noremap'
      \)

nnoremap <silent> <space>p  :<C-u>Denite -resume<CR>
nnoremap <silent> <space>j  :call execute('Denite -resume -select=+'.v:count1.' -immediately')<CR>
nnoremap <silent> <space>k  :call execute('Denite -resume -select=-'.v:count1.' -immediately')<CR>
nnoremap <silent> <space>w  :<C-u>DeniteCursorWord  -auto-resize line<CR>
nnoremap <silent> <space>q  :<C-u>Denite -mode=normal quickfix<CR>
nnoremap <silent> <space>l  :<C-u>Denite -mode=normal location_list<CR>
nnoremap <silent> <space>g  :<C-u>Denite -mode=normal gitstatus<CR>
nnoremap <silent> <space>d  :<C-u>Denite -mode=normal todo<cr>
nnoremap <silent> <space>s  :<C-u>Denite session<cr>
nnoremap <silent> <space>u  :<C-u>Denite ultisnips:all<cr>
nnoremap <silent> <space>t  :<C-u>Denite project<cr>
nnoremap <silent> <space>a  :<C-u>Denite -mode=normal node<CR>
nnoremap <silent> <space>e  :<C-u>Denite buffer<cr>
nnoremap <silent> <space>n  :<C-u>Denite note<cr>
nnoremap <silent> <space>h  :<C-u>Denite history:all<cr>
nnoremap <silent> <space>c  :<C-u>Denite commands<cr>
nnoremap <silent> <space>f  :<C-u>Denite file_rec<cr>
nnoremap <silent> <space>o  :<C-u>Denite outline<cr>
nnoremap <silent> <space>r  :<C-u>Denite redis_mru<cr>
nnoremap <silent> \r        :<C-u>Denite redis_mru:.<cr>
