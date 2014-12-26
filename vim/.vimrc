set nocompatible
filetype off
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'nanotech/jellybeans.vim'
Plugin 'Townk/vim-autoclose'
Plugin 'cbracken/vala.vim'
Plugin 'coot/atp_vim'
Plugin 'vim-task-org'
Plugin 'farseer90718/vim-taskwarrior'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-dispatch'
Plugin 'Shougo/unite.vim'

call vundle#end()
filetype plugin indent on
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

let g:vtoCommDictNew={ 'lua' : '--', 'vala':'//' }
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_no_include_search = 1
let g:syntastic_cpp_no_default_include_dirs = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_compiler_options = '-std=c++0x'
let g:syntastic_mode_map = { "mode": "active",
                           \ "passive_filetypes": ["vala"] }
let vala_comment_strings = 1
let g:promptline_preset = {
   \'a' : ['%n'],
   \'b' : [promptline#slices#cwd()],
   \'c' : [promptline#slices#vcs_branch()],
   \'warn' : [promptline#slices#last_exit_code()]}
let g:tmuxline_preset = {
   \'a' : '#S',
   \'b'    : '#W',
   \'win'  : '#I #W',
   \'cwin' : '#W',
   \'y'    : '%a %R'}
let cobol_legacy_code=1

set smartindent
set incsearch showmatch ignorecase smartcase hlsearch
syntax enable
colorscheme jellybeans
set number
"set statusline+=%{fugitive#statusline()}
set foldmethod=syntax
set tabstop=4
set expandtab
set shiftwidth=4
set encoding=utf-8
set scrolloff=3
set wildmenu
set wildmode=list:longest
set ttyfast
set ruler
set laststatus=2
set relativenumber
set undofile
let mapleader="\<tab>"
set gdefault
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80
set t_Co=256
set breakindent
set tags=./tags,tags,~/.tags
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap j gj
nnoremap k gk
inoremap <F1> <ESC>
nnoremap <F1> :w<cr>:!gcc -g -std=c11 -Wall % && ./a.out<cr>
vnoremap <F1> <ESC>
nnoremap ; :
inoremap jj <ESC>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Explore | endif
autocmd BufRead,BufNewFile *.c,*.cpp,*.h :TagbarOpen

nmap <F4> :AuthorInfoDetect<cr>
nmap <F5> :w<cr>:silent Make -j4<cr>
nmap <F8> :TagbarToggle<CR>
map <C-n> :Explore<cr>
nnoremap <leader><space> :noh<cr>
