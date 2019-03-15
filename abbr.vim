iabbrev mocah mocha
iabbrev thsi this
iabbrev slient silent
iabbrev Licence License
iabbrev accross across
iabbrev cosnt const

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAbbrs('C', 'CocConfig')
call SetupCommandAbbrs('J', 'Jest')
call SetupCommandAbbrs('CR', 'CocRestart')
call SetupCommandAbbrs('Co', 'Copy')
call SetupCommandAbbrs('D', 'Dict')
call SetupCommandAbbrs('B', 'BlogNew')
call SetupCommandAbbrs('T', 'tabe')
call SetupCommandAbbrs('Gd', 'Gvdiff')
call SetupCommandAbbrs('Gst', 'Denite gitstatus')
call SetupCommandAbbrs('Gp', 'Gpush')
call SetupCommandAbbrs('Gci', 'Gcommit -v')
call SetupCommandAbbrs('Gca', 'Gcommit -a -v')
call SetupCommandAbbrs('Gcaa', 'Gcommit --amend -a -v')
call SetupCommandAbbrs('Gco', 'Gcheckout')
call SetupCommandAbbrs('Grm', 'Gremove')
call SetupCommandAbbrs('Gmv', 'Gmove')
call SetupCommandAbbrs('L', 'CocList')
call SetupCommandAbbrs('U', 'UltiSnipsEdit')
call SetupCommandAbbrs('P', 'Preview')
call SetupCommandAbbrs('F', 'Format')
call SetupCommandAbbrs('N', 'Note')
call SetupCommandAbbrs('A', 'TodoAdd')
call SetupCommandAbbrs('R', 'NpmRun')
call SetupCommandAbbrs('M', 'Mouse')
call SetupCommandAbbrs('E', 'EditVimrc')
call SetupCommandAbbrs('S', 'RenameSearch')
call SetupCommandAbbrs('Ex', 'Execute')
call SetupCommandAbbrs('Ns', 'NoteSearch')
call SetupCommandAbbrs('Done', 'Unite todo:done')

" vim: set sw=2 ts=2 sts=2 et tw=78;
