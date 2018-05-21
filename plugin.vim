""" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:

" vim-prettier {{
  let g:prettier#exec_cmd_async = 1
  let g:prettier#quickfix_enabled = 0
  let g:prettier#config#use_tabs = 'false'
" }}

" autocomplete-swift {{
  autocmd FileType swift imap <buffer> <C-n> <Plug>(autocomplete_swift_jump_to_placeholder)
" }}

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

" deoplete.nvim {{
  let g:deoplete#enable_at_startup = 1
  "call deoplete#custom#option('complete_method', 'omnifunc')
  if exists('*deoplete#custom#option')
    call deoplete#custom#source('_', 'converters',
          \ ['converter_auto_delimiter', 'remove_overlap'])
    call deoplete#custom#source('omni', 'input_patterns', {
          \ 'ruby': ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::'],
          \ 'java': '[^. *\t]\.\w*',
          \ 'php': '\w+|[^. \t]->\w*|\w+::\w*',
          \ })
    call deoplete#custom#option('sources', {
          \ '_': ['buffer'],
          \ 'javascript': ['omni', 'buffer'],
          \})
  endif
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

" ale {{
  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'wxss': ['stylelint'],
  \   'vim': ['vint'],
  \   'markdown': [],
  \   'html': [],
  \   'ruby': [],
  \   'scss': [],
  \   'python': ['pylint'],
  \   'css': ['stylelint'],
  \   'typescript': ['tsserver'],
  \   'json': ['jsonlint'],
  \   'swift': ['swiftlint'],
  \}
  let g:ale_swift_swiftlint_use_defaults = 1
  let g:ale_warn_about_trailing_whitespace = 0
  let g:ale_sign_column_always = 1
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
  let g:UltiSnipsSnippetsDir='/Users/chemzqm/vim-dev/snippets/UltiSnips'
" }}

" Netrw {{
  let g:netrw_banner=0
  "let g:netrw_browse_split=4
  "let g:netrw_liststyle=3
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
  let g:easygit_enable_root_rev_parse = 0
  let g:easygit_enable_command = 1
  let g:easygit_auto_tcd = 1
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

" vim-stay {{
  let g:volatile_ftypes = ['scss', 'css']
" }}

" vim-flow {{
  "let g:flow#autoclose = 1
" }}

" asyncrun.vim {{
  let g:asyncrun_bell = 1
" }}

" LanguageClient-neovim {{
  let g:LanguageClient_devel = 1
  let g:LanguageClient_serverCommands = {
        \ 'typescript': ['javascript-typescript-stdio'],
        \ 'wxml': ['wxml-langserver', '--debug'],
        \ 'rust': ['rustup', 'run', 'stable', 'rls'],
        \ 'vue': ['vls'],
        \ }
  " Only Error in vim echo area
  let g:LanguageClient_windowLogMessageLevel = 'Error'
  let g:LanguageClient_loggingLevel = 'INFO'
  " diagnosticsEnable default to 1
  let g:LanguageClient_diagnosticsEnable = 1
  let g:LanguageClient_settingsPath = expand('~')."/.vim/settings.json"
  " loadSettings default to 1
  let g:LanguageClient_loadSettings = 1
" }}"

" indentLine {{
  let g:indentLine_fileTypeExclude = ['json']
" }}"

" denite-extra {{
  let g:denite_source_session_path = '/Users/chemzqm/.vim/sessions'
  let tern_set_omni_function = 0
" }}"

" vim-lion {{
  let g:lion_squeeze_spaces = 1
  let g:lion_create_maps = 1
" }}"

" complete.nvim {{
  let g:coc_timeout = 300
  let g:coc_ignore_git_ignore = 0
  let g:coc_use_noselect = 1
  let g:coc_chars_guifg = '#ffffff'
  let g:coc_chars_guibg = '#b180a4'
  let g:coc_increment_highlight = 1
  let g:coc_source_config = {
        \  'languageclient': {
        \    'filetypes': ['typescript', 'wxml', 'vue'],
        \    'disabled': 0,
        \  },
        \  'omni': {
        \    'filetypes': ['css', 'html', 'wxss']
        \  },
        \  'file': {
        \    'ignorePatterns': ['*.bundle.js']
        \  },
        \  'word': {
        \    'filetypes': ['markdown']
        \  },
        \  'emoji': {
        \    'filetypes': ['markdown']
        \  },
        \  'ultisnips': {
        \    'filetypes': ['vim']
        \  },
        \  'tern': {
        \    'ternRoot': expand('~/lib/tern'),
        \  },
        \}
" }}"
