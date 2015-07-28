set nocompatible
filetype off
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin("~/.nvim/bundle")

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
"Plugin 'benekastah/neomake'
Plugin 'majutsushi/tagbar'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-dispatch'
Plugin 'Shougo/unite.vim'
Plugin 'valgrind.vim'
Plugin 'bruno-/vim-man'
Plugin 'beyondmarc/hlsl.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'sjl/gundo.vim'
Plugin 'a.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()
set nocp
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

let g:vtoCommDictNew={ 'lua' : '--', 'vala' : '//', 'tex' : '%' }
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
let g:valgrind_arguments=''
let g:task_rc_override = 'rc.defaultwidth=0'
let g:task_rc_override = 'rc.defaultheight=0'

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
set backspace=2
set wildignore=.*~,.*.swp
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap j gj
nnoremap k gk
nmap K <Plug>(Man)
inoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap ; :

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Explore | endif
autocmd BufRead,BufNewFile *.c,*.cpp,*.h :TagbarOpen
au BufRead,BufNewFile *.actr,*.lev,*.pmt setfiletype xml

nmap <F4> :AuthorInfoDetect<cr>
if findfile("makefile", getcwd()) == "makefile"
    nmap <F5> :wa<cr>:silent Make -j8<cr>
elseif &ft == "cpp" || &ft == "c"
    nnoremap <F5> :w<cr>:!gcc -g -std=c11 -Wall % && ./a.out<cr>
endif
"nmap <F5> :wa<cr>:Neomake!<cr>
nmap <F8> :TagbarToggle<CR>
map <C-n> :Explore<cr>
nnoremap <leader><space> :noh<cr>