syntax enable
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
:set tags+=tags
colorscheme gruvbox
:set bg=dark
set nobackup
set nowritebackup
set noswapfile
" Disable visual bell
set visualbell t_vb=
" Disable startup message
set shortmess+=I

" Center on match
nnoremap n nzz
nnoremap } }zz

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

set rtp+=$HOME/.local/lib/python3.5/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
:set listchars=tab:>·,trail:~,extends:>,precedes:<
:set list
let g:powerline_pycmd = "py3"

