" Initial setup
set nocompatible
filetype off
set rtp+=~/.config/nvim/.nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/.nvim/bundle")

" Plugin List
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'nanotech/jellybeans.vim'
Plugin 'tomasr/molokai'
Plugin 'Townk/vim-autoclose'
Plugin 'cbracken/vala.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-dispatch'
Plugin 'Shougo/unite.vim'
Plugin 'valgrind.vim'
Plugin 'bruno-/vim-man'
Plugin 'tikhomirov/vim-glsl'
Plugin 'a.vim'
Plugin 'matze/vim-tex-fold'
Plugin 'haya14busa/incsearch.vim'

" Setup over
call vundle#end()
set nocp
filetype plugin indent on

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
let g:neomake_tex_pdflatex_maker = {
    \ 'args': ['--verbose']}
let g:neomake_latex_pdflatex_maker = {
    \ 'args': ['--verbose']}
let g:neomake_latex_enabled_makers = ['pdflatex']
let g:neomake_tex_enabled_makers = ['pdflatex']

let cobol_legacy_code=1
let g:valgrind_arguments=''
let g:task_rc_override = 'rc.defaultwidth=0'
let g:task_rc_override = 'rc.defaultheight=0'
let g:tex_fold_enabled=1
let g:tex_fold_sec_char='+'
let g:tex_fold_env_char='*'
let g:tex_conceal='abdmgs'
let g:tex_fold_additional_envs=['document', 'enumerate', 'itemize']

set smartindent
set autowrite
set incsearch showmatch ignorecase smartcase hlsearch
syntax enable
"colorscheme jellybeans
colorscheme molokai
set number
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
set conceallevel=2
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
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Explore | endif
autocmd BufRead,BufNewFile *.c,*.cpp,*.h :TagbarOpen
au BufRead,BufNewFile *.actr,*.lev,*.pmt setfiletype xml
" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

"if findfile("makefile", getcwd()) == "makefile"
    "nmap <F5> :wa<cr>:silent Make -j8<cr>
"elseif &ft == "cpp" || &ft == "c"
    "nmap <F5> :w<cr>:!gcc -g -std=c11 -Wall % && ./a.out<cr>
"else
    "au BufRead,BufNewFile *.tex nmap <F5> :w<cr>:!pdflatex %<cr>
"endif
"nmap <F5> :wa<cr> :Neomake!<cr>
"nmap <leader><F5> :wa<cr> :Neomake<cr>
nmap <F5> :wa<cr> :Make -j8<cr>
if &ft =="cpp" || &ft == "c"
    nmap <F8> :TagbarToggle<CR>
endif
nnoremap <leader><space> :noh<cr>

function! SJIS2UTF()
    :e! ++enc=sjis
    :w! ++enc=utf-8
endfunction
