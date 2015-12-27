" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:

" vim-test {{
let g:test#javascript#mocha#file_pattern = '\.js'
function! s:StartTest(cmd)
  execute 'Start ' . a:cmd
endfunction

let g:test#custom_strategies = {'start': function('s:StartTest')}
let g:test#strategy = 'start'
" }}

" jscheck {{
let g:jscheck_debug_mode = 1
" }}

" syntastic {{
let g:syntastic_always_populate_loc_list=1
let g:syntastic_enable_balloons = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_warning_symbol='⚠'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["vim", "ruby", "php"],
    \ "passive_filetypes": ["javascript", "html"] }
let g:syntastic_vim_checkers = ['vint']
" }}

" vim-session {{
let g:session_default_overwrite =1
let g:session_default_to_last=1
let g:session_command_aliases = 1
let g:session_menu = 0
let g:session_autosave='yes'
let g:session_autoload='yes'
" }}

" gist-vim {{
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1
" }}

" easy motion {{
let g:EasyMotion_leader_key = '\\'
"nnoremap \\ <Plug>(easymotion-prefix)
" }}

" VimCompletesMe {{
let g:vcm_direction = 'n'
" }}

" tagbar {{
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
    \ 'h:Heading_L1',
    \ 'i:Heading_L2',
    \ 'k:Heading_L3'
  \ ]
\ }
" }}

" ultisnips {{
  let g:UltiSnipsExpandTrigger='<C-j>'
  let g:UltiSnipsJumpForwardTrigger='<C-j>'
  let g:UltiSnipsJumpBackwardTrigger='<C-k>'
  let g:UltiSnipsEditSplit='vertical'
" }}

" Netrw {{
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" }}

" ctrlsf {{
let g:ctrlsf_width = '50%'
" }}

" vim-notes {{
let g:notes_directories = ['~/Documents/notes']
let g:notes_title_sync = 'yes'
" }}

" vim-shell {{
let g:shell_mappings_enabled = 0
" }}

" vim-gitgutter {{
let g:gitgutter_max_signs = 999
" }}

" tern_for_vim {{
let g:tern_show_argument_hints = 'on_hold'
"let g:tern_show_signature_in_pum = 1
"}}

" xml.vim {{
  let g:html_indent_inctags = 'html,body,head,tbody'
  let g:html_indent_script1 = 'inc'
  let g:html_indent_style1 = 'inc'
  let g:xml_use_xmtml = 0
" }}

" emmet {{
  " https://raw.github.com/mattn/emmet-vim/master/TUTORIAL
  " html:5
  " <c-c> Wrap with Abbreviation
  " <c-y>a Make anchor from URL
  " <c-y>A Make quoted text from URL
  let g:user_emmet_expandabbr_key = '<D-y>'
  let g:user_emmet_next_key = '<C-y>n'
  let g:user_emmet_prev_key = '<C-y>N'
  "注释
  let g:user_emmet_togglecomment_key = '<C-y>/'
  "内部全选
  let g:user_emmet_balancetaginward_key = '<C-y>i'
  let g:user_emmet_balancetagoutward_key = '<C-y>o'
  let g:user_emmet_mode='a'
  let g:user_emmet_settings = webapi#json#decode(
  \  join(readfile(expand('~/.vim/emmit.json')), "\n"))
" }}

" jsdoc settings {{
  let g:jsdoc_allow_input_prompt = 0
  let g:jsdoc_enable_es6 = 1
  let g:jsdoc_access_descriptions = 2
  let g:jsdoc_custom_args_hook = {
  \ 'callback\|cb': {
  \   'type': ' {Function} ',
  \   'description': 'Callback function'
  \ },
  \ 'n': {
  \   'type': ' {Number} '
  \ },
  \ 'arr': {
  \   'type': ' {Array} '
  \ },
  \ 'str': {
  \   'type': ' {String} '
  \ },
  \ 'el$': {
  \   'type': ' {Element} '
  \ },
  \ 'e': {
  \   'type': ' {Event} '
  \ },
  \ 'node': {
  \   'type': ' {Element} '
  \ },
  \ 'obj': {
  \   'type': ' {Object} '
  \ },
  \ 'fn': {
  \   'type': ' {Function} '
  \ },
  \ 'cb': {
  \   'type': ' {Function} '
  \ }
  \}
" }}
