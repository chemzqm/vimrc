""" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0 nofen:

" vim-translate-me {{
  let g:vtm_default_mapping = 0
  let g:vtm_youdao_app_key = '67409b467378f463'
  let g:vtm_youdao_app_secret = 'njwzFZ7YTbbtkcqD4gYyIrl6utr3vA7x'
  let g:vtm_popup_window = 'floating'
  let g:vtm_default_api = 'youdao'
" }}"

" vimtex {{
  let g:vimtex_matchparen_enabled = 0
" }}

" vim-go {{
  let g:go_def_mapping_enabled = 0
" }}"

" fugitive {{
  let g:fugitive_browse_handlers = []
" }}

" vim-markdown {{
  let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'typescript']
" }}"

" vim-run {{
  let g:vim_run_command_map = {
        \'typescript': 'ts-node',
        \'javascript': 'node',
        \'python': 'python3',
        \'go': 'go run',
        \'swift': 'swift'
        \}
" }}

" echodoc {{
  let g:echodoc_enable_at_startup = 1
" }}

" plug.nvim {{
  let g:plug_rebase = 1
" }}

" npm.nvim {{
  let g:npm_project_folders = ['~/nodejs-dev', '~/component-dev', '~/react-dev']
" }}

" vim-highlightedyank {{
  let g:highlightedyank_highlight_duration = 100
" }}

" gruvbox {{
  let g:gruvbox_italic=1
" }}

" numdo.vim {{
  let g:mundo_prefer_python3 = 1
" }}

" vim-jsx-improve {{
  let javascript_plugin_jsdoc = 1
  let javascript_plugin_flow = 1
" }}

" xml.vim {{
  let g:xml_syntax_folding = 1
" }}

" ale {{
  let g:ale_linters = {
        \   'rust': [],
        \   'go': [],
        \   'vue': [],
        \   'objcpp': [],
        \   'c': [],
        \   'java': [],
        \   'javascript': [],
        \   'dart': [],
        \   'tex': [],
        \   'wxss': [],
        \   'vim': ['vint'],
        \   'markdown': [],
        \   'python': [],
        \   'html': [],
        \   'ruby': [],
        \   'scss': [],
        \   'css': [],
        \   'typescript': [],
        \   'json': [],
        \   'swift': ['swiftlint'],
        \}
  let g:ale_swift_swiftlint_use_defaults = 1
  let g:ale_warn_about_trailing_whitespace = 0
  let g:ale_sign_column_always = 1
  let g:ale_sign_error = '>>'
  let g:ale_sign_info = '💡'
  let g:ale_sign_warning = '⚠'
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" }}

" ultisnips {{
  let g:UltiSnipsExpandTrigger='<C-j>'
  let g:UltiSnipsJumpForwardTrigger='<C-j>'
  let g:UltiSnipsEditSplit='vertical'
  let g:UltiSnipsSnippetsDir='/Users/chemzqm/vim-dev/snippets/UltiSnips'
" }}

" Netrw {{
  let g:netrw_banner=0
  let g:netrw_list_hide = ',\(^\|\s\s\)\zs\.\S\+'
" }}

" vim-gitgutter {{
  let g:gitgutter_max_signs = 999
" }}

" emmet {{
  " https://raw.github.com/mattn/emmet-vim/master/TUTORIAL
  " <c-y>a Make anchor from URL
  " <c-y>A Make quoted text from URL
  let g:user_emmet_leader_key = '<C-p>'
  let g:user_emmet_expandabbr_key = '<M-y>'
  "内部全选
  let g:user_emmet_mode='a'
  let g:emmet_html5 = 0
  let g:user_emmet_settings = {
        \ 'javascript': {
        \   'extends': 'html',
        \   'attribute_name': {'class': 'className', 'for': 'htmlFor'},
        \   'empty_element_suffix': ' />',
        \ },
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
        \     'block': [{'wx:if': '{{somevalue}}'}],
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
  let g:jsdoc_underscore_private = 1
  let g:jsdoc_custom_args_regex_only = 1
  let g:jsdoc_custom_args_hook = {
  \ '^\(callback\|cb\)$': {
  \   'type': ' {Function} ',
  \   'description': 'Callback function'
  \ },
  \ '\(err\|error\)$': {
  \   'type': '{Error}'
  \ },
  \ '^\(opt\|options\)$': {
  \   'type': '{Object}'
  \ },
  \ 'handler$': {
  \   'type': '{Function}'
  \ },
  \ '^\(n\|i\)$': {
  \   'type': ' {Number} '
  \ },
  \ '^i$': {
  \   'type': ' {Number} '
  \ },
  \ '^_\?\(is\|has\)': {
  \   'type': ' {Boolean} '
  \ },
  \ '^arr$': {
  \   'type': ' {Array} '
  \ },
  \ '^str$': {
  \   'type': ' {String} '
  \ },
  \ '^e$': {
  \   'type': ' {Event} '
  \ },
  \ 'el$': {
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
  \}
" }}

" easygit {{
  "let g:easygit_enable_root_rev_parse = 0
  "let g:easygit_enable_command = 0
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

" vim-cool {{
  let g:CoolTotalMatches = 1
" }}"

" macdown.vim {{
  let g:macdown_marked_programme = 'misaka'
" }}

" macnote.vim {{
  let g:macnote_unite_quickfix = 1
" }}

" redismru.vim {{
  let g:redismru_disable_auto_validate = 1
" }}

" vim-flow {{
  "let g:flow#autoclose = 1
" }}

" coc.nvim {{
  let g:node_client_debug = 1
  "let g:coc_global_extensions = ['coc-ultisnips']
  let g:coc_watch_extensions = ['coc-snippets']
  "let g:coc_trace_client = 1
  let g:coc_node_path = '/usr/local/Cellar/node/11.14.0_1/bin/node'
  "let g:coc_node_args = ['--nolazy', '--inspect=6045']
  let g:coc_force_debug = 1
  let g:coc_auto_copen = 0
  let g:coc_filetype_map = {
        \ 'html.swig': 'html',
        \ 'wxss': 'css',
        \ }
" }}"

" indentLine {{
  let g:indentLine_fileTypeExclude = ['json', 'markdown']
  let g:indentLine_bufTypeExclude = ['help', 'terminal', 'nofile']
" }}"

" denite-extra {{
  let g:denite_source_session_path = '/Users/chemzqm/.vim/sessions'
  let tern_set_omni_function = 0
" }}"

" vim-lion {{
  let g:lion_squeeze_spaces = 1
  let g:lion_create_maps = 1
" }}"

" rename.nvim {{
  let g:rename_hl_guifg = '#ffffff'
  let g:rename_hl_guibg = '#b180a4'
  let g:rename_search_execute = 'rg'
" }}"
