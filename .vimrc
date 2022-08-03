" Defaults
" --------------
filetype off     
" filetype plugin indent on
filetype plugin on
syntax on

set foldmethod=indent
set foldlevel=99
set encoding=utf-8
set nocompatible 
set number
set ttyfast
set tabstop=4 
set shiftwidth=4
set smarttab
set smartcase
set expandtab
set autoindent
set scrolloff=10
set clipboard=unnamed
set nowrap
set incsearch
set ignorecase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set noshowmode
set nocursorline
set nocursorcolumn

set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx


" Keymaps
" ---------------
" the leader key.
let mapleader = ","

" Jumping over words with CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <S-up>
noremap <c-down> <c-down>
noremap <c-left> <c-left>
noremap <c-right> <c-right>

" Moving Lines with alt + up and alt + down
nnoremap <A-up> :m -2 <CR>
nnoremap <A-down> :m +1 <CR>

" Plugin
" ---------------
call plug#begin()
	
	" NerdTree Plugins
	Plug 'preservim/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'PhilRunninger/nerdtree-buffer-ops'
	Plug 'PhilRunninger/nerdtree-visual-selection'
    Plug 'scrooloose/nerdtree'

	Plug 'terryma/vim-multiple-cursors' " Multiple Cursors
	Plug 'tmhedberg/SimpylFold' 	    " Fold Option
	Plug 'vim-scripts/indentpython.vim' " Python indenter
	Plug 'Valloric/YouCompleteMe'       " AutoCompleter
	Plug 'vim-syntastic/syntastic'      " Syntax Checker
	Plug 'tomasiser/vim-code-dark'      " Color Scheme code-dark

    Plug 'mattn/emmet-vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'metakirby5/codi.vim'
call plug#end()


" Set Colorscheme
if has('gui_running')
    set background=dark
    colorscheme codedark
else
    colorscheme codedark
endif




" NerdTree
" -----------------
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" n indent onStart NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

let NERDTreeHighlightCursorline=0

" Multiple Curors
" ------------------
let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

" YouCompleteMe
" -------------
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Status Line
" -------------
let g:airline_theme='angr'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

let airline#extensions#ale#show_line_numbers = 1

"-------------

" Python
" -------------
au BufNewFile,BufRead *.py
    \ set tabstop=4 
"    \ set softtabstp=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
    \ match BadWhitespace /\s\+$/ 

au BufNewFile,BufRead *.pyw,*.c,*.h match BadWhitespace /\s\+$/ 
 
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let python_highlight_all=1
"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Map the F5 key to run a Python script inside Vim.
" I map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>



" JS, HTML, CSS, SASS, SCSS
" -------------------------
"au BufNewFile,BufRead *.js, *.html, *.css, *.sass, *.scss
"    \ set tabstop=2
"    \ set softtabstop=2
"    \ set shiftwidth=2

" Vim Script
" --------------
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END 


if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
 
