" Break backwards vi compatibility
set nocompatible

" Enable syntax highlighting
syntax enable
set t_Co=256
colorscheme sierra

" Sets displaying line numbers "
set nu

" Set 7 lines to the cursor - when moving vertically using j/k
set so=5

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Always show the status line
set laststatus=2

" " Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %


" Vundle Setup

filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'flazz/vim-colorschemes'
Plugin 'mileszs/ack.vim'
Plugin 'Valloric/MatchTagAlways'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'git://github.com/tpope/vim-abolish.git'
Plugin 'tpope/vim-obsession'
Plugin 'sbdchd/neoformat'
" Plugin 'easymotion/vim-easymotion' moze kiedys

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'fatih/vim-go'
Plugin 'elixir-lang/vim-elixir'
Plugin 'elmcast/elm-vim'


" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required


" Ack/The Silver Searcher
let g:ackprg = 'ag --nogroup --nocolor --column'


" NERDTree

" Bind CTRL+n to open files tree
map <C-n> :NERDTreeToggle<CR>

" Show hidden files
let NERDTreeShowHidden = 1

" Automatically open NerdTree when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


" CtrlP

" Ignore .gitignore files in CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


" Neoformat

" Format all files on save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * Neoformat
" augroup END


" Go
let g:go_disable_autoinstall = 0
let g:go_get_update = 0

" Highlight
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1

let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 0
let g:go_fmt_fail_silently = 1
let g:go_play_open_browser = 0


" Elm
let g:elm_format_autosave = 1
autocmd BufWritePost *.elm ElmMake

