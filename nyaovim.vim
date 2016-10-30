if !exists('g:nyaovim_version') | finish | end

set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
