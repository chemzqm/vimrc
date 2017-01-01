""" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:

" gruvbox {{
  let g:gundo_prefer_python3 = 1
" }}

" gundo.vim {{
  let g:gruvbox_italic=1
" }}

" vim-jsx-improve {{
  let javascript_plugin_jsdoc = 1
  let javascript_plugin_flow = 1
" }}

" xml.vim {{
  let g:xml_syntax_folding = 1
" }}

" unite-session {{
  let g:unite_source_session_path = expand('~') . '/.vim/sessions'
  let g:unite_source_session_options = &sessionoptions
" }}

" ale {{
  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'html': [],
  \   'css': [],
  \   'scss': [],
  \   'typescript': ['tslint'],
  \   'json': ['jsonlint'],
  \   'ruby': [],
  \}
  let g:ale_sign_error = '>>'
  let g:ale_sign_warning = '⚠'
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" }}

" gist-vim {{
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 0
  let g:gist_show_privates = 1
" }}

" ultisnips {{
  let g:UltiSnipsNoPythonWarning = 1
  let g:UltiSnipsExpandTrigger='<C-j>'
  let g:UltiSnipsJumpForwardTrigger='<C-j>'
  let g:UltiSnipsJumpBackwardTrigger='<C-k>'
  let g:UltiSnipsEditSplit='vertical'
" }}

" Netrw {{
  let g:netrw_banner=0
  let g:netrw_browse_split=4
  let g:netrw_liststyle=3
  let g:netrw_list_hide = ',\(^\|\s\s\)\zs\.\S\+'
" }}

" vim-gitgutter {{
  let g:gitgutter_max_signs = 999
" }}

" tern_for_vim {{
  let g:tern_request_timeout = 5
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern#command = ['node', expand('~').'/lib/tern/bin/tern']
  "let g:tern_show_signature_in_pum = 1
"}}

" emmet {{
  " https://raw.github.com/mattn/emmet-vim/master/TUTORIAL
  " <c-y>a Make anchor from URL
  " <c-y>A Make quoted text from URL
  let g:user_emmet_expandabbr_key = '<M-y>'
  let g:user_emmet_next_key = '<C-y>n'
  let g:user_emmet_prev_key = '<C-y>p'
  "内部全选
  let g:user_emmet_balancetaginward_key = '<C-y>i'
  let g:user_emmet_balancetagoutward_key = '<C-y>o'
  let g:user_emmet_mode='a'
  let g:emmet_html5 = 0
  let g:user_emmet_settings = {
  \ 'wxss': {
  \   'extends': 'css',
  \ },
  \ 'wxml': {
  \   'extends': 'html',
  \   'aliases': {
  \     'div': 'view',
  \     'span': 'text',
  \   },
  \   'default_attributes': {
  \     'block': [{'wx:for-items': '{{list}}','wx:for-item': '{{item}}'}],
  \     'navigator': [{'url': '', 'redirect': 'false'}],
  \     'scroll-view': [{'bindscroll': ''}],
  \     'swiper': [{'autoplay': 'false', 'current': '0'}],
  \     'icon': [{'type': 'success', 'size': '23'}],
  \     'progress': [{'precent': '0'}],
  \     'button': [{'size': 'default'}],
  \     'checkbox-group': [{'bindchange': ''}],
  \     'checkbox': [{'value': '', 'checked': ''}],
  \     'form': [{'bindsubmit': ''}],
  \     'input': [{'type': 'text'}],
  \     'label': [{'for': ''}],
  \     'picker': [{'bindchange': ''}],
  \     'radio-group': [{'bindchange': ''}],
  \     'radio': [{'checked': ''}],
  \     'switch': [{'checked': ''}],
  \     'slider': [{'value': ''}],
  \     'action-sheet': [{'bindchange': ''}],
  \     'modal': [{'title': ''}],
  \     'loading': [{'bindchange': ''}],
  \     'toast': [{'duration': '1500'}],
  \     'audio': [{'src': ''}],
  \     'video': [{'src': ''}],
  \     'image': [{'src': '', 'mode': 'scaleToFill'}],
  \   }
  \ },
  \}
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
  \ '^n$': {
  \   'type': ' {Number} '
  \ },
  \ '^i$': {
  \   'type': ' {Number} '
  \ },
  \ '^arr$': {
  \   'type': ' {Array} '
  \ },
  \ 'str': {
  \   'type': ' {String} '
  \ },
  \ '^e$': {
  \   'type': ' {Event} '
  \ },
  \ '^el$': {
  \   'type': ' {Element} '
  \ },
  \ '^node$': {
  \   'type': ' {Element} '
  \ },
  \ '^o$': {
  \   'type': ' {Object} '
  \ },
  \ '^obj$': {
  \   'type': ' {Object} '
  \ },
  \ '^fn$': {
  \   'type': ' {Function} '
  \ },
  \ '^cb$': {
  \   'type': ' {Function} '
  \ }
  \}
" }}

" easygit {{
  let g:easygit_enable_command = 1
  let g:easygit_auto_lcd = 1
"}}

" html5.vim {{
  let g:html5_event_handler_attributes_complete = 0
  let g:html5_rdfa_attributes_complete = 0
  let g:html5_microdata_attributes_complete = 0
  let g:html5_aria_attributes_complete = 0
" }}

" dash.vim {{
  let g:dash_map = {
  \ 'javascript': ['javascript', 'NodeJS'],
  \ 'html': ['html', 'svg'],
  \}
" }}

" macdown.vim {{
  let g:macdown_marked_programme = 'misaka'
" }}

" vim-v2ex {{
  let g:v2ex_render_comment = 1
" }}

" macnote.vim {{
  let g:macnote_unite_quickfix = 1
" }}

" redismru.vim {{
  let g:redismru_disable_auto_validate = 1
" }}

" vim-stay {{
  "let g:volatile_ftypes = ['scss', 'css']
" }}

" vim-flow {{
  "let g:flow#autoclose = 1
" }}
