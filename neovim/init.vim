" Don't try to be vi compatible
set nocompatible

" Load plugins with vim-plug
call plug#begin()
Plug 'airblade/vim-gitgutter' " Shows staged/new/deleted lines
Plug 'NLKNguyen/papercolor-theme' " Main theme
Plug 'vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes' " Has papercolor theme for status bar
call plug#end()

" Turn on syntax highlighting
syntax on

" Customize colorscheme
set background=light
colorscheme PaperColor

" Customize airline
let g:airline_theme='papercolor'

" Show line numbers
set number

" Blink cursor on error instead of beeping
set visualbell

" Whitespace config
" In general we want:
"   - Spaces over tabs
"   - Two space indents
set wrap
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noshiftround
set expandtab

" Search options
set ignorecase
set smartcase

" Set mouse support for all modes
set mouse=a

" Show tab characters and trailing whitespace
set list listchars=tab:»·,trail:·

" Stop highlighting search results after hitting the spacebar
map <Space> :noh<cr>
