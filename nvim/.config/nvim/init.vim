"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/home/df458/.config/nvim/.nvim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/home/df458/.config/nvim/.nvim'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('tomasr/molokai')
call dein#add('Raimondi/delimitMate')
call dein#add('cbracken/vala.vim', {'on_ft' : 'vala'})
call dein#add('itchyny/lightline.vim')    "Pretty and functional statusline
call dein#add('scrooloose/syntastic')     "Automatic syntax checker
call dein#add('tpope/vim-vinegar')        "Greatly improves NetRW and makes it useful as a general-purpose file browser/manager
call dein#add('tpope/vim-dispatch')       "Asynchronous builds and tests, courtesy of tmux
call dein#add('Shougo/unite.vim')        "A very powerful and scary plugin. Someday, I'll learn it...
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('bruno-/vim-man')           "Adds :Man command, for reading man pages in vim
call dein#add('tikhomirov/vim-glsl')      "Adds GLSL syntax highlighting
call dein#add('a.vim', {'on_ft' : ['c', 'cpp']})                    "Adds :A* commands, for opening header/source files
call dein#add('matze/vim-tex-fold', {'on_ft' : 'tex'})       "Latex folding
call dein#add('haya14busa/incsearch.vim') "Improved incremental search
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-clang', {'on_ft' : ['c', 'cpp']})
call dein#add('godlygeek/tabular')        "Easy text alignment
call dein#add('wellle/targets.vim')       "Extends vim's text objects to allow for some speedy cursor warping
call dein#add('tomtom/tcomment_vim')      "A wonderful plugin for commenting stuff out
call dein#add('embear/vim-localvimrc')    "Allows for project-local vim configuration
call dein#add('juleswang/css.vim', {'on_ft' : 'css'})        "CSS3 support
call dein#add('othree/html5.vim', {'on_ft' : 'html'})         "HTML5 support
call dein#add('pangloss/vim-javascript', {'on_ft' : 'javascript'})  "Javascript support

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

let g:vtoCommDictNew={ 'lua' : '--', 'vala' : '//', 'tex' : '%' } "Add additional comment strings
let g:airline#extensions#tabline#enabled=1                        "Enable the airline tabline
let g:airline_powerline_fonts=1                                   "Enable powerline fonts in airline
let g:syntastic_check_on_open = 1                                 "Check for syntax errors on open
let g:syntastic_check_on_wq = 0                                   "Don't bother checking syntax when exiting
let g:syntastic_cpp_check_header = 1                              "Check header files
let g:syntastic_cpp_no_include_search = 1                         "Don't search includes
let g:syntastic_cpp_no_default_include_dirs = 1                   "Don't check default include dirs
let g:syntastic_cpp_auto_refresh_includes = 1                     "Update includes on write
let g:syntastic_cpp_compiler_options = '-std=c++0x'               "Assume c++0x (c++11) code
let g:syntastic_mode_map = { "mode": "active",
                           \ "passive_filetypes": ["vala"] }      "Disable vala syntax checking, because it's pretty awful
let g:vimfiler_as_default_explorer = 1
let vala_comment_strings = 1                                      "highlight strings in vala comments
" let g:promptline_preset = {
"    \'a' : ['%n'],
"    \'b' : [promptline#slices#cwd()],
"    \'c' : [promptline#slices#vcs_branch()],
"    \'warn' : [promptline#slices#last_exit_code()]}
" let g:tmuxline_preset = {
"    \'a' : '#S',
"    \'b'    : '#W',
"    \'win'  : '#I #W',
"    \'cwin' : '#W',
"    \'y'    : '%a %R'}

let g:lightline = {
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

let g:tex_fold_enabled=1                                            "Fold TeX/LaTeX code
let g:tex_fold_sec_char='+'                                         "Prepend the section foldtext with a +
let g:tex_fold_env_char='*'                                         "Prepend the environment foldtext with a *
let g:tex_conceal='abdmgs'                                          "Trasform many common symbols into their unicode
                                                                    "variants when the cursor is on a different line.
let g:tex_fold_additional_envs=['document', 'enumerate', 'itemize'] "Fold document, enumerate, and itemize LaTeX blocks

let g:localvimrc_ask=0 "Don't ask every time a local vimrc is found.
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'

syntax enable
colorscheme molokai
let mapleader="\<tab>"              "Sets the leader key to Tab

set aw                              "Autosave files when certain commands are used
set backspace=2                     "Backspace works over autoindents, line endings, and insert start
set bri                             "Wrapped lines are indented up to the previous line
set cin                             "Automatic indenting in C files
set cino=s,e0,n0,f0,{0,}0,^0,L-1,:s,=s,l0,b1,g0,hs,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,J0,)20,*70,#0
                                    "In addition to the vim defaults:
                                    "Place break statements at the same indentation as their respective case
                                    "Don't indent C++ public/private labels
                                    "Add 2 spaces to denote continued lines
set cf                              "Ask to save when performing certain actions
set cc=80                           "Highlight the wrap point on lines
set cot=menu                        "Display a menu with completions
set cole=2                          "Completely hide concealed text, unless a replacement is specified
set cuc                             "Highlight the cursor's column
set cul                             "Highlight the cursor's row
set dy=uhex                         "Display hex characters by their code, when they have no associated character
set enc=utf-8                       "Set the default encoding to utf-8
set et                              "Insert spaces, not tabs
set fcs=vert:┊,fold:┈               "Set the fill for vertical splits and folds"
set fcl=all                         "Close folds when you aren't in them
set fdc=3                           "Add a 3-wide column with fold information
set fdm=syntax                      "By default, fold based on syntax
set fo=qrn1                         "Enable 'gq' to format comments, automatically add *s to multiline comments
set gd                              "By default, set the g substitute flag. This subs all matches per line, not just the first
set ic                              "Disable case-sensitive searching
set is                              "Enable incremental searching
set hls                             "Highlight all search matches
set noshowmode                      "Hide mode information (lightline provides this)
set ls=2                            "Always display the statusline
set nu                              "Display line numbers
set rnu                             "Display line numbers relative to the cursor position
set ru                              "Display the ruler
set scs                             "Enable case-sensitive searches if the pattern contains upper-case letters
set so=6                            "Keep at least 6 lines visible above and below the cursor
set sr                              "Round indents to a multiple of sw
set sw=4                            "Indents are 4 spaces wide
set sbr=→\                          "Display '→ ' in front of a wrapped line
set si                              "Use smart indenting
set ts=4                            "Tab is 4 spaces
set title                           "Change the window title of the terminal to be more descriptive
set titlestring=nvim                "Perform compton-based Dark Magick to make my terminal opaque when neovim is running
set titleold=st                     "Sets the window title to my most-used terminal if nvim couldn't preserve it
set tw=79                           "Sets the width to 79 characters
set tf                              "Indicates that the terminal connection is fast, so more characters should be changed
set udf                             "Save undo history across sessions
set ve=block                        "Allow editing things that don't exist in VISUAL BLOCK mode
set wig=*.o,*.depend,*.un~,*.swp    "Ignore these files, and don't display them in NetRW
set wmnu                            "Enable Wildmenu, giving enhanced tab-completion of commands
set wim=list:longest                "When completing commands, list all matches and complete as much common text as possible
set wrap                            "Wrap text
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1   "Enable true color display
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 "Changes the cursor shape in insert mode

"Prevent arrow key use in normal mode
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>

"Remove the a.vim insert mode leader combos
"This allows us to map leader (tab, in my case) to scroll through completions
"without lag.
function! UnmapInsertLeader()
    silent! iunmap <Leader>ih
    silent! iunmap <Leader>is
    silent! iunmap <Leader>ihn
endfunction
au Filetype c,cpp :call UnmapInsertLeader()
" au Filetype cpp :call UnmapInsertLeader()
inoremap <expr><tab> pumvisible() ? '<down>' : '<tab>'

"Pressing K on a word opens the respective manpage for it
nmap K <Plug>(Man)
"Allows ; instead of : for commands
nnoremap ; :

"Incsearch remaps
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"Automatically align code with 3 keypresses
"Left-align by = signs
nmap<leader>a= :Tabularize /=<cr>
vmap<leader>a= :Tabularize /=<cr>

"Left-align by commas
nmap<leader>a, :Tabularize /,\zs<cr>
vmap<leader>a, :Tabularize /,\zs<cr>

"Left-align the last word of each line
nmap<leader>a. :Tabularize /.* \+/<cr>
vmap<leader>a. :Tabularize /.* \+/<cr>

"When not opening a file, show NetRW for your current directory
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | Explore | endif

"When opening .md files, set the filetype to markdown
au BufNewFile,BufReadPost *.md set filetype=markdown

"Don't screw up folds when inserting text that might affect them, until
"leaving insert mode. Foldmethod is local to the window. Protect against
"screwing up folding when switching between windows.
au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

"Press F5 to perform a non-blocking compile
nmap <F5> :wa<cr> :Make -j8<cr>

"Press tab followed by space to hide all search highlights
nnoremap <leader><space> :noh<cr>

"Utility function to convert a Shift-JIS encoded file to UTF-8 and save it
function! SJIS2UTF()
    :e! ++enc=sjis
    :w! ++enc=utf-8
endfunction

" Unite stuff
nnoremap <Leader>q :Unite<cr>
