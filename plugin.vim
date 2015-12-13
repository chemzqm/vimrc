" vim-test
let test#javascript#mocha#file_pattern = '\.js'
"let test#strategy = "dispatch"

" syntastic
let g:syntastic_enable_async = 1
let g:syntastic_warning_symbol='⚠'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_check_on_wq = 0
"let g:syntastic_auto_jump = 3

" vim-session
let g:session_default_overwrite =1
let g:session_default_to_last=1
let g:session_command_aliases = 1
let g:session_menu = 0
let g:session_autosave='yes'
let g:session_autoload='yes'

" gist-vim
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1

" easy motion
let g:EasyMotion_leader_key = '\\'
"nnoremap \\ <Plug>(easymotion-prefix)

" tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
    \ 'h:Heading_L1',
    \ 'i:Heading_L2',
    \ 'k:Heading_L3'
  \ ]
\ }

" ultisnips {{
  let g:UltiSnipsExpandTrigger="<C-j>"
  let g:UltiSnipsJumpForwardTrigger="<C-j>"
  let g:UltiSnipsJumpBackwardTrigger="<C-k>"
  let g:UltiSnipsEditSplit="vertical"
" }}

" Netrw
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" ctrlsf
let g:ctrlsf_width = '50%'

" vim-notes
let g:notes_directories = ['/Users/chemzqm/Documents/notes']
let g:notes_title_sync = 'yes'

" vim-shell
let g:shell_mappings_enabled = 0

" vim-gitgutter
let g:gitgutter_max_signs = 9999

" nerdcommenter
let g:NERDSpaceDelims = 1

" tern_for_vim
let g:tern_show_argument_hints = 'on_hold'
"let g:tern_show_signature_in_pum = 1


